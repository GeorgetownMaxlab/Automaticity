clear latency
for i = 1:length(trialOutput)
    for j = 1:length(trialOutput(1,i).trials)
        latency(i,j) = (trialOutput(1,i).trials(1,j).stimulus1Onset - trialOutput(1,1).trials(1,1).trialStartTime);
    end
end