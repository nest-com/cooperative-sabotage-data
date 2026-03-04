

Description of the files:
"demandCurve_1hour_events.csv": RMS load events for PowerFactory to simulate the load curve
"rms_events_10s_0.1_640.csv": RMS load events for PowerFactory to simulate the hidden signal
"sampled_results_10s_0.1_640.csv": PowerFactory aggregated demand after simulating both the demand curve events and the hidden signal events. Sampled every 4 seconds as in a control center. 


Python script "detect_hidden_message.py" runs FastICA algorithm with "sampled_results_10s_0.1_640.csv" in order to detect the hidden signal.