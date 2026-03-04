"""
Parameter Tuning v2 - Test Different Configurations
Systematically tests window sizes and reference patterns to find optimal settings.
"""

import warnings

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from scipy import signal
from sklearn.decomposition import FastICA

warnings.filterwarnings("ignore")


def create_reference(pattern: str, length: int) -> np.ndarray:
    t = np.arange(1, length + 1)
    if pattern == "square":
        ref = signal.square(2 * np.pi * t / 40.0)
    elif pattern == "sine":
        ref = np.sin(2 * np.pi * t / 40.0)
    elif pattern == "constant":
        ref = np.ones(length)
    else:
        raise ValueError(f"Unknown pattern: {pattern}")
    return ref


def main() -> None:
    print("======================================")
    print("Parameter Tuning - Testing Configurations")
    print("======================================\n")

    # Configuration
    csv_filename = "sampled_results_10s_0.1_640.csv"
    message_start_time = 800
    message_duration = 50
    amplitude_percent = 0.001

    # Load Data
    print("Loading data...")
    try:
        data_table = pd.read_csv(csv_filename)
        if data_table.shape[1] < 2:
            raise ValueError("CSV must have at least 2 columns")
        time = data_table.iloc[:, 0].to_numpy(dtype=float)
        demand = data_table.iloc[:, 1].to_numpy(dtype=float)
    except Exception as exc:
        print(f"Error reading CSV: {exc}")
        return

    valid_idx = ~(np.isnan(demand) | np.isnan(time))
    time = time[valid_idx]
    demand = demand[valid_idx]

    print(f"✓ Loaded {len(demand)} samples\n")

    # Estimate Sample Rate
    diffs = np.diff(time)
    diffs = diffs[diffs != 0]
    if len(diffs) == 0:
        print("Error: Unable to estimate sample rate from time column")
        return
    sample_rate = float(np.median(diffs))

    start_sample = int(round(message_start_time / sample_rate))
    duration_samples = int(round(message_duration / sample_rate))
    end_sample = min(start_sample + duration_samples, len(demand))

    # Prepare Signals
    mean_demand = np.mean(demand)
    if mean_demand == 0:
        print("Error: Mean demand is zero, cannot normalize")
        return

    s1 = demand / mean_demand
    s4 = np.ones(len(demand)) * amplitude_percent
    message_pattern = amplitude_percent * signal.square(2 * np.pi * np.arange(1, duration_samples + 1) / 40.0)
    if start_sample < len(demand):
        s4[start_sample:end_sample] = message_pattern[: max(0, end_sample - start_sample)]

    mix = np.array([[1, 1], [1, 1]], dtype=float)
    x = np.vstack([s1, s4])
    y = mix @ x

    # Test Parameters
    window_sizes = [40, 60, 80, 100, 120, 140, 150]
    patterns = ["square", "sine", "constant"]
    results = []

    total_configs = len(window_sizes) * len(patterns)
    print(f"Testing {len(window_sizes)} window sizes × {len(patterns)} patterns = {total_configs} configurations\n")

    config_count = 0
    for wsize in window_sizes:
        for pattern in patterns:
            config_count += 1

            reference = amplitude_percent * create_reference(pattern, wsize)

            n_scores = max(0, len(demand) - wsize)
            detection_score = np.zeros(n_scores)
            max_cor = np.zeros(n_scores)

            for i in range(n_scores):
                try:
                    y_window = y[:, i : i + wsize + 1]
                    ica = FastICA(n_components=2, random_state=0, max_iter=500, tol=0.01)
                    ic = ica.fit_transform(y_window.T).T

                    xc1 = signal.correlate(reference, ic[0, :], mode="full")
                    xc2 = signal.correlate(reference, ic[1, :], mode="full")
                    mx1 = float(np.max(np.abs(xc1)))
                    mx2 = float(np.max(np.abs(xc2)))

                    max_cor[i] = max(mx1, mx2)
                    den = max(abs(mx1), abs(mx2))
                    if den > 0:
                        detection_score[i] = abs(mx1 - mx2) / den
                    else:
                        detection_score[i] = 0.0
                except Exception:
                    detection_score[i] = 0.0
                    max_cor[i] = 0.0

            # Find peaks
            max_detection = float(np.max(detection_score)) if len(detection_score) else 0.0
            peak_threshold = max_detection * 0.4
            min_height = max(peak_threshold, 0.2)
            peak_locs, peak_props = signal.find_peaks(
                detection_score,
                height=min_height,
                distance=10,
            )
            peaks = peak_props.get("peak_heights", np.array([]))

            if len(peak_locs) > 0:
                time_idx = np.clip(peak_locs + int(wsize / 2), 0, len(time) - 1)
                peak_times = time[time_idx]
            else:
                peak_times = np.array([])

            # Calculate detection accuracy
            expected_center = message_start_time + message_duration / 2
            if len(peak_times) > 0:
                closest_idx = int(np.argmin(np.abs(peak_times - expected_center)))
                closest_peak = float(peak_times[closest_idx])
                error = abs(closest_peak - expected_center)
                max_score = max_detection
            else:
                error = float("inf")
                max_score = max_detection
                closest_peak = float("nan")

            results.append(
                {
                    "window_size": wsize,
                    "pattern": pattern,
                    "max_score": max_score,
                    "num_peaks": int(len(peaks)),
                    "detection_error": float(error),
                    "closest_peak": closest_peak,
                    "detection_score": detection_score,
                }
            )

            error_text = f"{error:.1f} s" if np.isfinite(error) else "   N/A"
            print(
                f"Config {config_count:2d}/{total_configs}: Window={wsize:3d}, "
                f"Pattern={pattern:>8s} → Score={max_score:.4f}, Peaks={len(peaks)}, Error={error_text}"
            )

    print()

    # Find best configurations
    print("==========================================")
    print("BEST CONFIGURATIONS")
    print("==========================================\n")

    sorted_idx = np.argsort(np.array([r["detection_error"] for r in results]))

    print("Top 5 configurations (by detection accuracy):\n")
    for rank in range(min(5, len(results))):
        idx = int(sorted_idx[rank])
        result = results[idx]
        print(f"Rank {rank + 1}: Window={result['window_size']}, Pattern={result['pattern']}")
        print(f"  Max Score: {result['max_score']:.4f}")
        print(f"  Peaks Found: {result['num_peaks']}")
        if np.isfinite(result["detection_error"]):
            print(f"  Detection Error: {result['detection_error']:.1f} s")
            print(f"  Detected At: {result['closest_peak']:.1f} s")
        else:
            print("  Detection Error: No peaks found")
        print()

    # Visualization
    plt.figure(figsize=(14, 8))

    subplot_count = 0
    for rank in range(min(6, len(results))):
        idx = int(sorted_idx[rank])
        result = results[idx]

        subplot_count += 1
        plt.subplot(2, 3, subplot_count)

        score = result["detection_score"]
        score_length = len(score)

        time_for_score = time[: min(score_length, len(time))]
        if len(time_for_score) < score_length and len(time) > 0:
            pad = np.full(score_length - len(time_for_score), time[-1])
            time_for_score = np.concatenate([time_for_score, pad])
        elif len(time_for_score) > score_length:
            time_for_score = time_for_score[:score_length]

        window_centers = time_for_score + result["window_size"] / 2.0 * sample_rate

        plt.plot(window_centers, score, "b", linewidth=1)

        peak_y = float(np.max(score)) if score_length else 0.0
        plt.fill(
            [
                message_start_time,
                message_start_time + message_duration,
                message_start_time + message_duration,
                message_start_time,
            ],
            [0, 0, peak_y, peak_y],
            color="g",
            alpha=0.1,
        )

        if np.isfinite(result["detection_error"]) and result["detection_error"] < 100 and peak_y > 0:
            plt.plot(
                result["closest_peak"],
                peak_y * 0.8,
                "ro",
                markersize=10,
                markerfacecolor="r",
            )

        plt.xlabel("Time (s)")
        plt.ylabel("Score")
        plt.title(
            f"W={result['window_size']}, {result['pattern']} | Error: {result['detection_error']:.0f} s"
        )
        plt.grid(True)

        if peak_y > 0:
            plt.ylim([0, peak_y * 1.2])

    plt.suptitle("Parameter Tuning: Best 6 Configurations", fontsize=14, fontweight="bold")
    plt.tight_layout(rect=[0, 0, 1, 0.95])

    # Recommendation
    print("\n==========================================")
    print("RECOMMENDATION")
    print("==========================================\n")

    best_idx = int(sorted_idx[0])
    best_result = results[best_idx]

    print("Optimal configuration:")
    print(
        f"  Window Size: {best_result['window_size']} samples "
        f"({best_result['window_size'] * sample_rate:.1f} seconds)"
    )
    print(f"  Reference Pattern: {best_result['pattern']}")
    print(f"  Expected Detection Score: {best_result['max_score']:.4f}")
    print("\nTo use this configuration, set in DetectHiddenMessage_v2.m:")
    print(f"  window_size = {best_result['window_size']};")
    print(f"  reference_pattern = '{best_result['pattern']}';")

    if best_result["max_score"] > 0.5:
        print("\n✓ This configuration should detect the message with high confidence")
    elif best_result["max_score"] > 0.3:
        print("\n○ This configuration may detect the message with moderate confidence")
        print("  (Reduce peak_threshold to increase sensitivity)")
    else:
        print("\n✗ Detection is challenging with current settings")
        print("  Message amplitude may be below detection threshold")

    print()
    plt.show()


if __name__ == "__main__":
    main()
