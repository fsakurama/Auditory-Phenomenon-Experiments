clear;

%% select Experiment1, 2 or 3
strExperiment0 = 'Experiment:';
strExperiment(1) = {' (1) When the upper band was never closer to the tone than the lower band'};
strExperiment(2) = {' (2) When the lower band was never closer to the tone than the upper band'};
strExperiment(3) = {' (3) Your setting.'};
strExperimentQ = 'Select experiment number >>';

disp(strExperiment0);

for ne=1:3
    disp(char(strExperiment(ne)));
end

swExperiment = input(strExperimentQ);
if length(swExperiment) == 0, swExperiment = 1; end;
 
disp(' ');
disp(['===  ' strExperiment0  char(strExperiment(swExperiment)) '  ===']);

%% Making pure tone sequence
fs = 44100;   % 44.1 khz
dur = 0.6;   % 600 ms;
fp = 2000;    % 2 kHz pure tone
PtonedB = 70; % pure tone level (dB)
ptone = MUS3010PureTone(fs, dur, fp, PtonedB); % function

%% Parameter settings
freqBand   = 800; %0.8kHz
L0 = 40;  % noise spectrum level (dB SPL)
L = L0 + 10*log(freqBand); % level of noise (dB)
AmpNoise = 10^(L/20); % Amplitude of noise

%% Select
switch swExperiment
  case 1,
    close all
    MUS3010Experiment1
 
  case 2,
    MUS3010Experiment2

  case 3,
    MUS3010Experiment3

end;

disp(' ');