% Pure tone function
function [ptone] = MUS3010PureTone(fs, dur, fp, PtonedB)

AmpPtone = 10^(PtonedB/20); % Amplitude of pure tone
ptone1 = AmpPtone * sin(2*pi*fp*((0:dur*fs-1)/fs));

dur1 = 0.1; % fade in (100 ms)
dur2 = 0.1; % fade out (100 ms)
Ns = floor(dur*fs); % number of sample
N1 = floor(dur1*fs);
N2 = floor(dur2*fs);

env = [(0:N1-1)/N1 ones(1,Ns-N1-N2) ((N2-1):-1:0)/N2];
ptone = env.*ptone1; % apply envelope