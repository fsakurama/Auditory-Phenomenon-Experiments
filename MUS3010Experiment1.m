%% Experiment1 (When the upper band was never closer to the tone than the lower band)
    
disp('Either of two trials has 2000Hz tone.');
disp('1 block has 7 types of noise band.');
disp('Blocks are presented five times');
disp('==============================================================');
disp('Block 1');
pause(1);
    
for na=1:5 % freqUppMin1 is fixed at one of five values
        
    for nb=1:7 % freqLowMax1 is fixed at one of seven values
            
        % noise band setting
        freqLowMax1 = fp - [0.0,0.05,0.1,0.15,0.2,0.3,0.4]*fp;
        freqLowMin1 = freqLowMax1(nb)-freqBand;
        freqUppMin1 = 2*fp + [0.0,0.05,0.1,0.2,1000]*fp - freqLowMax1(nb);
        freqUppMax1 = freqUppMin1(na)+freqBand;
        
        % making noise bands  
        noiseLow1 = MUS3010LowerNoiseBand(fs, length(ptone), freqLowMin1, freqLowMax1(nb)); % function
        noiseUpp1 = MUS3010UpperNoiseBand(fs, length(ptone), freqUppMin1(na), freqUppMax1); % function
        PlaySnd1 = ptone + AmpNoise*noiseLow1 + AmpNoise*noiseUpp1; % ptone and noise
        PlaySnd1N = AmpNoise*noiseLow1 + AmpNoise*noiseUpp1; % noise only
            
        r = randi([1 2]); % random
        if r==1 % ptone and noise → noise only 
            soundsc(PlaySnd1,fs);
            pause(1.5);
            soundsc(PlaySnd1N,fs);
            pause(1.5);
        elseif r==2 % noise only → ptone and noise
            soundsc(PlaySnd1N,fs);
            pause(1.5);
            soundsc(PlaySnd1,fs);
            pause(1.5);
        end;
            
        disp('Which trial contained the pure tone signal?');
        disp('If you don not know which one is the right answer, please enter 3');
        strAns1 = 'Enter 1, 2 or 3 >>';
        ans = input(strAns1);
        if ans==r % correct
            strAns2 = ['correct (Answer: trial ',num2str(r),')'];
            result(nb) = {'Correct'};
        else
            if ans==3 % don't know
                strAns2 = ['Answer: trial ',num2str(r)];
                result(nb) = {'No Answer'};
            else % incorrect
                strAns2 = ['incorrect (Answer: trial ',num2str(r),')'];
                result(nb) = {'Incorrect'};
            end;
        end;
        disp(strAns2);
        nb = nb+1;
            
    end
    
    if na==1
        resultarray1 = [result(1);result(2);result(3);result(4);result(5);result(6);result(7)];
    elseif na==2
        resultarray2 = [result(1);result(2);result(3);result(4);result(5);result(6);result(7)];
    elseif na==3
        resultarray3 = [result(1);result(2);result(3);result(4);result(5);result(6);result(7)];
    elseif na==4
        resultarray4 = [result(1);result(2);result(3);result(4);result(5);result(6);result(7)];
    elseif na==5
        resultarray5 = [result(1);result(2);result(3);result(4);result(5);result(6);result(7)];
    end
    
    if na==5
        disp('Experiment1 complete.');
        disp(' ');
    else
        disp(' ');
        disp('==============================================================');
        strBlock = ['Next: Block ',num2str(na+1)];
        disp(strBlock);
        pause(1);        
        na = na+1;
    end;
        
end

%fu = {num2str(freqUppMin1(1)),num2str(freqUppMin1(2)),num2str(freqUppMin1(3)),num2str(freqUppMin1(4)),'infinity'};
Column = {num2str(0.0);num2str(0.05);num2str(0.1);num2str(0.2);'infinity'};
Row = {num2str(freqLowMax1(1)),num2str(freqLowMax1(2)),num2str(freqLowMax1(3)),num2str(freqLowMax1(4)),num2str(freqLowMax1(5)),num2str(freqLowMax1(6)),num2str(freqLowMax1(7))};

T = table(resultarray1,resultarray2,resultarray3,resultarray4,resultarray5,'VariableNames',Column,'RowNames',Row);
T = table(T,'VariableNames',{'fl     \     (Δfl-Δfu)/fp'});
disp(T);