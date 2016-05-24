function [trialOutput] = carStroopExperiment(subjectName,exptdesign)

	% following codes should be used when you are getting key presses using
	% fast routines like kbcheck.
    KbName('UnifyKeyNames');
    Priority(1)
    %set Psychtoolbox warning level
    Screen('Preference', 'VisualDebugLevel', 1);
    %hide mouse cursor
    HideCursor;
    % make sure it is loaded into memory;
    WaitSecs(1);
	% initialize the random number generato, this is now done in the
	% wrapper function
% 	randn('state',sum(100*clock));   
%     rng('shuffle')
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		INITIALIZE EXPERIMENT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % open a screen and display instructions.
    % choosing the display with the highest display number is
    % a best guess about where you want the stimulus displayed.
    screens=Screen('Screens');
    screenNumber=max(screens);
    % slow RT warning tone
    if exptdesign.warningToneFlag
%         tooSlow = MakeBeep(1200, 0.5);
        tooSlow='Too Slow!';
    end
    % Open window with default settings:
    [w wRect]= Screen('OpenWindow', screenNumber,[128 128 128]);
    refresh = Screen('GetFlipInterval',w);
    slack = refresh/2;

    % Select specific text font, style and size, unless we're on Linux
    % where this combo is not available:
    if IsLinux==0
        Screen('TextFont',w, 'Courier New');
        Screen('TextSize',w, 14);
        Screen('TextStyle', w, 1+2);
    end
    drawAndCenterText(w,'Setting up session, please wait...',0);
    
    % load car images sovor/zupud, proto1/proto2, easy/hard
    easyCarImageFiles=dir([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'L01OnGray' filesep '*.jpg']);
    hardCarImageFiles=dir([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'L06OnGray' filesep '*.jpg']);
    novelCarImageFile=dir([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'novelOnGray' filesep '*.jpg']);
    for ii=1:exptdesign.numSessions
        %testCarImages(Image Row, Image Column, category, prototype, Difficulty, Index)
        testCarImages(:,:,1,1,1,ii)=imread([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'L01OnGray' filesep easyCarImageFiles(ii).name]);
        testCarImages(:,:,1,2,1,ii)=imread([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'L01OnGray' filesep easyCarImageFiles(50+ii).name]);
        testCarImages(:,:,2,1,1,ii)=imread([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'L01OnGray' filesep easyCarImageFiles(100+ii).name]);
        testCarImages(:,:,2,2,1,ii)=imread([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'L01OnGray' filesep easyCarImageFiles(150+ii).name]);
        testCarImages(:,:,1,1,2,ii)=imread([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'L06OnGray' filesep hardCarImageFiles(ii).name]);
        testCarImages(:,:,1,2,2,ii)=imread([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'L06OnGray' filesep hardCarImageFiles(50+ii).name]);
        testCarImages(:,:,2,1,2,ii)=imread([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'L06OnGray' filesep hardCarImageFiles(100+ii).name]);
        testCarImages(:,:,2,2,2,ii)=imread([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'L06OnGray' filesep hardCarImageFiles(150+ii).name]);
        %controlCarImages(Image row, Image Column, prototype, index)
        controlCarImages(:,:,1,ii)=imread([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'novelOnGray' filesep novelCarImageFile(ii).name]);
        controlCarImages(:,:,2,ii)=imread([exptdesign.imageDirectory filesep exptdesign.carImageDirectory filesep 'novelOnGray' filesep novelCarImageFile(10+ii).name]);
    end
    
    % get car labels and trim BG
    sovorImgFile=[exptdesign.imageDirectory filesep 'sovor*.png'];
    zupudImgFile=[exptdesign.imageDirectory filesep 'zupud*.png'];
    sovorImgFile=dir(sovorImgFile);
    zupudImgFile=dir(zupudImgFile);
    sovorImg=imread([exptdesign.imageDirectory filesep sovorImgFile.name], 'png','BackgroundColor', [0.5 0.5 0.5]);
    zupudImg=imread([exptdesign.imageDirectory filesep zupudImgFile.name], 'png','BackgroundColor', [0.5 0.5 0.5]);
    sovorImg=squeeze(mean(sovorImg,3));
    zupudImg=squeeze(mean(zupudImg,3));
    sovorBG=findBG(sovorImg);
    zupudBG=findBG(zupudImg);
    sovorImg(sovorBG)=128;
    zupudImg(zupudBG)=128;
    labels=zeros([size(sovorImg),2]);
    labels(:,:,1)=sovorImg;
    labels(:,:,2)=zupudImg;
    toTrim=labels;
    toTrim(labels==128)=0;
    toTrim=sum(toTrim,3);
    toTrimR=sum(toTrim,2);
    toTrimC=sum(toTrim,1);
    cMax=max(find(toTrimC));
    cMin=min(find(toTrimC));
    rMin=min(find(toTrimR));
    rMax=max(find(toTrimR));
    resizedLabels=labels(rMin:rMax, cMin:cMax, :);
    %  Make all of the textures and data needed for this session
    fixationimage = imread([exptdesign.imageDirectory filesep exptdesign.fixationImage]);
    blankimage = imread([exptdesign.imageDirectory filesep exptdesign.blankImage]);
    responseimage= imread([exptdesign.imageDirectory filesep exptdesign.responseImage]);
    fixationTexture=Screen('MakeTexture', w, double(fixationimage));
    blankTexture=Screen('MakeTexture', w, double(blankimage));   
    responseTexture=Screen('MakeTexture', w, double(responseimage));   
