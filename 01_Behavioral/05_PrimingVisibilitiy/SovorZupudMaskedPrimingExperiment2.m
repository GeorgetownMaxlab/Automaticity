function [trialOutput] = SovorZupudMaskedPrimingExperiment(subjectName,exptdesign)

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
	% initialize the random number generator
	%randn('state',sum(100*clock));   %#ok<RAND>
     rng('shuffle');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%		INITIALIZE EXPERIMENT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % open a screen and display instructions.
    % choosing the display with the highest display number is
    % a best guess about where you want the stimulus displayed.
    screens=Screen('Screens');
    screenNumber=max(screens);
    % slow RT warning tone
    if exptdesign.RTcutoffFlag
        tooSlow = MakeBeep(1200, 0.5);
    end
    % Open window with default settings:
    w = Screen('OpenWindow', screenNumber,[128 128 128]);
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
    
    %load prime/target images
    primeImageFiles=getTargets([exptdesign.imageDirectory filesep exptdesign.primeImageDirectory filesep '*.jpg']);
    targetImageFiles=getTargets([exptdesign.imageDirectory filesep exptdesign.targetImageDirectory filesep '*.jpg']);
    primeSize=size(imread([exptdesign.imageDirectory filesep exptdesign.primeImageDirectory filesep primeImageFiles(1).name]));
    targetSize=size(imread([exptdesign.imageDirectory filesep exptdesign.targetImageDirectory filesep targetImageFiles(1).name]));
    primeImages=zeros(primeSize(1),primeSize(2),length(exptdesign.primes),50);
    targetImages=zeros(targetSize(1),targetSize(2),length(exptdesign.targets),50);
    for ii=1:50
        %testCarImages(Image Row, Image Column, prototype, Index)
        primeImages(:,:,1,ii)=imread([exptdesign.imageDirectory filesep exptdesign.primeImageDirectory filesep primeImageFiles(ii).name]);
        primeImages(:,:,2,ii)=imread([exptdesign.imageDirectory filesep exptdesign.primeImageDirectory filesep primeImageFiles(50+ii).name]);
        primeImages(:,:,3,ii)=imread([exptdesign.imageDirectory filesep exptdesign.primeImageDirectory filesep primeImageFiles(100+ii).name]);
        primeImages(:,:,4,ii)=imread([exptdesign.imageDirectory filesep exptdesign.primeImageDirectory filesep primeImageFiles(150+ii).name]);
        targetImages(:,:,1,ii)=imread([exptdesign.imageDirectory filesep exptdesign.targetImageDirectory filesep targetImageFiles(ii).name]);
        targetImages(:,:,2,ii)=imread([exptdesign.imageDirectory filesep exptdesign.targetImageDirectory filesep targetImageFiles(50+ii).name]);
        targetImages(:,:,3,ii)=imread([exptdesign.imageDirectory filesep exptdesign.targetImageDirectory filesep targetImageFiles(100+ii).name]);
        targetImages(:,:,4,ii)=imread([exptdesign.imageDirectory filesep exptdesign.targetImageDirectory filesep targetImageFiles(150+ii).name]);
    end
    
    % randomize images
    prime1rand=randperm(50);
    target1rand=prime1rand(50:-1:1);
    prime2rand=randperm(50);
    target2rand=prime2rand(50:-1:1);
    prime3rand=randperm(50);
    target3rand=prime3rand(50:-1:1);
    prime4rand=randperm(50);
    target4rand=prime4rand(50:-1:1);
    
    prime1Index=0;
    prime2Index=0;
    prime3Index=0;
    prime4Index=0;
    target1Index=0;
    target2Index=0;
    target3Index=0;
    target4Index=0;

    %  Make all of the textures and data needed for this session
    blankimage = imread([exptdesign.imageDirectory filesep exptdesign.blankImage]);
    blankTexture=Screen('MakeTexture', w, double(blankimage));

    % Build the set of trials
    primeCond=exptdesign.primeCategoryCond;
    targetCond=exptdesign.targetCategoryCond;
    primeDurationCond=exptdesign.primeDuration(exptdesign.primeDurationCond);
        
    if strcmp(exptdesign.experimentName,'sovorZupudMaskedPriming')
        drawAndCenterText(w,'Press "1" for sovors\n or "2" for non-Sovors\n\n Press any key to start experiment...');
    end
    if strcmp(exptdesign.experimentName,'sovorZupudVisibilityTest')
        drawAndCenterText(w,'Press "1" if the first car is a sovor\n or "2" if the first car is not a sovor\n\n Press any key to start experiment...');
    end
    
    %Loop over sessions
    for sessionNum=1:exptdesign.numSessions;
        %randomize trials for each block
        randomizationIndex=randperm(exptdesign.numTrialsPerSession);
        trialPrime=primeCond(randomizationIndex);
        primeCategory=trialPrime<3;%1 is sovor and 0 is zupud
        trialTarget=targetCond(randomizationIndex);
        targetCategory=trialTarget<3;%1 is sovor/cat and 0 is zupud/dog
        trialCongruency=primeCategory==targetCategory;
        trialFilterSize=exptdesign.maskFilterSize*ones(exptdesign.numTrialsPerSession,1);
        trialPrimeDuration=primeDurationCond(randomizationIndex);
        
        % Set up the output data structure for all trials in this session
        trialOutput(sessionNum).sessionNum = sessionNum;
        
        %Loop over trials
        for trial=1:exptdesign.numTrialsPerSession
            %make the forward mask textures for trial
            if exptdesign.forwardMasks
                for FWmaskInd=1:exptdesign.forwardMasks
                   maskimage = makeNoiseMask(exptdesign.maskHeight,exptdesign.maskWidth,trialFilterSize(trial));
                   eval(['FWmaskTexture' num2str(FWmaskInd) ' = Screen(''MakeTexture'', w, double(maskimage));']); 
                end
            end
            %make the prime texture for this trial
            switch trialPrime(trial)
                case 1
                    primeIND=prime1rand(mod(prime1Index,50)+1);
                    prime1Index=prime1Index+1;
                case 2
                    primeIND=prime2rand(mod(prime2Index,50)+1);
                    prime2Index=prime2Index+1;
                case 3
                    primeIND=prime3rand(mod(prime3Index,50)+1);
                    prime3Index=prime3Index+1;
                case 4
                    primeIND=prime4rand(mod(prime4Index,50)+1);
                    prime4Index=prime4Index+1;
            end
            primeTexture=Screen('MakeTexture', w, double(primeImages(:,:,trialPrime(trial),primeIND)));%how do we  determine which image?
            
            %make the target texture for this trial
            switch trialTarget(trial)
                case 1
                    targetIND=target1rand(mod(target1Index,50)+1);
                    target1Index=target1Index+1;
                case 2
                    targetIND=target2rand(mod(target2Index,50)+1);
                    target2Index=target2Index+1;
                case 3
                    targetIND=target3rand(mod(target3Index,50)+1);
                    target3Index=target3Index+1;
                case 4
                    targetIND=target4rand(mod(target4Index,50)+1);
                    target4Index=target4Index+1;
            end
            targetTexture=Screen('MakeTexture', w, double(targetImages(:,:,trialTarget(trial),targetIND)));%how do we  determine which image?
            
            %jitter the trials?
            interTrialDuration = 0.300;
            
            %draw inter trial blank
            Screen('DrawTexture', w, blankTexture);
            [InterTrialBlankVBLTimestamp] = Screen('Flip',w);
            
            %draw forward mask
            for FWmaskInd=1:exptdesign.forwardMasks
                if FWmaskInd==1
                    Screen('DrawTexture', w, FWmaskTexture1);
                    [FWmaskVBLTimestamp(FWmaskInd) FWmaskOnsetTime(FWmaskInd) FWmaskFlipTimestamp(FWmaskInd) FWmaskMissed(FWmaskInd)] = ...
                        Screen('Flip',w,InterTrialBlankVBLTimestamp + interTrialDuration - slack);
                else
                    eval(['Screen(''DrawTexture'',w,' sprintf('FWmaskTexture%d)',FWmaskInd)]);
                    [FWmaskVBLTimestamp(FWmaskInd) FWmaskOnsetTime(FWmaskInd) FWmaskFlipTimestamp(FWmaskInd) FWmaskMissed(FWmaskInd)] = ...
                        Screen('Flip',w,FWmaskVBLTimestamp(FWmaskInd-1) + exptdesign.FWmaskDuration - slack);
                end
            end
            
            %draw prime image
            Screen('DrawTexture', w, primeTexture);
            [PrimeVBLTimestamp PrimeOnsetTime PrimeFlipTimestamp PrimeMissed] = ...
                Screen('Flip',w,FWmaskVBLTimestamp(FWmaskInd) + exptdesign.FWmaskDuration - slack);
            
            %draw target image
            Screen('DrawTexture', w, targetTexture);
            [TargetVBLTimestamp TargetOnsetTime TargetFlipTimestamp TargetMissed] = ...
                Screen('Flip',w,PrimeVBLTimestamp + trialPrimeDuration(trial) - slack);

            %get subject response
            if exptdesign.waitForResponse
                 [response timeStamp]= getCategoryResponseWait();
            else
                [response timeStamp]= getCategoryResponse(exptdesign.targetDuration);
            end
            if strcmp(exptdesign.experimentName,'sovorZupudMaskedPriming')
                %response 1='s'-sovor, response 2='d'zupud.
                %targets 1 and 2 are sovors, 3 and 4 are zupuds
                if trialTarget(trial) < 3%correct answer is 1
                    if response==1
                        subjectCorrect=1;
                    else
                        subjectCorrect=0;
                    end
                else%correct answer is 2
                    if response==2
                        subjectCorrect=1;
                    else
                        subjectCorrect=0;
                    end
                end
            elseif strcmp(exptdesign.experimentName,'sovorZupudVisibilityTest')
                %response 1='s'-sovor, response 2='d'zupud.
                %primes 1 and 2 are sovors, 3 and 4 are zupuds
                if trialPrime(trial) < 3%correct answer is 1
                    if response==1
                        subjectCorrect=1;
                    else
                        subjectCorrect=0;
                    end
                else%correct answer is 2
                    if response==2
                        subjectCorrect=1;
                    else
                        subjectCorrect=0;
                    end
                end              
            end
            RT=timeStamp-TargetOnsetTime;
            %play warning tone if RT cutoff missed
            if RT > exptdesign.RTcutoff && exptdesign.RTcutoffFlag
                Snd('Play', tooSlow);
            end
            %record the output
            trialOutput(sessionNum).trials(trial).subjectResponse = response;
            %correct/incorrect
            trialOutput(sessionNum).trials(trial).subjectCorrect = subjectCorrect;
            %RT
            trialOutput(sessionNum).trials(trial).RT=RT;
            %trial prime
            trialOutput(sessionNum).trials(trial).prime=trialPrime(trial);
            %trial target
            trialOutput(sessionNum).trials(trial).target=trialTarget(trial);
            %trial congruency
            trialOutput(sessionNum).trials(trial).congruency=trialCongruency(trial);
            %trial prime duration
            trialOutput(sessionNum).trials(trial).primeDurationCond=trialPrimeDuration(trial);
            trialOutput(sessionNum).trials(trial).interTrialDurationCond = interTrialDuration;
            
            %image timing data REVISIT
