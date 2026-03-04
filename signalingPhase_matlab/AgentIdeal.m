clearvars -except DataSpain
X = 1000; % You can change this to any desired number of elements

% Define the mean and standard deviation for the normal distribution
mu = 10; % Mean
sigma = 0; % Standard deviation
lambda = 0; % Adjust this value as needed
p= 1; % this p is probability of success for the binomial distribution

% Generate the normal distribution vector
amplitude_values = mu + sigma.*randn(1, X);
response_values = poissrnd(lambda, 1, X);
SpeedUnit = 0.1; %time to reach amplitude
response_time = SpeedUnit.*response_values;

%Agent parameters on a matrix
Agent = [amplitude_values
         response_time];

%preparing values of secret vector
measuring_time = [0:SpeedUnit:1];
time_lapse = length(measuring_time);
demand(1:time_lapse+1) = zeros;

%generation of realistic secret
cumulative=0;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

FunctioningDev;
TurningOnDev;

FunctioningDev;
TurningOffDev;

plot(secret, "LineWidth", 2)
ylim([-100,10400])
xlim([0,300])

secretIdeal= secret;

% Plot the distribution to visualize
%figure;
%histogram(amplitude_values, 50); % Histogram with 50 bins
%title('Histogram of Normal Distribution of Amplitude Values');
%xlabel('Amplitude');
%ylabel('Frequency');