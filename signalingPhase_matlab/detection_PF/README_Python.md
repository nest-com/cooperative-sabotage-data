# FastICA Hidden Message Detection

## Installation

```bash
pip install -r requirements.txt
```

## Usage

```bash
python detect_hidden_message.py
```

## Configuration

Edit the configuration section at the top of `detect_hidden_message.py`:

```python
csv_filename = 'sampled_results_10s_0.1_640.csv'
message_start_time = 100        # Expected start time (seconds)
message_duration = 640          # Expected duration (seconds)
amplitude_percent = 0.001       # Expected amplitude (0.1%)
window_size = 40                # FastICA window size
reference_pattern = 'square'    # 'square', 'sine', or 'constant'
peak_threshold = 0.05           # Detection threshold
min_peak_distance = 2           # Minimum samples between peaks
```

## Output

The script will:
- Load and analyze your CSV data
- Apply sliding-window FastICA
- Detect peaks in the detection score
- Display 6 plots showing:
  1. Original demand curve with message region
  2. Mixed signals
  3. Detection score over time with peaks
  4. Cross-correlation with reference signal
  5. ICA component differences
  6. Summary statistics
- Print detection summary to console
