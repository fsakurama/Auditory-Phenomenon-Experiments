%% Experiment3 (Your setting)
    
strExperiment3_01 = 'Which Experiment do you try?';
strExperiment3_02 = 'Experiment3:';
strExperiment3(1) = {' (1) When the upper band was never closer to the tone than the lower band'};
strExperiment3(2) = {' (2) When the lower band was never closer to the tone than the upper band'};
strExperiment3Q = 'Select experiment number >>';
    
disp(strExperiment3_01);
disp(strExperiment3_02);

for ne3=1:2
    disp(char(strExperiment3(ne3)));
end
    
swExperiment3 = input(strExperiment3Q);
if length(swExperiment3) == 0, swExperiment3 = 1; end;
 
disp(' ');
disp(['===  ' strExperiment3_02  char(strExperiment3(swExperiment3)) '  ===']);
disp('Either of two trials has 2000Hz tone.');

if swExperiment3==1, % When the upper band was never closer to the tone than the lower band
        
    Q1 = 1;
    while Q1==1,
            
        strAmpPtonedB1 = 'Input the level of pure tone (dB) >>'; % select the pure tone level in dB
        PtonedB1 = input(strAmpPtonedB1); % Amplitude of the pure tone
        strFLMbyFP = 'ΔfLowMax/fPureTone (select from 0.0 to 0.4) >>';
        FLMbyFP = input(strFLMbyFP);
        value3_1 = 28000/fp - 1 - FLMbyFP;
        strvalue3_1 = ['if the number is larger than ',num2str(value3_1),', the upper noise band does not exist.'];
        disp('(ΔfUppMin-ΔfLowMax)/fPureTone (select any positive values)');
        disp(strvalue3_1);
        strDFUFLbyFP = '>>';
        DFUFLbyFP = input(strDFUFLbyFP);
        
        % making pure tone
        ptone1 = MUS3010PureTone(fs, dur, fp, PtonedB1); % function
        
        % Noise band setting
        freqLowMax3_1 = fp - FLMbyFP*fp;
        freqLowMin3_1 = freqLowMax3_1-freqBand;
        freqUppMin3_1 = 2*fp + DFUFLbyFP*fp - freqLowMax3_1;
        freqUppMax3_1 = freqUppMin3_1+freqBand;
            
        noiseLow3_1 = MUS3010LowerNoiseBand(fs, length(ptone), freqLowMin3_1, freqLowMax3_1); % function
        noiseUpp3_1 = MUS3010UpperNoiseBand(fs, length(ptone), freqUppMin3_1, freqUppMax3_1); % funtion
        PlaySnd3_1 = ptone1 + AmpNoise*noiseLow3_1 + AmpNoise*noiseUpp3_1; % ptone and noise
        PlaySndN3_1 = AmpNoise*noiseLow3_1 + AmpNoise*noiseUpp3_1; % noise only
        
        r = randi([1 2]); % random
        if r==1 % ptone and noise → noise only
            soundsc(PlaySnd3_1,fs);
            pause(1.5); 
            soundsc(PlaySndN3_1,fs);
            pause(1.5);
        elseif r==2 % noise only → ptone and noise
            soundsc(PlaySndN3_1,fs);
            pause(1.5);
            soundsc(PlaySnd3_1,fs);
            pause(1.5);
        end;

        strAns1 = 'Which trial contained the pure tone signal? (enter 1 or 2) >>';
        ans = input(strAns1);
        if ans==r % correct
            strAns2 = ['correct (Answer: trial ',num2str(r),')'];
        else % incorrect
            strAns2 = ['incorrect (Answer: trial ',num2str(r),')'];
        end;
        disp(strAns2);
        
        strQ1 = 'Next trial → 1,  Finish → 2  >>';
        swQ1 = input(strQ1);
        switch swQ1
            case 1 % continue
                Q1 = 1;
            case 2 % stop
                Q1 = Q1+1;
        end
            
    end;
        
    if Q1==2,
        disp('Experiment3 (1) complete.');  
    end;
        
end;
    
if swExperiment3==2, % When the lower band was never closer to the tone than the upper band
        
    Q2 = 1;
    while Q2==1
            
        strAmpPtonedB2 = 'Input the level of pure tone (dB) >>'; % select the pure tone level in dB
        PtonedB2 = input(strAmpPtonedB2); % Amplitude of the pure tone
        strFUMbyFP = 'ΔfUppMin/fPureTone (select from 0.0 to 0.4) >>';
        FUMbyFP = input(strFUMbyFP);
        value3_2 = 1 - FUMbyFP - freqBand/fp;
        strvalue3_2 = ['if the number is larger than ',num2str(value3_2),', the lower noise band does not exist.'];
        disp('(ΔfLowMax-ΔfUppMin)/fPureTone (select any positive values)');
        disp(strvalue3_2);
        strDFLFUbyFP = '>>';
        DFLFUbyFP = input(strDFLFUbyFP);
        
        % making pure tone
        ptone2 = MUS3010PureTone(fs, dur, fp, PtonedB2); % function
        
        % Noise band setting
        freqUppMin3_2 = fp + FUMbyFP*fp;
        freqUppMax3_2 = freqUppMin3_2+freqBand;
        freqLowMax3_2 = 2*fp - DFLFUbyFP*fp - freqUppMin3_2;
        freqLowMin3_2 = freqLowMax3_2-freqBand;
            
        noiseLow3_2 = MUS3010LowerNoiseBand(fs, length(ptone), freqLowMin3_2, freqLowMax3_2); % function
        noiseUpp3_2 = MUS3010UpperNoiseBand(fs, length(ptone), freqUppMin3_2, freqUppMax3_2); % function
        PlaySnd3_2 = ptone2 + AmpNoise*noiseLow3_2 + AmpNoise*noiseUpp3_2; % ptone and noise
        PlaySndN3_2 = AmpNoise*noiseLow3_2 + AmpNoise*noiseUpp3_2; % noise only
            
        r = randi([1 2]); % random
        if r==1 % ptone and noise → noise only
            soundsc(PlaySnd3_2,fs);
            pause(1.5);
            soundsc(PlaySndN3_2,fs);
            pause(1.5);
        elseif r==2 % noise only → ptone and noise
            soundsc(PlaySndN3_2,fs);
            pause(1.5);
            soundsc(PlaySnd3_2,fs);
            pause(1.5);
        end;

        strAns1 = 'Which trial contained the pure tone signal? (enter 1 or 2) >>';
        ans = input(strAns1);
        if ans==r % correct
            strAns2 = ['correct (Answer: trial ',num2str(r),')'];
        else % incorrect
            strAns2 = ['incorrect (Answer: trial ',num2str(r),')'];
        end;
        disp(strAns2);
            
        strQ2 = 'Next trial → 1,  Finish → 2  >>';
        swQ2 = input(strQ2);
        switch swQ2
            case 1 % continue
                Q2 = 1;
            case 2 % stop
                Q2 = Q2+1;
        end
            
    end
        
    if Q2==2,   
        disp('Experiment3 (2) complete.');   
    end;
        
end;