% % %     sovorLabelTexture=Screen('Maketexture', w, double(resizedLabels(:,:,1)));
% % %     zupudLabelTexture=Screen('Maketexture', w, double(resizedLabels(:,:,2)));
    
    % Build the set of trials
    carLabelCond=exptdesign.carLabelCond;
    carImageCond=exptdesign.carImageCond;
    imagePrototypeCond=exptdesign.imagePrototypeCond;
    imageDifficultyCond=exptdesign.imageDifficultyCond;
    stimLayoutCond=exptdesign.stimLayoutCond;
    
    exptdesign.directions=randperm(2);
    exptdesign.imageNumber=randperm(exptdesign.numSessions);
    
    %loop over blocks
    practiceTrialIndex=1;
    for sessionNum=1:exptdesign.numSessions;
        % display instructions in a block dependent manner
        if sessionNum <= exptdesign.numSessions/2
            directionCond = exptdesign.directions(1);
        else
            directionCond = exptdesign.directions(2);
        end
        % direction condition 1: respond left for sovor, right for zupud.
        % direction condition 2: respond left for zupud, right for sovror.
        if directionCond == 1
            drawAndCenterText(w,'Press "<-" for the sovor LABEL\n or "->" for zupud LABEL\n\n You must respond in 1 second or less\n\n Press any key to start experiment...');
        else
            drawAndCenterText(w,'Press "<-" for the zupud LABEL\n or "->" for sovor LABEL\n\n You must respond in 1 second or less\n\n Press any key to start experiment...');
        end
        
        % if bock 1 or 6 do 10 practice trials with just labels
        if sessionNum==1||sessionNum==6
            practiceTrialLabels=[ones(1,10), ones(1,10)*2];
            practiceTrialLabels=practiceTrialLabels(randperm(length(practiceTrialLabels)));
            percentCorrect=0;
            while(percentCorrect<.80)
            for practiceTrial=1:length(practiceTrialLabels)
                fixationDuration=(ceil(200* rand(1)) + 800) / 1000;
                carLabeltrial=practiceTrialLabels(practiceTrial);
                labelTexture=Screen('Maketexture', w, double(resizedLabels(:,:,carLabeltrial)));
                % draw blank
                Screen('DrawTexture', w, blankTexture);
                [blankVBLTimestamp, blankOnsetTime, blankFlipTimestamp, blankMissed] = Screen('Flip',w);
                % draw fixation
                Screen('DrawTexture', w, fixationTexture);
                [FixationVBLTimestamp FixationOnsetTime FixationFlipTimestamp FixationMissed] =...
                    Screen('Flip',w,blankVBLTimestamp+exptdesign.interTrialDuration-slack);
                % draw target stimuli
                Screen('DrawTexture', w, labelTexture);
                [labelVBLTimestamp labelOnsetTime labelFlipTimestamp labelMissed] = ...
                    Screen('Flip',w,FixationVBLTimestamp + fixationDuration - slack);
                % draw response prompt
                Screen('DrawTexture', w, responseTexture);
                [responseVBLTimestamp responseOnsetTime responseFlipTimestamp responseMissed] = ...
                    Screen('Flip',w,labelVBLTimestamp + exptdesign.targetDuration - slack);                
                % get response
                [response timeStamp]= getDirectionResponse(exptdesign.responseWindow);                
                % record RT
                practiceTrials.RT(practiceTrialIndex)= timeStamp - labelOnsetTime;
                % calculate correctness
                practiceTrials.subjectResponse(practiceTrialIndex)=response;
                practiceTrials.carLabel(practiceTrialIndex)=carLabeltrial;
                practiceTrials.directionCond(practiceTrialIndex)=directionCond;
                practiceTrials.subjectHasCorrectResponse(practiceTrialIndex)= subjectHasCorrectResponse(response,directionCond,carLabeltrial);
                
                practiceTrialIndex = practiceTrialIndex + 1;
                %play warning tone if RT cutoff missed
                if response==0 && exptdesign.warningToneFlag