%             trialOutput(sessionNum).trials(trial).fixationOnset = FixationOnsetTime;
%             trialOutput(sessionNum).trials(trial).fixationDuration = FWmaskVBLTimestamp(1) - FixationOnsetTime;  % record the actual time on screen (just to be accurate)
%             trialOutput(sessionNum).trials(trial).fixationMissed = FixationMissed;
            trialOutput(sessionNum).trials(trial).FWmaskOnset = FWmaskOnsetTime(FWmaskInd);
%             trialOutput(sessionNum).trials(trial).FWmaskDuration = PrimeVBLTimestamp - FWmaskOnsetTime;  % record the actual time on screen (just to be accurate)
%             trialOutput(sessionNum).trials(trial).FWmaskMissed = FWmaskMissed;           
            trialOutput(sessionNum).trials(trial).primeOnset = PrimeOnsetTime;
%             trialOutput(sessionNum).trials(trial).primeDuration = blank1VBLTimestamp - PrimeOnsetTime;  % record the actual time on screen (just to be accurate)
            trialOutput(sessionNum).trials(trial).primeMissed = PrimeMissed;
%             trialOutput(sessionNum).trials(trial).BWmaskOnset = BWmaskOnsetTime;
%             trialOutput(sessionNum).trials(trial).BWmaskDuration = blank2VBLTimestamp - BWmaskOnsetTime(1,end);  % record the actual time on screen (just to be accurate)
%             trialOutput(sessionNum).trials(trial).BWmaskMissed = BWmaskMissed;
            trialOutput(sessionNum).trials(trial).targetOnset = TargetOnsetTime;% for calculating true SOA
            trialOutput(sessionNum).trials(trial).targetMissed = TargetMissed;
            %clear textures
            Screen('Close',targetTexture)
               
        end
        
        %save the output after every session
        %save([exptdesign.Name 'Results' filesep subjectName '.' num2str(sessionNum) '.' num2str(trial) '.mat'],'trialOutput','exptdesign');
        if strcmp(exptdesign.exptName, 'sovorZupudMaskingPriming');
            save(['./sovorZupudMaskedPrimingResults' exptdesign.subjectName '_Results' '.' num2str(sessionNum) '.' num2str(trial) '.mat'],'trialOutput','exptdesign'); 
        else
            save(['./sovorZupudVisibilityTestResults' exptdesign.subjectName '_Results' '.' num2str(sessionNum) '.' num2str(trial) '.mat'],'trialOutput','exptdesign');
        end
        
        %Display a short break message
        if ( sessionNum < exptdesign.numSessions)
            drawAndCenterText(w,['End of Session #' num2str(sessionNum) '.\n\n Please take a short break.\n  Then press any key to continue.']);
        else
            drawAndCenterText(w,['End of Session #' num2str(sessionNum) '.\n\n Thank you for participating!\n  Press any key to end the experiment.']);
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

