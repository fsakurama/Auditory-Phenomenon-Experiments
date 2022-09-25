% Upper noise band function

function [noiseUpp] = MUS3010UpperNoiseBand(fs, leng, freqUppMin, freqUppMax)

if freqUppMin>=28000 % Upper noise band doesn't exist
    
    noiseUpp = zeros(1,leng);
                
else
    
    filterUppSpecs = fdesign.bandpass('Fst1,Fp1,Fp2,Fst2,Ast1,Ap,Ast2',freqUppMin-(550/3),freqUppMin,freqUppMax,freqUppMax+(550/3),55,0.5,55,fs);
    filterUpp = design(filterUppSpecs);
    noiseUpp = filter(filterUpp, randn(1,leng));
    
end