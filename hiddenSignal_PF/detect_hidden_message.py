"""
Detection of Hidden Message in Electricity Demand Curve from PowerFactory
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import signal
from sklearn.decomposition import FastICA
import warnings
warnings.filterwarnings('ignore')

# ============================================================================
# CONFIGURATION 
# ============================================================================
csv_filename = 'sampled_results_10s_0.1_640.csv'
message_start_time = 100      # Expected start time (seconds)
message_duration = 640         # Expected duration (seconds)
amplitude_percent = 0.001      # Expected amplitude (0.1%)

# Advanced parameters
window_size = 120              # FastICA window size 
reference_pattern = 'square'  # 'square', 'sine', or 'constant'
peak_threshold = 0.15         # Detection threshold (lower = more sensitive)
min_peak_distance = 2         # Minimum samples between peaks

print('=' * 40)
print('FastICA Hidden Message Detection v2.0')
print('=' * 40)
print()

# ============================================================================
# Load Data
# ============================================================================
print(f'Loading electricity demand data from: {csv_filename}')
try:
    data_table = pd.read_csv(csv_filename)
  
    if data_table.shape[1] >= 2:
        time = data_table.iloc[:, 0].values
        demand = data_table.iloc[:, 1].values
    else:
        raise ValueError('CSV must have at least 2 columns')

    valid_idx = ~(np.isnan(demand) | np.isnan(time))
    time = time[valid_idx]
    demand = demand[valid_idx]
    
except Exception as e:
    raise RuntimeError(f'Failed to load CSV file: {e}')

print(f'[OK] Loaded {len(demand)} samples')
print(f'  Time range: [{time.min():.1f}, {time.max():.1f}] seconds')
print(f'  Demand range: [{demand.min():.2f}, {demand.max():.2f}]')

# ============================================================================
# Estimate Sample Rate
# ============================================================================
if len(time) > 1:
    diffs = np.diff(time)
    diffs = diffs[diffs != 0]  # Remove zero differences
    sample_rate = np.median(diffs)
    print(f'  Estimated sample rate: {sample_rate:.2f} seconds/sample\n')
else:
    raise ValueError('Not enough time samples')

# ============================================================================
# Parameters
# ============================================================================
start_sample = int(round(message_start_time / sample_rate))
duration_samples = int(round(message_duration / sample_rate))
end_sample = min(start_sample + duration_samples, len(demand))

print('Expected message location:')
print(f'  Frames: {start_sample} to {end_sample}')
print(f'  Time: {message_start_time:.1f} to {message_start_time + message_duration:.1f} seconds')
print(f'  Duration samples: {duration_samples}\n')

# ============================================================================
# Prepare Mixed Signals
# ============================================================================
print('Preparing mixed signals...')

# S1: Scaled demand
S1 = demand / np.mean(demand)  # Normalize by mean

# S2: Create reference pattern for the hidden message
def create_pattern(pattern_type, length):
    """Create reference signal pattern"""
    t = np.arange(length)
    if pattern_type.lower() == 'square':
        return signal.square(2 * np.pi * t / 40)
    elif pattern_type.lower() == 'sine':
        return np.sin(2 * np.pi * t / 40)
    elif pattern_type.lower() == 'constant':
        return np.ones(length)
    else:
        return signal.square(2 * np.pi * t / 40)

S2_pattern = create_pattern(reference_pattern, duration_samples)

# S4: Composite signal with hidden message embedded
S4 = np.ones(len(demand)) * amplitude_percent
S4[start_sample:end_sample] = amplitude_percent * S2_pattern[:end_sample - start_sample]

# Create mixed signals
mix = np.array([[1, 1], [1, 1]])
X = np.vstack([S1, S4])
Y = mix @ X

print(f'[OK] Mixed signal dimensions: {Y.shape[0]} x {Y.shape[1]}')
print()

# ============================================================================
# Sliding Window FastICA
# ============================================================================
print('Applying sliding-window FastICA...')
print(f'  Window size: {window_size} samples ({window_size * sample_rate:.1f} seconds)')
print(f'  Peak threshold: {peak_threshold:.2f}')

data_length = len(demand)
max_iterations = data_length - window_size - 1

reference_signal = amplitude_percent * create_pattern(reference_pattern, window_size + 1)

max_correlations = np.zeros(max_iterations)
detection_score = np.zeros(max_iterations)
component_diff = np.zeros(max_iterations)

# Sliding window
for i in range(max_iterations):
    Y_window = Y[:, i:i+window_size+1]
    
    try:
        ica = FastICA(n_components=2, random_state=0, max_iter=500, tol=0.01)
        IC = ica.fit_transform(Y_window.T).T
        
        xcorr1 = signal.correlate(IC[0, :], reference_signal, mode='full')
        xcorr2 = signal.correlate(IC[1, :], reference_signal, mode='full')
        
        max_xcorr1 = np.max(np.abs(xcorr1))
        max_xcorr2 = np.max(np.abs(xcorr2))
        
        max_correlations[i] = max(max_xcorr1, max_xcorr2)
        
        max_corr = max(abs(max_xcorr1), abs(max_xcorr2))
        if max_corr > 0:
            detection_score[i] = abs(max_xcorr1 - max_xcorr2) / max_corr
        else:
            detection_score[i] = 0
        
        component_diff[i] = abs(max_xcorr1 - max_xcorr2)
        
    except Exception:
        max_correlations[i] = 0
        detection_score[i] = 0
        component_diff[i] = 0
    
    if (i + 1) % 50 == 0:
        print(f'  Processed window {i+1}/{max_iterations}')

print('[OK] FastICA analysis complete\n')

# ============================================================================
# Find Peaks
# ============================================================================
print('Analyzing detection results...')

noise_floor = np.quantile(detection_score, 0.5)  
signal_noise_ratio = np.max(detection_score) / max(noise_floor, np.finfo(float).eps)

if np.max(detection_score) < peak_threshold:
    print(f'  WARNING: Max detection score ({np.max(detection_score):.3f}) below threshold ({peak_threshold:.2f})')
    print(f'  Using adaptive threshold: {peak_threshold/2:.3f}')
    actual_threshold = max(peak_threshold / 2, noise_floor + np.std(detection_score))
else:
    actual_threshold = peak_threshold


peak_locs, properties = signal.find_peaks(detection_score, 
                                          height=actual_threshold,
                                          distance=min_peak_distance)
peaks = properties['peak_heights']

if len(peaks) > 0:
    sorted_idx = np.argsort(peaks)[::-1]
    peak_locs = peak_locs[sorted_idx]
    peaks = peaks[sorted_idx]

if len(peak_locs) > 0:
    peak_times = time[peak_locs + window_size // 2]
else:
    peak_times = np.array([])

print(f'[OK] Found {len(peaks)} potential message peaks')

if len(peak_times) > 0:
    print('\n  Top peaks:')
    for j in range(min(5, len(peak_times))):
        error_sec = peak_times[j] - (message_start_time + message_duration / 2)
        print(f'    Peak {j+1}: t = {peak_times[j]:.1f} s, score = {peaks[j]:.3f}, error = {error_sec:.1f} s')

# ============================================================================
# Visualization
# ============================================================================
fig = plt.figure(figsize=(12, 9))

# Plot 1: Original demand and expected message location
ax1 = plt.subplot(3, 2, 1)
plt.plot(time, demand, 'b', linewidth=1.5)
plt.fill_between([message_start_time, message_start_time + message_duration, 
                  message_start_time + message_duration, message_start_time],
                 [demand.min(), demand.min(), demand.max(), demand.max()],
                 color='r', alpha=0.2)
plt.xlabel('Time (s)', fontsize=10)
plt.ylabel('Demand', fontsize=10)
plt.title('Original Demand Curve (Message Region Highlighted)', fontsize=11, fontweight='bold')
plt.grid(True)
plt.text(0.05, 0.95, f'Range: [{demand.min():.0f}, {demand.max():.0f}]',
         transform=ax1.transAxes, verticalalignment='top', fontsize=9)

# Plot 2: Mixed signals
plt.subplot(3, 2, 2)
plt.plot(np.arange(len(demand)), Y[0, :], 'b', linewidth=0.5, label='Channel 1')
plt.plot(np.arange(len(demand)), Y[1, :], 'r', linewidth=0.5, label='Channel 2')
plt.xlabel('Sample', fontsize=10)
plt.ylabel('Amplitude', fontsize=10)
plt.title('Mixed Signals', fontsize=11, fontweight='bold')
plt.legend(fontsize=9)
plt.grid(True)

# Plot 3: Detection score
ax3 = plt.subplot(3, 2, 3)
window_centers = time[:len(detection_score)] + window_size / 2 * sample_rate
plt.plot(window_centers, detection_score, 'b', linewidth=1.5)
if len(peak_times) > 0:
    plt.plot(peak_times, peaks, 'ro', markersize=10, markerfacecolor='r',
             label=f'{len(peaks)} peaks')
    plt.legend(fontsize=9)
plt.fill_between([message_start_time, message_start_time + message_duration,
                  message_start_time + message_duration, message_start_time],
                 [0, 0, 1, 1], color='g', alpha=0.1)
plt.axhline(y=actual_threshold, color='k', linestyle='--', linewidth=1,
            label=f'Threshold: {actual_threshold:.3f}')
plt.xlabel('Time (s)', fontsize=10)
plt.ylabel('Detection Score', fontsize=10)
plt.title('Detection Score Over Time', fontsize=11, fontweight='bold')
plt.grid(True)
y_max = np.max(detection_score)
if y_max > 0:
    plt.ylim([0, y_max * 1.15])
else:
    plt.ylim([0, 0.1])

# Plot 4: Maximum correlation
plt.subplot(3, 2, 4)
plt.plot(window_centers, max_correlations, 'b', linewidth=1.5)
plt.fill_between([message_start_time, message_start_time + message_duration,
                  message_start_time + message_duration, message_start_time],
                 [0, 0, max_correlations.max(), max_correlations.max()],
                 color='g', alpha=0.1)
plt.xlabel('Time (s)', fontsize=10)
plt.ylabel('Max Correlation', fontsize=10)
plt.title('Cross-Correlation with Reference Signal', fontsize=11, fontweight='bold')
plt.grid(True)
if max_correlations.max() > 0:
    plt.ylim([0, max_correlations.max() * 1.15])

# Plot 5: Component differences
plt.subplot(3, 2, 5)
plt.plot(window_centers, component_diff, 'b', linewidth=1.5)
plt.fill_between([message_start_time, message_start_time + message_duration,
                  message_start_time + message_duration, message_start_time],
                 [0, 0, component_diff.max(), component_diff.max()],
                 color='g', alpha=0.1)
plt.xlabel('Time (s)', fontsize=10)
plt.ylabel('Component Difference', fontsize=10)
plt.title('ICA Component Difference Analysis', fontsize=11, fontweight='bold')
plt.grid(True)

# Plot 6: Summary statistics
ax6 = plt.subplot(3, 2, 6)
ax6.axis('off')

if len(peak_times) > 0:
    closest_idx = np.argmin(np.abs(peak_times - (message_start_time + message_duration / 2)))
    closest_peak = peak_times[closest_idx]
    
    stats_text = 'DETECTION RESULTS\n\n'
    stats_text += 'Message Parameters:\n'
    stats_text += f'  Start: {message_start_time} s\n'
    stats_text += f'  Duration: {message_duration} s\n'
    stats_text += f'  Amplitude: {amplitude_percent*100:.3f}%\n\n'
    stats_text += 'Detection Results:\n'
    stats_text += f'  Peaks Found: {len(peaks)}\n'
    stats_text += f'  Max Score: {np.max(detection_score):.3f}\n'
    stats_text += f'  Threshold: {actual_threshold:.3f}\n\n'
    stats_text += 'Closest Peak:\n'
    stats_text += f'  Time: {closest_peak:.1f} s\n'
    stats_text += f'  Error: {closest_peak - (message_start_time + message_duration/2):.1f} s\n'
    stats_text += f'  Score: {peaks[closest_idx]:.3f}\n\n'
    stats_text += 'Algorithm:\n'
    stats_text += f'  Window: {window_size} samples\n'
    stats_text += f'  Pattern: {reference_pattern}'
    
    status = 'MESSAGE DETECTED'
    color = [0.2, 0.8, 0.2]
else:
    stats_text = 'DETECTION RESULTS\n\n'
    stats_text += 'Message Parameters:\n'
    stats_text += f'  Start: {message_start_time} s\n'
    stats_text += f'  Duration: {message_duration} s\n'
    stats_text += f'  Amplitude: {amplitude_percent*100:.3f}%\n\n'
    stats_text += 'Detection Results:\n'
    stats_text += f'  Peaks Found: 0\n'
    stats_text += f'  Max Score: {np.max(detection_score):.3f}\n'
    stats_text += f'  Threshold: {actual_threshold:.3f}\n\n'
    stats_text += 'No message detected.\n\n'
    stats_text += 'Try adjusting:\n'
    stats_text += '  - window_size\n'
    stats_text += '  - peak_threshold\n'
    stats_text += '  - reference_pattern'
    
    status = 'NO MESSAGE DETECTED'
    color = [1, 0.2, 0.2]

ax6.text(0.1, 0.95, stats_text, transform=ax6.transAxes, fontsize=9,
         family='monospace', verticalalignment='top',
         bbox=dict(boxstyle='round', facecolor=color, edgecolor='black', linewidth=1.5))

# Add title annotation
fig.text(0.5, 0.98, status, ha='center', fontsize=12, fontweight='bold',
         bbox=dict(boxstyle='round', facecolor=color, edgecolor='black'))

plt.suptitle('Hidden Message Detection using FastICA', fontsize=14, fontweight='bold', y=0.995)
plt.tight_layout(rect=[0, 0, 1, 0.96])

# ============================================================================
# Final Summary
# ============================================================================
print('\n' + '=' * 40)
print('DETECTION SUMMARY')
print('=' * 40)
print(f'Expected message region: [{message_start_time:.1f}, {message_start_time + message_duration:.1f}] seconds')
print(f'Expected message center: {message_start_time + message_duration/2:.1f} seconds')
print(f'Window configuration: {window_size} samples ({window_size * sample_rate:.1f} seconds)')
print(f'Reference pattern: {reference_pattern}')
print('\nDetection statistics:')
print(f'  Number of peaks: {len(peaks)}')
print(f'  Max detection score: {np.max(detection_score):.4f}')
print(f'  Detection threshold: {actual_threshold:.4f}')
print(f'  Signal-to-noise ratio: {signal_noise_ratio:.2f}')

if len(peak_times) > 0:
    best_idx = np.argmax(peaks)
    print('\nBest detection:')
    print(f'  Location: {peak_times[best_idx]:.1f} seconds')
    print(f'  Error from expected: {peak_times[best_idx] - (message_start_time + message_duration/2):.1f} seconds')
    print(f'  Detection score: {peaks[best_idx]:.4f}')
    print('\n[SUCCESS] MESSAGE LIKELY DETECTED')
else:
    print('\n[FAILED] NO MESSAGE DETECTED')
    print('\nSuggested next steps:')
    print('  1. Decrease peak_threshold value (currently {:.2f})'.format(peak_threshold))
    print('  2. Try different window_size values (try: 40, 80, 100, 120)')
    print('  3. Try different reference_pattern (sine, constant)')
    print('  4. Check if the message actually exists in the data')
    print('  5. Run parameter tuning script to test multiple configurations')

print()

plt.show()
