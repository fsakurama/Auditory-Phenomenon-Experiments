% Lower noise band function

function [noiseLow] = MUS3010LowerNoiseBand(fs, leng, freqLowMin, freqLowMax)

if freqLowMax<=0 % Lower noise band doesn't exist
    
    noiseLow = zeros(1,leng);
                
elseif freqLowMin<=0 && freqLowMax>0 % change freqLowMin into 0 → same as lowpass
    filterLowSpecs = fdesign.lowpass('Fp,Fst,Ap,Ast',freqLowMax,freqLowMax+(550/3),0.5,55,fs);
    filterLow = design(filterLowSpecs);
    noiseLow = filter(filterLow, randn(1,leng));
    
elseif freqLowMin<=550/3 && freqLowMin>0
    filterLowSpecs = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',0.01,freqLowMin,freqLowMax,freqLowMax+(550/3),freqLowMin*3/10,0.5,55,fs);
    filterLow = design(filterLowSpecs);
    noiseLow = filter(filterLow, randn(1,leng));
    
else % making lower noise band
    filterLowSpecs = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',freqLowMin-(550/3),freqLowMin,freqLowMax,freqLowMax+(550/3),55,0.5,55,fs);
    filterLow = design(filterLowSpecs);
    noiseLow = filter(filterLow, randn(1,leng));
    
end