%                     Snd('Play', tooSlow);
                     drawAndCenterText(w,tooSlow)
                end
            end
            % calculate and report RT and correctness and display. 
            percentCorrect=length(find(practiceTrials.subjectHasCorrectResponse(end-length(practiceTrialLabels)+1:end)))/length(practiceTrials.subjectHasCorrectResponse(end-length(practiceTrialLabels)+1:end));
            medianRT=median(practiceTrials.RT(find(practiceTrials.subjectHasCorrectResponse(end-length(practiceTrialLabels)+1:end))));
            drawAndCenterText(w,sprintf('Your Median Response Time was %d ms\n and your accuracy was %d percent',round(medianRT*1000),percentCorrect*100))
            end
        end
        
        %randomize trials for this block
        randomizationIndex=randperm(exptdesign.numTrialsPerSession);
        trialCarLabel=carLabelCond(randomizationIndex);
        trialCarImage=carImageCond(randomizationIndex);
        trialImagePrototype=imagePrototypeCond(randomizationIndex);
        trialStimLayout=stimLayoutCond(randomizationIndex);
        trialImageDifficulty=imageDifficultyCond(randomizationIndex);
        
        %  Set up the output data structure for all trials in this session
        trialOutput(sessionNum).sessionNum = sessionNum;
        %Loop over trials
        for trial=1:exptdesign.numTrialsPerSession
            %make the car texture for this trial
            if trialCarImage(trial)==3
                imageTexture=Screen('MakeTexture', w, double(controlCarImages(:,:,trialImagePrototype(trial),exptdesign.imageNumber(sessionNum)))); 
                imageSize=size(controlCarImages(:,:,trialImagePrototype(trial),exptdesign.imageNumber(sessionNum)));
            else
                imageTexture=Screen('MakeTexture', w, double(testCarImages(:,:,trialCarImage(trial),trialImagePrototype(trial),trialImageDifficulty(trial),exptdesign.imageNumber(sessionNum))));
                imageSize=size(testCarImages(:,:,trialCarImage(trial),trialImagePrototype(trial),trialImageDifficulty(trial),exptdesign.imageNumber(sessionNum)));
            end
            %make the label texture for this trial
            labelTexture=Screen('MakeTexture', w, double(resizedLabels(:,:,trialCarLabel(trial))));
            [r c]=size(resizedLabels(:,:,trialCarLabel(trial)));
            %create car image and label rectangles
            if trialStimLayout(trial) ==1
                labelRect=CenterRect([0 0 c r],wRect);
                labelRect(2)=labelRect(2) - (exptdesign.labelDist);
                labelRect(4)=labelRect(4) - (exptdesign.labelDist);
                imageRect=CenterRect([0 0 imageSize],wRect);
                imageRect(2)=imageRect(2) + (exptdesign.imageDist);
                imageRect(4)=imageRect(4) + (exptdesign.imageDist);
            else
                labelRect=CenterRect([0 0 c r],wRect);
                labelRect(2)=labelRect(2) + (exptdesign.labelDist);
                labelRect(4)=labelRect(4) + (exptdesign.labelDist);
                imageRect=CenterRect([0 0 imageSize],wRect);
                imageRect(2)=imageRect(2) - (exptdesign.imageDist);
                imageRect(4)=imageRect(4) - (exptdesign.imageDist);
            end
            
            fixationDuration=(ceil(200* rand(1)) + 800) / 1000;
            % draw fixation
            Screen('DrawTexture', w, fixationTexture);
            [FixationVBLTimestamp FixationOnsetTime FixationFlipTimestamp FixationMissed] = Screen('Flip',w);
            % draw target stimuli
            Screen('DrawTexture', w, imageTexture, [], imageRect);
            Screen('DrawTexture', w, labelTexture, [], labelRect);
            
            [targetVBLTimestamp targetOnsetTime targetFlipTimestamp targetMissed] = ...
                Screen('Flip',w,FixationVBLTimestamp + fixationDuration - slack);
            % draw response prompt
            Screen('DrawTexture', w, responseTexture);
            [responseVBLTimestamp responseOnsetTime responseFlipTimestamp responseMissed] = ...
                Screen('Flip',w,targetVBLTimestamp + exptdesign.targetDuration - slack);                
            % get response
            [response timeStamp]= getDirectionResponse(exptdesign.responseWindow);
            %play warning tone if RT cutoff missed
            if response==0 && exptdesign.warningToneFlag
