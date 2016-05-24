function [eegdata EEG] = convertToMaxLab_twoBlockTypes(EEG,exptFilename,ArtifactIndices)
    %  Convert to our own format
    exptData = load(exptFilename);
    numSessions = size(exptData.trialOutput,2);
    %numTrials = size(exptData.trialOutput(1).trials,2);
    
    totaltrials = 0;
    %  Go through each session
    for session=1:numSessions
        %  Go through each trial
        numTrials = size(exptData.trialOutput(session).trials,2);
        for trial=1:numTrials
            totaltrials = totaltrials + 1;
            index = totaltrials;%trial+((session-1)*numTrials);
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
            eegdata.block(index) = session;
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
        clear numTrials;
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
%        disp('Converting mislabelled partnerbags and samplebags');
        [targetfiles samplebag partnerbag] = fixBagging(exptData.trialOutput);
%        eegdata.samplebag = samplebag;
%        eegdata.partnerbag = partnerbag;
        eegdata.targetfiles = targetfiles;
%        disp('finished initial converting...');
%        
% %        disp('Starting randomly assigning bags to distractors...');
% %        trials = size(eegdata.partnerbag,2);
% %        for i=1:trials
% %             partnerbag = eegdata.partnerbag(i);
% %             if partnerbag == 0
% %                 %  find an unallocated partner
% %                 found = 0;
% %                 randomorder = randperm(trials);
% %                 for j=randomorder
% %                     otherpartner = eegdata.partnerbag(j);
% %                     if otherpartner == 0 && j ~= i && ~found && eegdata.trialType(i) == eegdata.trialType(j)
% %                        % go ahead and assign these bags together
% %                        eegdata.partnerbag(i) = eegdata.trialnumber(i);
% %                        eegdata.partnerbag(j) = eegdata.trialnumber(i);
% %                        eegdata.samplebag(i) = 1;
% %                        eegdata.samplebag(j) = 2;
% %                        found = 1;
% %                     end
% %                 end
% %                 
% %             end
% %        end
% %        disp('Finished randomly assigning bags to distractors...');
% %        
     end
        
    
    
    if nargin > 2 && size(ArtifactIndices,2) > 0
        goods = ones(1,totaltrials);
        size(goods)
        goods(ArtifactIndices) = 0;
        goodindices = find(goods);
        eegdata.goodindices = goodindices;
%        eegdata = selectIndices(eegdata,goodindices);
%         eegdatasize = size(eegdata.data)
%         goodindicessize = size(goodindices)
%         %  Ok, now modify the EEG data array.
%         EEG.data = EEG.data(:,:,goodindices);
%         EEG.event = EEG.event(goodindices);
%         EEG.urevent = EEG.urevent(goodindices);
%         EEG.epoch = EEG.epoch(goodindices);
%         EEG.trials = size(eegdata.data,1);
    end
    
    eegdata.srate = EEG.srate;
    

        
    
%     figure;plot(eegdata.stim);
   
%   eegdata.name = strrep(eegFilename,'.mat','');

end