function targets = getTargets (targetsLocation)
    targets = dir(targetsLocation);
    if (size(targets,1) == 0)
        disp('NO TARGET IMAGES!!!!');
        ME = MException('VerifyInput:OutOfBounds', ['NO TARGET IMAGES FOUND AT ' targetsLocation]);
        throw(ME);
    end
end

function [response timeStamp]= getCategoryResponse(waitTime)        
   %Wait for a response
   startWaiting=GetSecs;
   response = -1;
   while GetSecs-startWaiting < waitTime && response == -1;
       %check to see if a key is pressed
        [keyPressed, timeStamp, keyCode] = KbCheck;
        if sum(keyCode)==1
        response=translateKeyCategoryResponse(keyCode);        
        end
   end
   if response == -1
       response =0;
   end
end

function [response timeStamp]= getCategoryResponseWait()
        response = -1;
        while response == -1
            [timeStamp, keyCode] = KbPressWait;
            if sum(keyCode)==1
            response = translateKeyCategoryResponse(keyCode);
            end
        end
end   

function [number] = translateKeyCategoryResponse(keyCode)
    keyName = KbName(keyCode);
    if strcmp(keyName,'KP_End') || strcmp(keyName,'1') || strcmp(keyName,'1!')
        number = 1; %sovor
    elseif strcmp(keyName,'KP_Down') || strcmp(keyName,'2') || strcmp(keyName,'2@')
        number = 2; %not sovor
    else 
        number = -1;
    end
    return;
end

function [maskFiltThresh3] = makeNoiseMask(height,width,filterSize)
    mask=rand(height+3*(filterSize-1),width+3*(filterSize-1));
    maskFilt=filter2(ones(filterSize,filterSize)/filterSize^2,mask, 'valid');
    maskFiltThresh=maskFilt;
    maskFiltThresh(maskFilt<.5)=0;
    maskFiltThresh(maskFilt>.5)=1;
    maskFilt2=filter2(ones(filterSize,filterSize)/filterSize^2,maskFiltThresh, 'valid');
    maskFiltThresh2=maskFilt2;
    maskFiltThresh2(maskFilt2>.5)=1;
    maskFiltThresh2(maskFilt2<.5)=0;
    maskFilt3=filter2(ones(filterSize,filterSize)/filterSize^2,maskFiltThresh2, 'valid');
    maskFiltThresh3=maskFilt3;
    maskFiltThresh3(maskFilt3<.5)=0;
    maskFiltThresh3(maskFilt3>.5)=1;
    maskFiltThresh3=maskFiltThresh3*255;
end