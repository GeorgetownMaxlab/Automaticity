function [eegdata EEG] = convertToMaxLab(EEG,exptFilename,ArtifactIndices)
    %  Convert to our own format
    exptData = load(exptFilename);
    numSessions = size(exptData.trialOutput,2);
    numTrials = size(exptData.trialOutput(1).trials,2);
    
    totaltrials = 0;
    %  Go through each session
    for session=1:numSessions
        %  Go through each trial
        numTrials = size(exptData.trialOutput(session).trials,2);
        for trial=1:numTrials
            totaltrials = totaltrials + 1;
            index = trial+((session-1)*numTrials);
            eegdata.trialnumber(index) = index;
            
            %  Record the type of stimulus presented (e.g. 1 = target, 0 = distractor)   
            if isfield(exptData.trialOutput(session).trials(trial),'trialType')
               eegdata.stim(index) = exptData.trialOutput(session).trials(trial).trialType;
            else
               eegdata.stim(index) = exptData.trialOutput(session).trials(trial).correctResponse;
            end
            
             %  Record the bagging parameters
            if isfield(exptData.trialOutput(session).trials(trial),'partnerbag')
               eegdata.partnerbag(index) = exptData.trialOutput(session).trials(trial).partnerbag;
               eegdata.samplebag(index) = exptData.trialOutput(session).trials(trial).samplebag;
            end
             
            eegdata.interTrialDuration(index) = exptData.trialOutput(session).trials(trial).interTrialDuration;
            eegdata.condition(index) = exptData.trialOutput(session).trials(trial).condition;
            eegdata.subjectAnimalResponse(index) = exptData.trialOutput(session).trials(trial).subjectAnimalResponse;            
            eegdata.subjectHasRightAnswer(index) = exptData.trialOutput(session).trials(trial).subjectHasRightAnswer;            
            eegdata.responseStart(index) = exptData.trialOutput(session).trials(trial).animalResponseStart;
            eegdata.responseFinished(index) = exptData.trialOutput(session).trials(trial).animalResponseFinished;
            eegdata.line(index) = exptData.trialOutput(session).trials(trial).line;
            eegdata.imagePosition1(index) = exptData.trialOutput(session).trials(trial).imagePosition1;
            eegdata.imagePosition2(index) = exptData.trialOutput(session).trials(trial).imagePosition2; 
            
            if isfield(exptData.trialOutput(session).trials(trial),'soaDuration')
                eegdata.soa(index) = exptData.trialOutput(session).trials(trial).soaDuration;
            end
            
            if isfield(exptData.trialOutput(session).trials(trial),'maskUsed')
              
                eegdata.maskUsed(index) = exptData.trialOutput(session).trials(trial).maskUsed;
            end
            
            if isfield(exptData.trialOutput(session).trials(trial),'trialType')
                eegdata.trialType(index) = exptData.trialOutput(session).trials(trial).trialType;
            end
            
%             if isfield(exptData.trialOutput(session).trials(trial),'stimulusImageFile')
%                 eegdata.stimulusImageFile{index}(:) = exptData.trialOutput(session).trials(trial).stimulusImageFile(:,1);
%             end
%             
            eegdata.bad(index)  = 0;
            

        end
    end
    
    newdata = shiftdim(EEG.data,2);
    eegdata.data = newdata(:,1:128,:);
    
    if isfield(exptData.exptdesign,'experimentName')
        eegdata.experimentName = exptData.exptdesign.experimentName;   
    else
        eegdata.experimentName = 'CategoryNoCategory';
    end
    
    if isfield(exptData.exptdesign,'comments')
        eegdata.comments = EEG.comments;
    end

    
    eegdata.name = exptFilename;
    eegdata.processedFilename = exptFilename;
    
     if strcmp(eegdata.experimentName,'RSVPParallelDarpaNoDarpaT1') == 1
%        %  Need to convert the trialoutput... 
        [targetfiles samplebag partnerbag] = fixBagging(exptData.trialOutput);
        eegdata.targetfiles = targetfiles;      
     end
        
    
    
    if nargin > 2 && size(ArtifactIndices,2) > 0
        goods = ones(1,totaltrials);
        size(goods)
        goods(ArtifactIndices) = 0;
        goodindices = find(goods);
        eegdata.goodindices = goodindices;
    end
    
    eegdata.srate = EEG.srate
end
