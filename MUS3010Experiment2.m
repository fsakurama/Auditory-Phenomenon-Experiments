%% Experiment2 (When the lower band was never closer to the tone than the upper band)
    
disp('Either of two trials has 2000Hz tone.');
disp('1 block has 7 types of noise band.');
disp('Blocks are presented five times');
disp('==============================================================');
disp('Block 1');
pause(1);
    
for nc=1:5 % freqLowMax2 is fixed at one of five values
        
    for nd=1:7 % freqUppMin2 is fixed at one of seven values
            
        % noise band settings
        freqUppMin2 = fp + [0.0,0.05,0.1,0.15,0.2,0.3,0.4]*fp;
        freqUppMax2 = freqUppMin2(nd)+freqBand;
        freqLowMax2 = 2*fp - [0.0,0.05,0.1,0.2,10]*fp - freqUppMin2(nd);
        freqLowMin2 = freqLowMax2(nc)-freqBand;
        
        % making noise bands
        noiseLow2 = MUS3010LowerNoiseBand(fs, length(ptone), freqLowMin2, freqLowMax2(nc)); % function
        noiseUpp2 = MUS3010UpperNoiseBand(fs, length(ptone), freqUppMin2(nd), freqUppMax2); % function
        PlaySnd2 = ptone + AmpNoise*noiseLow2 + AmpNoise*noiseUpp2; % ptone and noise
        PlaySnd2N = AmpNoise*noiseLow2 + AmpNoise*noiseUpp2; % noise only

        r = randi([1 2]); % random
        if r==1 % ptone and noise → noise only
            soundsc(PlaySnd2,fs);
            pause(1.5);
            soundsc(PlaySnd2N,fs);
            pause(1.5);
        elseif r==2 % noise only → ptone
            soundsc(PlaySnd2N,fs);
            pause(1.5);
            soundsc(PlaySnd2,fs);
            pause(1.5);
        end;

        disp('Which trial contained the pure tone signal?');
        disp('If you don not know which one is the right answer, please enter 3');
        strAns1 = 'Enter 1, 2 or 3 >>';
        ans = input(strAns1);
        if ans==r % correct
            strAns2 = ['correct (Answer: trial ',num2str(r),')'];
            result(nd) = {'Correct'};
        else
            if ans==3 % don't know
                strAns2 = ['Answer: trial ',num2str(r)];
                result(nd) = {'No Answer'};
            else % incorrect
                strAns2 = ['incorrect (Answer: trial ',num2str(r),')'];
                result(nd) = {'Incorrect'};
            end;
        end;
        disp(strAns2);
        nd = nd+1;
            
    end
    
    if nc==1
        resultarray1 = [result(1);result(2);result(3);result(4);result(5);result(6);result(7)];
    elseif nc==2
        resultarray2 = [result(1);result(2);result(3);result(4);result(5);result(6);result(7)];
    elseif nc==3
        resultarray3 = [result(1);result(2);result(3);result(4);result(5);result(6);result(7)];
    elseif nc==4
        resultarray4 = [result(1);result(2);result(3);result(4);result(5);result(6);result(7)];
    elseif nc==5
        resultarray5 = [result(1);result(2);result(3);result(4);result(5);result(6);result(7)];
    end
    
    if nc==5
        disp('Experiment2 complete.');
        disp(' ');
    else
        disp(' ');
        disp('==============================================================');
        strBlock = ['Next: Block ',num2str(nc+1)];
        disp(strBlock);
        pause(1);        
        nc = nc+1;
    end;
        
end;

%fl = {num2str(freqLowMax2(1)),num2str(freqLowMax2(2)),num2str(freqLowMax2(3)),num2str(freqLowMax2(4)),'infinity'};
Column = {num2str(0.0);num2str(0.05);num2str(0.1);num2str(0.2);'infinity'};
Row = {num2str(freqUppMin2(1)),num2str(freqUppMin2(2)),num2str(freqUppMin2(3)),num2str(freqUppMin2(4)),num2str(freqUppMin2(5)),num2str(freqUppMin2(6)),num2str(freqUppMin2(7))};

T = table(resultarray1,resultarray2,resultarray3,resultarray4,resultarray5,'VariableNames',Column,'RowNames',Row);
T = table(T,'VariableNames',{'fu     \     (Δfu-Δfl)/fp'});
disp(T);