%                 Snd('Play', tooSlow);
               drawAndCenterText(w,tooSlow)
            end
            
            %record the output
            trialOutput(sessionNum).trials(trial).subjectResponse = response;
            %RT
            trialOutput(sessionNum).trials(trial).RT=timeStamp-targetOnsetTime;
            %trial car
            trialOutput(sessionNum).trials(trial).carImage=trialCarImage(trial);
            %trial label
            trialOutput(sessionNum).trials(trial).carLabel=trialCarLabel(trial);
            %trial direction condition
            trialOutput(sessionNum).trials(trial).directionCond=directionCond;
            %Correctness
            trialOutput(sessionNum).trials(trial).subjectHasCorrectResponse=subjectHasCorrectResponse(response,directionCond,trialCarLabel(trial));
            %car image prototpe
            trialOutput(sessionNum).trials(trial).imagePrototype=trialImagePrototype(trial);
            %target stimulus layout
            trialOutput(sessionNum).trials(trial).stimLayout=trialStimLayout(trial);
            %car image difficulty
            trialOutput(sessionNum).trials(trial).imageDifficulty=trialImageDifficulty(trial);
            %fixation time
            trialOutput(sessionNum).trials(trial).fixationTime=fixationDuration;
            
            %timing information
            trialOutput(sessionNum).trials(trial).targetMissed=targetMissed;
            trialOutput(sessionNum).trials(trial).responseCueMissed=responseMissed;
            trialOutput(sessionNum).trials(trial).targetDuration=responseVBLTimestamp-targetOnsetTime;
            
            %clear textures
            Screen('Close',imageTexture)
            Screen('Close',labelTexture)               
        end
        %save the output after every session
        save([exptdesign.number 'Results' '.' num2str(sessionNum) '.' num2str(trial) '.mat'],'trialOutput','exptdesign');
    
        %Display a short break message
        if ( sessionNum < exptdesign.numSessions)
            drawAndCenterText(w,['End of Session #' num2str(sessionNum) ' out of ' num2str(exptdesign.numSessions) '.\n\n Please take a short break.\n  Then press any key to continue.']);
        else
            drawAndCenterText(w,['End of Session #' num2str(sessionNum) ' out of ' num2str(exptdesign.numSessions) '.\n\n Thank you for participating!\n  Press any key to end the experiment.']);
        end
    end
    
% close experiment
Screen('CloseAll');
Priority(0)    
end    
    
function drawAndCenterText(window,message,wait)
    if nargin < 3
        wait = 1;
    end
    % Now horizontally and vertically centered:
    black = BlackIndex(window); % pixel value for black
    DrawFormattedText(window, message, 'center', 'center', black);
    Screen('Flip',window);
    if wait
        KbPressWait
    end
end

function [response timeStamp]= getDirectionResponse(waitTime)        
   %Wait for a response
   response = 0;
   startWaiting=GetSecs;
   while GetSecs-startWaiting < waitTime && response == 0;
       %check to see if a key is pressed
        [keyPressed, timeStamp, keyCode] = KbCheck;
        if sum(keyCode)==1
            response=translateDirectionResponse(keyCode);
        end
   end
end

function [number] = translateDirectionResponse(keyCode)
    keyName = KbName(keyCode);
    if strcmp(keyName,'LeftArrow') || strcmp(keyName,'KP_Left')
        number = 1;
    elseif strcmp(keyName,'RightArrow') || strcmp(keyName,'KP_Right')
        number = 2;
    else
        number = 0;
    end
    return;
end

function [correct] = subjectHasCorrectResponse(response,directionCond,carLabelCond)
    %response 1=left/2=right, directionCond 1=sovor-left/2=zupud-left,
    %carLabelCond 1=sovor/2=zupud
    %add catch if the values of the inputs are not 1/2 (or 0 for response)?
    if response==0
        correct=0;
    elseif directionCond==1
        correct=response==carLabelCond;
    else
        correct=response~=carLabelCond;
    end
end