%
% Automaticity


function trialOutput = diskAnimalsTrainingExperimentSwitch3(name,exptdesign)

try
    % following codes should be used when you are getting key presses using
    % fast routines like kbcheck.
    KbName('UnifyKeyNames');
    Priority(1)

    %settings so that Psychtoolbox doesn't display annoying warnings--DON'T CHANGE
    oldLevel = Screen('Preference', 'VisualDebugLevel', 1);
    %     oldEnableFlag = Screen('Preference', 'SuppressAllWarnings', 1);
    %     warning offc
    HideCursor;

    WaitSecs(1); % make sure it is loaded into memory;
    tmp = GetSecs; % make sure it is loaded into memory;

    % initialize the random number generator
%     randn('state',sum(100*clock));
% this is now done in the wrapper function with rng('shuffle')

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %		INITIALIZE EXPERIMENT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % open a screen and display instructions
    % Choosing the display with the highest display number is
    % a best guess about where you want the stimulus displayed.
    screens = Screen('Screens');
    %screenNumber = max(screens);
    screenNumber = 0;
    % Open window with default settings:
    [w windowRect] = Screen('OpenWindow', screenNumber,[128 128 128]);
    white = WhiteIndex(w); % pixel value for white
    black = BlackIndex(w); % pixel value for black

    
    %  calculate the slack allowed during a flip interval
    refresh = Screen('GetFlipInterval',w);
    slack = refresh/2;

    % Select specific text font, style and size, unless we're on Linux
    % where this combo is not available:
    if IsLinux==0
        Screen('TextFont',w, 'Courier New');
        Screen('TextSize',w, 14);
        Screen('TextStyle', w, 1+2);
    end;
    
    if exptdesign.netstationPresent
        
        % Connect to Netstation
        [status error] = NetStation('Connect', exptdesign.netstationIP);
        if status ==1 % there was an error!
            ME = MException('NETSTATION:CouldNotConnect', ['Could not connect to Netstation computer at IP ' exptdesign.netstationIP '.  Please check the IP and network connection and try again.\n  Error:' error]);
            throw(ME);
        end

        %         % Tell Netstation to start recording
        %             [status error] = NetStation('StartRecording')
        %         if status ==1 % there was an error!
        %              ME = MException('NETSTATION:CouldNotRecord', ['Could not tell Netstation to start recording.  Please check the IP and connection and try again.\n  Error:' error]);
        %              throw(ME);
        %         end

        % Tell Netstation to synchronize recording
        [status error] = NetStation('Synchronize',exptdesign.netstationSyncLimit);
        if status ==1 % there was an error!
            ME = MException('NETSTATION:CouldNotSync', ['Could not sync with Netstation to allowable limit of ' exptdesign.syncLimit '.  Please check the IP and connection and try again.\n  Error:' error]);
            throw(ME);
        end
    end
    
        %make correct and incorrect sounds
    good = MakeBeep(800,0.1);
    bad = MakeBeep(1200, 0.5);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %		INTRO EXPERIMENT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Now horizontally and vertically centered:
    drawAndCenterText(w,'Press any key to start experiment...');

% % %     % Check to see if the letter images are in the directory
% % %     letterTfiles = dir(exptdesign.Tgraphic);
% % %     if (size(letterTfiles,1) == 0)
% % %         disp('NO LETTER T IMAGES!!!!');
% % %         ME = MException('VerifyInput:OutofBounds', ['NO LETTER IMAGES T FOUND AT ' exptdesign.Tgraphic]);
% % %     end
% % % 
% % %     letterLfiles = dir(exptdesign.Lgraphic);
% % %     if (size(letterLfiles,1) == 0)
% % %         disp('NO LETTER L IMAGES!!!!');
% % %         ME = MException('VerifyInput:OutofBounds', ['NO LETTER IMAGES L FOUND AT ' exptdesign.Lgraphic]);
% % %     end
% % % 
% % %     letterFfiles = dir(exptdesign.Fgraphic);
% % %     if (size(letterFfiles,1) == 0)
% % %         disp('NO LETTER F IMAGES!!!!');
% % %         ME = MException('VerifyInput:OutofBounds', ['NO LETTER F IMAGES FOUND AT ' exptdesign.Fgraphic]);
% % %     end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   MAKE AND SAVE numSessions/3 ltChosen/lettersDrawn/spinAngle arrays
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %LETTERS
% %     letterT = imread(exptdesign.Tgraphic);
% %     letterL = imread(exptdesign.Lgraphic);
% %     letterF = imread(exptdesign.Fgraphic);
% %     
% %     numLetterArrays = exptdesign.numSessions/3;
    
% %     for ii=1:numLetterArrays
% %         for jj=1:exptdesign.numTrialsPerSession
% %             [correctCentResponse, spinAngle, lettersDrawn, ltChosen, different, letters] = generateLetters();
% %             letterScheme(ii).correctCentResponse(jj,:)=correctCentResponse;
% %             letterScheme(ii).spinAngle(jj,:)=spinAngle;
% %             letterScheme(ii).lettersDrawn(jj,:)=lettersDrawn;
% %             letterScheme(ii).ltChosen(jj,:)=ltChosen;
% %             letterScheme(ii).different(jj,:)=different;
% %             letterScheme(ii).letters(jj,:)=letters;
% %             clear correctCentResponse spinAngle lettersDrawn ltChosen different letters;
% %         end
% %     end
% %     
% %     for kk=1:exptdesign.numSessions;
% %         letterOrder(kk,:) = randperm(exptdesign.numTrialsPerSession);
% %     end
% %     
% %     save(['./data/' exptdesign.subjectName '/letterScheme.' exptdesign.subjectName '.mat'],'letterScheme', 'letterOrder');
    

    % Runs a function to set the SOA for the subject if it has not already
    % been set in the exptdesign
% %     if exptdesign.calibrateCentSOA
% %         centSOA = determineCentSOA(exptdesign,w,slack);
% %     else
% %         centSOA = exptdesign.centSOADurations;
% %     end
% % 
% %     if exptdesign.calibratePerifSOA
% %         perifSOA = determinePerifSOA(exptdesign,w,slack);
% %     else
% %         perifSOA = exptdesign.perifSOADurations;
% %     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %		SESSIONS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for sessionNum = 1:exptdesign.numSessions;
        
        centSOA = exptdesign.centSOADurations;
        perifSOA = exptdesign.perifSOADurations;
        responseKey=exptdesign.responseKey(sessionNum);
   
        %determine whether to display central and/or peripheral task
        if exptdesign.sessionType(sessionNum) == 1
            displayPerif = 0;
            displayCentral = 1;
            cueType=0;
        elseif exptdesign.sessionType(sessionNum) == 2
            displayPerif = 1;
            displayCentral = 0;
            cueType=1;
        elseif exptdesign.sessionType(sessionNum) == 3
            displayPerif = 1;
            displayCentral = 1;
            cueType=1;
        end
        

	%determine which order to display central/peripheral mask 
	%uses switch case otherwise below
	if centSOA < perifSOA
		screenOrder=1;
	elseif centSOA==perifSOA
		screenOrder=2;
	else
		screenOrder=3;
	end


        % Set up an array to record the number of correct answers
        centCorrectArray = zeros(1,exptdesign.numTrialsPerSession);
        perifCorrectArray = zeros(1,exptdesign.numTrialsPerSession);
        
        tic;
        if sessionNum == 1
            drawAndCenterText(w, 'Welcome \n \n \n  Setting up session, please wait...',0);
        else
            drawAndCenterText(w,'Setting up session, please wait...',0);
        end

        % Set up all stimuli, masks, fixation, and blank images
        if displayPerif
            % PICTURES
            [allimages, stimulustypemarker, allimagefiles] = prepPics(exptdesign);
            
            % MASK
            [maskimages, maskimagefiles maskorder] = prepPerifMask(exptdesign);
            disp('two')
        end
        
        if displayCentral
             % PICTURES
            [centallimages, centstimulustypemarker, centallimagefiles] = prepCentPics(exptdesign);
            
            % MASK
            [centmaskimages, centmaskimagefiles] = prepCentMask(exptdesign);
        
        
        end

% % %         % LETTERS
% % %         letterT = imread(exptdesign.Tgraphic);
% % %         letterL = imread(exptdesign.Lgraphic);
% % %         letterF = imread(exptdesign.Fgraphic);

        % FIXATION IMAGE
        fixationImage = imread(exptdesign.fixationImage);

        % BLANK IMAGE
        blankImage = imread(exptdesign.blankImage);
        size(blankImage)
        
        %cueImage = dir(exptdesign.cueImage);
        %cueImage = loadimages_png(exptdesign.imageDirectory, cueImage);
        cueImage = imread(exptdesign.cueImage, 'png', 'BackgroundColor', [0.5 0.5 0.5]);

        % MAKE TEXTURES
        fixationTexture = Screen('MakeTexture', w, double(fixationImage));
        blankTexture = Screen('MakeTexture', w, double(blankImage));
        cueTexture = Screen('MakeTexture', w, cueImage);

        disp('Finished setting up session :');
        toc;
        %if exptdesign.animOrCar == 2
         %        drawAndCenterText(window,'Finished setting up session \n \n \n Press the LEFT ARROW KEY if the image contains a circle with RED on the LEFT \n and the RIGHT ARROW KEY if image contains a circle with RED on the RIGHT \n \n Please respond as quickly and as accurately as possible \n \n \n (press key to begin)...',0);
        %elseif exptdesign.animOrCar == 1
         %        drawAndCenterText(window, 'Finished setting up session \n \n \n Press the LEFT ARROW KEY if the image contains a SAVOR \n and the RIGHT ARROW KEY if it contains a ZUPUD \n \n Please respond as quickly and as accurately as possible \n \n \n (press key to begin)...',0);
        %elseif exptdesign.animOrCar == 0
         %        drawAndCenterText(window,'Finished setting up session \n \n \n Press the LEFT ARROW KEY if the image contains an ANIMAL \n and the RIGHT ARROW KEY if it does not \n \n Please respond as quickly and as accurately as possible \n \n \n (press key to begin)...',0);
        %end
        drawAndCenterText(w,'Finished setting up session (press key to begin)...');
        
        %determine whether to display central and/or peripheral task
        if exptdesign.sessionType(sessionNum) == 1
            if responseKey==0
                drawAndCenterText(w, 'Animal/No Animal \n\n Press left for animal. \n Press right for no animal.  \n\n (press key to begin)...');
            else
                drawAndCenterText(w, 'Animal/No Animal \n\n Press right for animal. \n Press left for no animal.  \n\n (press key to begin)...');
            end
        elseif exptdesign.sessionType(sessionNum) == 2
            drawAndCenterText(w, 'Disk: Red on Left (1) or Right (2)? \n\n (press key to begin)...');
        elseif exptdesign.sessionType(sessionNum) == 3
            if responseKey==0
                drawAndCenterText(w, 'Disks and Animals simultaneously \n\n First respond to disk (Red on left (1) or right (2)). \n Second respond to Animal (left)/No Animal (right). \n Always attend to the DISK.  \n\n (press key to begin)...');
            else
                drawAndCenterText(w, 'Disks and Animals simultaneously \n\n First respond to disk (Red on left (1) or right (2)). \n Second respond to Animal (right)/No Animal (left). \n Always attend to the DISK.  \n\n (press key to begin)...');
            end    
        end
        
        
        % Tell Netstation to start recording
        if exptdesign.netstationPresent
            [status error] = NetStation('StartRecording');
            if status ==1 % there was an error!
                status;
                error;
                ME = MException('NETSTATION:CouldNotRecord', ['Could not tell Netstation to start recording.  Please check the IP and connection and try again.\n  Error:' error]);
                throw(ME);
            end
            %  Wait for Netstation to Start Recording
            WaitSecs(2);
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %		TRIALS
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Set up the output data structure for all trials in this session
        trialOutput(sessionNum).sessionNum = sessionNum;
        trialOutput(sessionNum).cueType=cueType;
        fixDotSize=20;
        fixCol=0.2;

        for trial = 1:exptdesign.numTrialsPerSession;
            %  Set up the trial output data
            trialOutput(sessionNum).trials(trial).numSessions = exptdesign.numSessions;
            trialOutput(sessionNum).trials(trial).sessionIndex = sessionNum;
            trialOutput(sessionNum).trials(trial).numTrials = exptdesign.numTrialsPerSession;
            trialOutput(sessionNum).trials(trial).trialIndex = trial;
            trialOutput(sessionNum).trials(trial).trialStartTime= GetSecs;
            
            
            
            [perifLocX, perifLocY] = perifLocation(exptdesign, w);
            
            % Fixation display
            Screen('DrawTexture', w, fixationTexture);
%             if exptdesign.netstationPresent
%                 Screen('FillRect',w,black,[0 0 32 32]);  % This is the stimulus marker block for the photodiode
%             end
            [FixationVBLTimestamp FixationOnsetTime FixationFlipTimestamp FixationMissed] = Screen('Flip',w);

            
            %first do the peripheral cue, irrespective of what type of
            %trial we'll have
            
            if exptdesign.cuePeripheralLocation
%                --brackets 2 frames
                 %make a dot at center or periphery, flip the dot
                 if cueType
                     %dot in periphery;
                     fixDotRect = CenterRect([0 0 fixDotSize fixDotSize], windowRect);
                     Screen('DrawTexture', w, fixationTexture);
                     %Screen('FillOval', w, fixCol,[perifLocX perifLocY perifLocX+fixDotSize perifLocY+fixDotSize]);
                     Screen('DrawTexture', w, cueTexture, [], [perifLocX perifLocY perifLocX+exptdesign.perifWdth perifLocY + exptdesign.perifHt]);
                     [cueVBLTimestamp cueOnsetTime cueFlipTimestamp cueMissed] = Screen('Flip',w, FixationVBLTimestamp + exptdesign.fixationDuration - slack);
                     %flip the dot at latency of FixationVBLTimestamp
    %                --fixation 3 frames
                     Screen('DrawTexture', w, fixationTexture);
                     [Fixation2VBLTimestamp Fixation2OnsetTime Fixation2FlipTimestamp Fixation2Missed] = Screen('Flip',w, cueVBLTimestamp + exptdesign.cueDuration - slack);
                 end
                 
            end
            
            if displayCentral && displayPerif %dual task trials
                %put the central AND peripheral up for 2 frames
                if responseKey==0
                    correctCentResponse = centstimulustypemarker(trial);
                else
                    correctCentResponse = double(not(centstimulustypemarker(trial)));
                end
                stimulusTexture = Screen('MakeTexture', w, squeeze(centallimages(trial,:,:,:)));
                Screen('DrawTexture', w, stimulusTexture)
                drawPics(exptdesign, w, allimages, trial, perifLocX, perifLocY);
                if exptdesign.cuePeripheralLocation %give stimulus relative to second fixation
                    if cueType
                        [CentStimulusVBLTimestamp CentStimulusOnsetTime CentStimulusFlipTimestamp CentStimulusMissed] = Screen('Flip',w,Fixation2VBLTimestamp + exptdesign.fixation2Duration - slack);
                    end
                else
                    [CentStimulusVBLTimestamp CentStimulusOnsetTime CentStimulusFlipTimestamp CentStimulusMissed] = Screen('Flip',w,FixationVBLTimestamp + exptdesign.fixationDuration - slack);
                end
                PerifStimulusVBLTimestamp = CentStimulusVBLTimestamp;
                PerifStimulusOnsetTime = CentStimulusOnsetTime;
                PerifStimulusFlipTimestamp = CentStimulusFlipTimestamp;
                PerifStimulusMissed = CentStimulusMissed;
                   
                %blank center and peripheral both after perifStimulusDuration (2 frames)
                Screen('DrawTexture', w, blankTexture);
                [BlankPerifVBLTimestamp BlankPerifOnsetTime BlankPerifFlipTimestamp BlankPerifMissed] = Screen('Flip',w,PerifStimulusVBLTimestamp + exptdesign.perifStimulusDuration - slack); %+ perifSOA - slack);

                
                switch screenOrder
                    case 1
                        %central mask on after central SOA
                        stimulusTexture = Screen('MakeTexture', w, squeeze(centmaskimages(trial,:,:,:)));
                        Screen('DrawTexture', w, stimulusTexture)
                        [CentMaskVBLTimestamp CentMaskOnsetTime CentMaskFlipTimestamp CentMaskMissed] = Screen('Flip',w,CentStimulusVBLTimestamp + centSOA - slack);
                        
                        %peripheral mask on after peripheral SOA, rewrite Central
                        %Mask too, also indicate how to respond
                        drawPerifMask(exptdesign, w, perifLocX, perifLocY, trial, maskimages);
                        stimulusTexture = Screen('MakeTexture', w, squeeze(centmaskimages(trial,:,:,:)));
                        
                        Screen('DrawTexture', w, stimulusTexture)
                        if responseKey==0
                            DrawFormattedText(w, 'Red on left? Press 1 \n Animal? Press Left', 'center', [120], 0);
                        else
                            DrawFormattedText(w, 'Red on left? Press 1 \n Animal? Press Right', 'center', [120], 0);
                        end
                        [PerifMaskVBLTimestamp PerifMaskOnsetTime PerifMaskFlipTimestamp PerifMaskMissed] = Screen('Flip',w,PerifStimulusVBLTimestamp + perifSOA - slack);
                    case 2
                        %central mask on after central SOA and peripheral
                        %at same time
%                         stimulusTexture = Screen('MakeTexture', w, squeeze(centmaskimages(trial,:,:,:)));
%                         Screen('DrawTexture', w, stimulusTexture)
%                         [CentMaskVBLTimestamp CentMaskOnsetTime CentMaskFlipTimestamp CentMaskMissed] = Screen('Flip',w,CentStimulusVBLTimestamp + centSOA - slack);
%                         
                        %peripheral mask on after peripheral SOA, rewrite Central
                        %Mask too, also indicate how to respond
                        drawPerifMask(exptdesign, w, perifLocX, perifLocY, trial, maskimages);
                        stimulusTexture = Screen('MakeTexture', w, squeeze(centmaskimages(trial,:,:,:)));
                        
                        Screen('DrawTexture', w, stimulusTexture)
                        if responseKey==0
                            DrawFormattedText(w, 'Red on left? Press 1 \n Animal? Press Left', 'center', [120], 0);
                        else
                            DrawFormattedText(w, 'Red on left? Press 1 \n Animal? Press Right', 'center', [120], 0);
                        end
                        [PerifMaskVBLTimestamp PerifMaskOnsetTime PerifMaskFlipTimestamp PerifMaskMissed] = Screen('Flip',w,PerifStimulusVBLTimestamp + perifSOA - slack);
                        CentMaskVBLTimestamp=PerifMaskVBLTimestamp;
                        CentMaskOnsetTime=PerifMaskOnsetTime;
                        CentMaskFlipTimestamp=PerifMaskFlipTimestamp;
                        CentMaskMissed=PerifMaskMissed;
                    otherwise
                        %peripheral mask first
                        drawPerifMask(exptdesign, w, perifLocX, perifLocY, trial, maskimages);
                        [PerifMaskVBLTimestamp PerifMaskOnsetTime PerifMaskFlipTimestamp PerifMaskMissed] = Screen('Flip',w,PerifStimulusVBLTimestamp + perifSOA - slack);
                        %central mask on after central SOA
                        stimulusTexture = Screen('MakeTexture', w, squeeze(centmaskimages(trial,:,:,:)));
                        Screen('DrawTexture', w, stimulusTexture)
                       % [CentMaskVBLTimestamp CentMaskOnsetTime CentMaskFlipTimestamp CentMaskMissed] = Screen('Flip',w,CentStimulusVBLTimestamp + centSOA - slack);
                        
                        %peripheral mask on after peripheral SOA, rewrite Central
                        %Mask too, also indicate how to respond
                        drawPerifMask(exptdesign, w, perifLocX, perifLocY, trial, maskimages);
                        stimulusTexture = Screen('MakeTexture', w, squeeze(centmaskimages(trial,:,:,:)));
                        
                        Screen('DrawTexture', w, stimulusTexture)
                        if responseKey==0
                            DrawFormattedText(w, 'Red on left? Press 1 \n Animal? Press Left', 'center', [120], 0);
                        else
                            DrawFormattedText(w, 'Red on left? Press 1 \n Animal? Press Right', 'center', [120], 0);
                        end
                       [CentMaskVBLTimestamp CentMaskOnsetTime CentMaskFlipTimestamp CentMaskMissed] = Screen('Flip',w,CentStimulusVBLTimestamp + centSOA - slack);
                        
                end
                
            elseif displayCentral && ~displayPerif %center-only trials
                %put the center for 2 frames
                 if responseKey==0
                    correctCentResponse = centstimulustypemarker(trial);
                else
                    correctCentResponse = double(not(centstimulustypemarker(trial)));
                end
                stimulusTexture = Screen('MakeTexture', w, squeeze(centallimages(trial,:,:,:)));
                Screen('DrawTexture', w, stimulusTexture)

                [CentStimulusVBLTimestamp CentStimulusOnsetTime CentStimulusFlipTimestamp CentStimulusMissed] = Screen('Flip',w,FixationVBLTimestamp + exptdesign.fixationDuration - slack);
   
                %blank 
                Screen('DrawTexture', w, blankTexture);
                %yes that latency is the perifStimulusDuration (for case of both 2 ms)
                [BlankPerifVBLTimestamp BlankPerifOnsetTime BlankPerifFlipTimestamp BlankPerifMissed] = Screen('Flip',w,CentStimulusVBLTimestamp + exptdesign.perifStimulusDuration - slack); %+ perifSOA - slack);

                %central mask on after central SOA 
                stimulusTexture = Screen('MakeTexture', w, squeeze(centmaskimages(trial,:,:,:)));
                Screen('DrawTexture', w, stimulusTexture)
                if responseKey==0
                    DrawFormattedText(w, 'Animal? Press Left', 'center', [120], 0);
                else
                    DrawFormattedText(w, 'Animal? Press Right', 'center', [120], 0);
                end
                [CentMaskVBLTimestamp CentMaskOnsetTime CentMaskFlipTimestamp CentMaskMissed] = Screen('Flip',w,CentStimulusVBLTimestamp + centSOA - slack);
                
            elseif ~displayCentral && displayPerif %perif-only trials
                %put peripheral 2 frames
                drawPics(exptdesign, w, allimages, trial, perifLocX, perifLocY);
                if exptdesign.cuePeripheralLocation %give stimulus relative to second fixation
                    if cueType
                          [PerifStimulusVBLTimestamp PerifStimulusOnsetTime PerifStimulusFlipTimestamp PerifStimulusMissed] = Screen('Flip',w,FixationVBLTimestamp + exptdesign.fixation2Duration - slack);
                    end
                else
                    [PerifStimulusVBLTimestamp PerifStimulusOnsetTime PerifStimulusFlipTimestamp PerifStimulusMissed] = Screen('Flip',w,FixationVBLTimestamp + exptdesign.fixationDuration - slack);
                end
                
                
                
                
                
                [PerifStimulusVBLTimestamp PerifStimulusOnsetTime PerifStimulusFlipTimestamp PerifStimulusMissed] = Screen('Flip',w,FixationVBLTimestamp + exptdesign.fixationDuration - slack);
                   
                %blank 
                Screen('DrawTexture', w, blankTexture);
                [BlankPerifVBLTimestamp BlankPerifOnsetTime BlankPerifFlipTimestamp BlankPerifMissed] = Screen('Flip',w,PerifStimulusVBLTimestamp + exptdesign.perifStimulusDuration - slack); %+ perifSOA - slack);

                %peripheral mask
                drawPerifMask(exptdesign, w, perifLocX, perifLocY, trial, maskimages);
                DrawFormattedText(w, 'Red on left? Press 1', 'center', [120], 0);
                [PerifMaskVBLTimestamp PerifMaskOnsetTime PerifMaskFlipTimestamp PerifMaskMissed] = Screen('Flip',w,PerifStimulusVBLTimestamp + perifSOA - slack);
            end
            
            
            %%%%
            
            if displayPerif
                PerifResponseStartTime = GetSecs;
                if exptdesign.waitForPerifResponse
                    numericalanswerPerif = getPerifResponseWait();
                else
                    numericalanswerPerif = getPerifResponse(exptdesign.responseDuration);
                end
                PerifResponseFinishedTime = GetSecs;
                trialOutput(sessionNum).trials(trial).subjectPerifResponse = numericalanswerPerif;
            end
            
            % Record the response of the subject
            if displayCentral
                CentResponseStartTime = GetSecs;
                if exptdesign.waitForCentResponse
                    numericalanswerCent = getCentResponseWait();
                else
                    numericalanswerCent = getCentResponse(exptdesign.responseDuration);
                end
                CentResponseFinishedTime = GetSecs;
                trialOutput(sessionNum).trials(trial).subjectCentResponse = numericalanswerCent;
            end
            
            %  Blank the screen until the next trial
            Screen('DrawTexture', w, blankTexture);
%             if exptdesign.netstationPresent
%                 Screen('FillRect',w,black,[0 0 32 32]);  % This is the stimulus marker block for the photodiode
%             end
            if displayCentral
                [BlankResponseVBLTimestamp BlankResponseOnsetTime BlankResponseFlipTimestamp BlankResponseMissed] = Screen( 'Flip',w,CentMaskVBLTimestamp + exptdesign.maskDuration-slack);
            elseif displayPerif
                [BlankResponseVBLTimestamp BlankResponseOnsetTime BlankResponseFlipTimestamp BlankResponseMissed] = Screen( 'Flip',w,PerifMaskVBLTimestamp + exptdesign.maskDuration-slack);
            end
            

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %    TRIAL OUTPUTS
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %  Record the end time for the trial
            trialOutput(sessionNum).trials(trial).trialEndTime = GetSecs;



            
            if displayPerif
                % PERIPHERAL TASK DATA
                % Record whether the subject got the right answer
                trialOutput(sessionNum).trials(trial).correctPerifResponse = stimulustypemarker(trial);
                trialOutput(sessionNum).trials(trial).subjectHasRightPerifAnswer = trialOutput(sessionNum).trials(trial).correctPerifResponse == trialOutput(sessionNum).trials(trial).subjectPerifResponse;
                if trialOutput(sessionNum).trials(trial).correctPerifResponse == trialOutput(sessionNum).trials(trial).subjectPerifResponse;
                    perifCorrectArray(trial) = 1;
                    if exptdesign.giveFeedback
                        Snd('Play', good)
                    end
                else
                    if exptdesign.giveFeedback
                        Snd('Play', bad)
                    end
                end

                % Record the filenames used for stimulus and masks
                trialOutput(sessionNum).trials(trial).stimulusImageFile = allimagefiles(trial).name;
                trialOutput(sessionNum).trials(trial).perifMaskImageFile = maskimagefiles(maskorder(trial)).name;
                trialOutput(sessionNum).trials(trial).perifMaskImageType = maskorder(trial);
                trialOutput(sessionNum).trials(trial).perifXLocation = perifLocX;
                trialOutput(sessionNum).trials(trial).perifYLocation = perifLocY;
                %trialOutput(sessionNum).trials(trial).maskImageFile = maskimagefiles(trial).name;

                trialOutput(sessionNum).trials(trial).perifStimulusOnset = PerifStimulusOnsetTime;
                trialOutput(sessionNum).trials(trial).perifStimulusDuration = PerifMaskOnsetTime - PerifStimulusOnsetTime;  % record the actual time on the screen (just to be accurate)

                trialOutput(sessionNum).trials(trial).PerifResponseStart = PerifResponseStartTime;
                trialOutput(sessionNum).trials(trial).PerifResponseFinished = PerifResponseFinishedTime;  % record the actual time the blank was on the screen (just to be accurate)
                
                trialOutput(sessionNum).trials(trial).perifStimulusMissed = PerifStimulusMissed;
                trialOutput(sessionNum).trials(trial).perifMaskMissed = PerifMaskMissed;
                trialOutput(sessionNum).trials(trial).blankPerifMissed = BlankPerifMissed;
                

            end
            
            if displayCentral

                % Record the trial type data
                %trialOutput(sessionNum).trials(trial).letterPostions = lettersDrawn;
                %trialOutput(sessionNum).trials(trial).spinAngle = spinAngle;
                %trialOutput(sessionNum).trials(trial).trialType = ltChosen;


                % CENTRAL TASK DATA
                % Record whether the subject got the right answer
                trialOutput(sessionNum).trials(trial).correctCentResponse = correctCentResponse;
                trialOutput(sessionNum).trials(trial).subjectHasRightCentAnswer = trialOutput(sessionNum).trials(trial).correctCentResponse == trialOutput(sessionNum).trials(trial).subjectCentResponse;
                if trialOutput(sessionNum).trials(trial).correctCentResponse == trialOutput(sessionNum).trials(trial).subjectCentResponse
                    centCorrectArray(trial) = 1;
                   if exptdesign.giveFeedback
                       Snd('Play', good)
                    end
                else
                   if exptdesign.giveFeedback
                       Snd('Play', bad)
                   end
                end

                trialOutput(sessionNum).trials(trial).fixationDuration = CentStimulusOnsetTime - FixationOnsetTime;  % record the actual time on screen (just to be accurate)

                trialOutput(sessionNum).trials(trial).centStimulusOnset = CentStimulusOnsetTime;
                trialOutput(sessionNum).trials(trial).centStimulusDuration = CentMaskOnsetTime - CentStimulusOnsetTime;  % record the actual time on screen (just to be accurate)


                trialOutput(sessionNum).trials(trial).CentResponseStart = CentResponseStartTime;
                trialOutput(sessionNum).trials(trial).CentResponseFinished = CentResponseFinishedTime; %record the actual time the blank was on the screen (just to be accurate)

                trialOutput(sessionNum).trials(trial).centStimulusMissed = CentStimulusMissed;

                trialOutput(sessionNum).trials(trial).centMaskMissed = CentMaskMissed;
            end
            
            % Calculate and record trial timing
            trialOutput(sessionNum).trials(trial).fixationOnset = FixationOnsetTime;
            
            trialOutput(sessionNum).trials(trial).fixationMissed = FixationMissed;
           
            trialOutput(sessionNum).trials(trial).centSOA = centSOA;
            trialOutput(sessionNum).trials(trial).perifSOA = perifSOA;
            trialOutput(sessionNum).centSOA=centSOA;
            trialOutput(sessionNum).perifSOA=perifSOA;
            
            
   
            
            % If the trial is the last one of the session, calculate the percentage of
            % trials the subject answered correctly.
            if trial == exptdesign.numTrialsPerSession
                 numCentCorrect = length(find(centCorrectArray==1));
                 trialOutput(sessionNum).centPerformance = numCentCorrect / exptdesign.numTrialsPerSession;
   
                 numPerifCorrect = length(find(perifCorrectArray==1));
                 trialOutput(sessionNum).perifPerformance = numPerifCorrect / exptdesign.numTrialsPerSession;
                 
            end           
        end
        message=' ';
        if displayCentral
             message=['Your central task accuracy was ' round(num2str(trialOutput(sessionNum).centPerformance*100)) ' percent \n\n'];
        end
        if displayPerif
             message=[message 'Your peripheral task accuracy was ' round(num2str(trialOutput(sessionNum).perifPerformance*100)) ' percent \n\n'];
        end
        message = [message 'Press any key to continue'];
        drawAndCenterText(w,message);

        
        if exptdesign.netstationPresent
            %  Tell Netstation to Stop Recording
            [status error] = NetStation('StopRecording');
            if status ==1 % there was an error!
                status;
                error;
                ME = MException('NETSTATION:CouldNotStopRecording', ['Could not tell Netstation to stop recording.  Please check the IP and connection and try again.\n  Error:' error]);
                throw(ME);
            end
        end
        


        %  Write the trial specific data to the output file.
        tic;
        save(['./Animal_data/' exptdesign.subjectName '/' exptdesign.subjectName '.' num2str(sessionNum) '.' num2str(trial) '.mat'],'trialOutput','exptdesign');
     %   save(['./SOAs/SUBJ' exptdesign.number 'soas.mat'], 'centSOA', 'perifSOA');
        toc;
        
        %if the subject has finished a 3-block subset of trials, calculate
        %the new central and peripheral SOAs and re-assign them
        if exptdesign.sessionType(sessionNum) == 3
            %check central performance on last 3 blocks
            centPerformance(1) = trialOutput(sessionNum).centPerformance;
            
            %check perif performance on last 3 blocks
            perifPerformance(1) = trialOutput(sessionNum).perifPerformance;
            
            %remove zeros
            centPerformance=centPerformance(centPerformance>0);
            perifPerformance=perifPerformance(perifPerformance>0);
            centSOAtemp=exptdesign.centSOADurations;
            if max(centPerformance)>0.80
                centSOAtemp = max(exptdesign.centSOADurations - exptdesign.refresh*2, exptdesign.refresh*2);
            end
            perifSOAtemp=exptdesign.perifSOADurations;
            if max(perifPerformance)>0.80
                perifSOAtemp = max(exptdesign.perifSOADurations - exptdesign.refresh*2, exptdesign.refresh*2);
            end
            
            if min(centPerformance)<0.70
                centSOAtemp = exptdesign.centSOADurations + exptdesign.refresh*1;
            end
            
            if min(perifPerformance)<0.70
                perifSOAtemp = exptdesign.perifSOADurations + exptdesign.refresh*1;
            end
            
            
            
        end
        if mod(sessionNum,3)==0
            exptdesign.centSOADurations=centSOAtemp;
            message=['Your central task timing is now ' num2str(round(exptdesign.centSOADurations./0.0167)) '\n\n'];
            if round(exptdesign.centSOADurations./0.0167)> 5
                 message = [message 'Central timing must be less than 6 by end of this phase \n\n'];
            end
            exptdesign.perifSOADurations = perifSOAtemp;
            message = [message 'Your peripheral task timing is now ' num2str(round(exptdesign.perifSOADurations./0.0167)) '\n\n'];
            if round(exptdesign.perifSOADurations./0.0167)> 8 
                message = [message 'Peripheral timing must be less than 9 by end of this phase \n\n'];
            end
            drawAndCenterText(w,message);
        end
      centSOA=round(exptdesign.centSOADurations./0.0167);
      perifSOA=round(exptdesign.perifSOADurations./0.0167);
        
        
         tic;
       % save(['./data/' exptdesign.subjectName '/' exptdesign.subjectName '.' num2str(sessionNum) '.' num2str(trial) '.mat'],'trialOutput','exptdesign');
         save(['./SOAs/SUBJ' exptdesign.number 'soas.mat'], 'centSOA', 'perifSOA');
        toc;
        

        %  Display a short break message
        if ( sessionNum < exptdesign.numSessions)
            drawAndCenterText(w,['End of Session #' num2str(sessionNum) '.\n\n Please take a short break.\n  Then press any key to continue.']);
        else
            drawAndCenterText(w,['End of Session #' num2str(sessionNum) '.\n\n Thank you for participating!\n  Press any key to end the experiment.']);
        end

        %  Close all open textures
        Screen('Close', fixationTexture);
        Screen('Close', blankTexture);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %		END
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    % End of demo, close window:
    Screen('CloseAll');
    Priority(0);
    % At the end of your code, it is a good idea to restore the old level.
    %     Screen('Preference','SuppressAllWarnings',oldEnableFlag);

    catch
    % This "catch" section executes in case of an error in the "try"
    % section []
    if exptdesign.netstationPresent
        % Tell Netstation to stop recording
        [status error] = NetStation('StopRecording');
        if status ==1 % there was an error!
            status;
            error;
            ME = MException('NETSTATION:CouldNotStopRecord', ['Could not tell Netstation to stop recording.  Please check the IP and connection and try again.\n  Error:' error]);
            %              throw(ME);
            disp('ERROR stopping recoring in Netstation!');
        end

        [status error] = NetStation('Disconnect');
        if status ==1 % there was an error!
            status;
            error;
            ME = MException('NETSTATION:CouldNotStopRecord', ['Could not tell Netstation to stop recording.  Please check the IP and connection and try again.\n  Error:' error]);
            %              throw(ME);
            disp('ERROR disconnecting from Netstation!');

        end
    end

    % above.  Importantly, it closes the onscreen window if it's open.
    disp('Caught error and closing experiment nicely....');
    Screen('CloseAll');
    Priority(0);
    fclose('all');
    psychrethrow(psychlasterror);

end
end



% Function sets the SOA for the central task so that the SOA < 205 msec and
% so that the subject's performance is less than 85%
%
% INPUT:    exptdesign, window, and slack are all basic information created by
%           the main function
%
% OUTPUT:   centSOA-the new SOA for the subject as determined by the function
%           centPerformance-the subject's performance as calculated by the function
function [centSOA, centPerformance] = determineCentSOA(exptdesign, window, slack)
count = 0;
centSOA = exptdesign.centSOADurations;
black = BlackIndex(window);
performance = 1;
while count < exptdesign.sessionsPerCentPractice || centSOA > 0.250 || performance > 0.85 || performance < 0.70

    % Prepare an array to record the performance of the subject
    correctarray = zeros(1,exptdesign.numTrialsPerSession);
    count = count + 1;
    prevSOA = centSOA;
    drawAndCenterText(window,'Press "S" if the letters in the center of the screen are the SAME \n and "D" if they are DIFFERENT. \n \n Please respond as quickly and as accurately as possible \n \n \n Setting up session, please wait.',0)

    % FIXATION IMAGE
    fixationImage = imread(exptdesign.fixationImage);

    % BLANK IMAGE
    blankImage = imread(exptdesign.blankImage);
    size(blankImage)

% %     % LETTERS
% %     letterT = imread(exptdesign.Tgraphic);
% %     letterL = imread(exptdesign.Lgraphic);
% %     letterF = imread(exptdesign.Fgraphic);

    fixationTexture=Screen('MakeTexture', window, double(fixationImage));
    blankTexture=Screen('MakeTexture', window, double(blankImage));

    drawAndCenterText(window,'Press "S" if the letters in the center of the screen are the SAME \n and "D" if they are DIFFERENT. \n \n Please respond as quickly and as accurately as possible \n \n \n Press any key to continue...')


    for numTrial = 1:exptdesign.numTrialsPerSession
        % Fixation display
        Screen('DrawTexture', window, fixationTexture);
%         if exptdesign.netstationPresent
%             Screen('FillRect',window,black,[0 0 32 32]);  % This is the stimulus marker block for the photodiode
%         end
        [FixationVBLTimestamp FixationOnsetTime FixationFlipTimestamp FixationMissed] = Screen('Flip',window);

         % Central Stimulus
        [correct, spinAngle, lettersDrawn, ltChosen, different] = drawLetters(exptdesign, window, letterT, letterL);
        [CentStimulusVBLTimestamp CentStimulusOnsetTime CentStimulusFlipTimestamp CentStimulusMissed] = Screen('Flip',window,FixationVBLTimestamp + exptdesign.fixationDuration - slack);

        % Central Mask
        drawCentMask(exptdesign, window, letterF, spinAngle, lettersDrawn)
        [CentMaskVBLTimestamp CentMaskOnsetTime CentMaskFlipTimestamp CentMaskMissed] = Screen('Flip',window,CentStimulusVBLTimestamp + centSOA - slack);

        % Record the subject's response
        CentResponseStartTime = GetSecs;
        numericalanswerCent = getCentResponseWait();
        CentResponseFinishedTime = GetSecs;

        % Record whether or not the response was correct
        if correct == numericalanswerCent
            correctarray(numTrial) = 1;
        end

        %  Blank the screen until the next trial
        Screen('DrawTexture', window, blankTexture);
%         if exptdesign.netstationPresent
%             Screen('FillRect',window,black,[0 0 32 32]);  % This is the stimulus marker block for the photodiode
%         end
        [BlankResponseVBLTimestamp BlankResponseOnsetTime BlankResponseFlipTimestamp BlankResponseMissed] = Screen( 'Flip',window,CentMaskVBLTimestamp + exptdesign.maskDuration - slack);
    end

    % Determine the performance of the subject after the last trial of the
    % session
    numcorrect = length(find(correctarray==1));
    performance = numcorrect / exptdesign.numTrialsPerSession;
    if performance >= 0.85
        centSOA = centSOA - 0.25 * centSOA;
    elseif performance < 0.7
        centSOA = centSOA + 0.125 * centSOA;
    end
    if prevSOA == centSOA && count > exptdesign.sessionsPerCentPractice
        break
    end
end
centPerformance = performance;
end



% Serves the same task as the above function, but sets the peripheral SOA
% instead so that it is less than 80 msec.
%
% INPUT:    exptdesign, window, and slack are all basic information created by
%           the main function
%
% OUTPUT:   perifSOA-the new SOA for the subject as determined by the function
%           perifPerformance-the subject's performance as calculated by the
%           function
function [perifSOA, perifPerformance] = determinePerifSOA(exptdesign,window,slack)
count = 0;
perifSOA = exptdesign.perifSOADurations;
performance = 1;
black = BlackIndex(window);
while count < exptdesign.sessionsPerPerifPractice || performance > 0.85 || performance < 0.70
    % Prepare an array to record the performance of the subject
    correctarray = zeros(1,exptdesign.numTrialsPerSession);
    count = count + 1;
    prevSOA = perifSOA;
    
    % Change the message to be displayed on the screen depending on the
    % type of stimulus to be displayed on the periphery
    if exptdesign.animOrCar == 2
        drawAndCenterText(window,'Press the LEFT ARROW KEY if the image contains a circle with RED on the LEFT \n and the RIGHT ARROW KEY if image contains a circle with RED on the RIGHT \n \n Please respond as quickly and as accurately as possible \n \n \n Setting up session, please wait',0)
    elseif exptdesign.animOrCar == 1
        drawAndCenterText(window, 'Press the LEFT ARROW KEY if the image contains a SAVOR \n and the RIGHT ARROW KEY if it contains a ZUPUD \n \n Please respond as quickly and as accurately as possible \n \n \n Setting up session, please wait',0)
    elseif exptdesign.animOrCar == 0
        drawAndCenterText(window,'Press the LEFT ARROW KEY if the image contains an ANIMAL \n and the RIGHT ARROW KEY if it does not \n \n Please respond as quickly and as accurately as possible \n \n \n Setting up session, please wait',0)
    end
    
    % FIXATION IMAGE
    fixationImage = imread(exptdesign.fixationImage);

    % BLANK IMAGE
    blankImage = imread(exptdesign.blankImage);
    size(blankImage)

    fixationTexture=Screen('MakeTexture', window, double(fixationImage));
    blankTexture=Screen('MakeTexture', window, double(blankImage));

    % Load and prep the masks and stimuli
    [allimages, stimulustypemarker, allimagefiles] = prepPics(exptdesign);
    
     [maskimages, maskimagefiles, maskorder] = prepPerifMask(exptdesign);
%     maskimages = loadimages_png(exptdesign.imageDirectory,maskimagefiles(1:2));
%     maskimages = repmat(maskimages, [numTrials, 1, 1, 1]);
%     %maskimages = repmat(maskimages, [exptdesign.numTrialsPerSession, 1, 1, 1]);
%     maskimages = maskimages(randperm(size(maskimages,1)),:,:,:);    %permute masks; not *super* necessary, but still good form
 
    % Change the message to be displayed on the screen depending on the
    % type of stimulus to be displayed on the periphery
    if exptdesign.animOrCar == 2
        drawAndCenterText(window,'Press the LEFT ARROW KEY if the image contains an circle with RED on the LEFT \n and the RIGHT ARROW KEY if image contains an circle with RED on the RIGHT \n \n Please respond as quickly and as accurately as possible \n \n \n Setting up session, please wait',0)
    elseif exptdesign.animOrCar == 1
        drawAndCenterText(window, 'Press the LEFT ARROW KEY if the image contains a SAVOR \n and the RIGHT ARROW KEY if it contains a ZUPUD \n \n Please responnd as quickly and as accurately as possible \n \n \n Press any key to continue...')
    elseif exptdesign.animOrCar == 0
        drawAndCenterText(window,'Press the LEFT ARROW KEY if the image contains an ANIMAL \n and the RIGHT ARROW KEY if it does not \n \n Please respond as quickly and as accurately as possible \n \n \n Press any key to continue...')
    end

    for numTrial = 1:exptdesign.numTrialsPerSession
        % Fixation display
        Screen('DrawTexture', window, fixationTexture);
%         if exptdesign.netstationPresent
%             Screen('FillRect',window,black,[0 0 32 32]);  % This is the stimulus marker block for the photodiode
%         end
        [FixationVBLTimestamp FixationOnsetTime FixationFlipTimestamp FixationMissed] = Screen('Flip',window);

        % Stimulus display
        drawPics(exptdesign, w, allimages, trial, perifLocX, perifLocY);
        [PerifStimulusVBLTimestamp PerifStimulusOnsetTime PerifStimulusFlipTimestamp PerifStimulusMissed] = Screen('Flip',window,FixationVBLTimestamp + exptdesign.fixationDuration - slack);

        % Mask display
        drawPerifMask(exptdesign, window, perifLocX, perifLocY, numTrial, maskimages)
        [PerifMaskVBLTimestamp PerifMaskOnsetTime PerifMaskFlipTimestamp PerifMaskMissed] = Screen('Flip',window,PerifStimulusVBLTimestamp + perifSOA - slack);

        % Record the subject's response
        PerifResponseStartTime = GetSecs;
        numericalanswerPerif = getPerifResponseWait();
        PerifResponseFinishedTime = GetSecs;

        % Record whether or not the subject got the correct answer
        if stimulustypemarker(numTrial) == numericalanswerPerif
            correctarray(numTrial) = 1;
        end

        %  Blank the screen until the next trial
        Screen('DrawTexture', window, blankTexture);
%         if exptdesign.netstationPresent
%             Screen('FillRect',window,black,[0 0 32 32]);  % This is the stimulus marker block for the photodiode
%         end
        [BlankResponseVBLTimestamp BlankResponseOnsetTime BlankResponseFlipTimestamp BlankResponseMissed] = Screen( 'Flip',window,PerifMaskVBLTimestamp + exptdesign.maskDuration - slack);
    end

    % Calculate the performance of the subject after the last trial of the
    % session
    numcorrect = length(find(correctarray==1));
    performance = numcorrect / exptdesign.numTrialsPerSession;
    if performance >= 0.85
        perifSOA = perifSOA - 0.25 * perifSOA;
    elseif performance < 0.85
        perifSOA = perifSOA + 0.125 * perifSOA;
    end
    if prevSOA == perifSOA
        break
    end
end
perifPerformance = performance;
disp(perifSOA)
end



% Loads the images for the peripheral masks
function [maskimages, maskimagefiles, maskorder] = prepPerifMask(exptdesign)

maskimagefiles = dir(exptdesign.maskImages);
if (size(maskimagefiles,1) == 0)
    disp('NO MASK IMAGES!!!!');
    ME = MException('VerifyInput:OutOfBounds', ['NO MASK IMAGES FOUND AT ' exptdesign.cat1Images]);
    throw(ME);
end

% MASKS
%maskimagefiles = maskimagefiles(randperm(size(maskimagefiles,1)));
maskimages = loadimages_png(exptdesign.imageDirectory,maskimagefiles(1:2));
maskimages = repmat(maskimages, [round(exptdesign.numTrialsPerSession/2), 1, 1, 1]);
maskpermute = randperm(size(maskimages,1));
maskorder=repmat([1 2], 1, round(exptdesign.numTrialsPerSession/2));
maskorder=maskorder(maskpermute);
maskimages = maskimages(maskpermute,:,:,:);
end



% Makes and Draws the peripheral mask textures
%
% INPUT:    exptdesign and window are basic information provided by the
%           main function
%           perifLocX - the x coordinate of the peripheral stimulus
%           perifLocY - the y coordinate of the peripheral stimulus
%           trial - the trial number
%           maskimages - a randomly permutated vector of masking images
%
% OUTPUT:   none!!! (the function is used to draw the masking images)
function drawPerifMask(exptdesign, window, perifLocX, perifLocY, trial, maskimages)
%  Make all of the textures and data needed for this trial
maskTexture = Screen('MakeTexture', window, squeeze(maskimages(trial,:,:,:)));

Screen('DrawTexture', window, maskTexture, [], [perifLocX perifLocY perifLocX + exptdesign.perifWdth perifLocY + exptdesign.perifHt])
end


% Makes and draws the letter textures
%
% INPUT:    exptdesign and window are basic variables created by the main
%           function
%           letterT/letterL - the images of the letters loaded using the loadimages
%           function
%           ltChosen - determines whether an L or T s drawn
%           spinAngle - determines the angle that the letter is to be
%           rotated
%           letters - a 5-unit array of 1's and 0's that determines whether
%           a T or L is drawn at a particular location
%           lettersDrawn - determines which 5 of the 9 positions are chosen
%           for the letters
%           (ltChosen, spinAngle, letters, and lettersDrawn are all
%           varialbes that are useed as both inputs and outputs so that the
%           letters can be redrawn later in the same place as before)
%
% OUTPUT:   correctCentResponse - records what the correct response is
function [correctCentResponse, spinAngle, lettersDrawn, ltChosen, different, letters] = drawLetters(exptdesign, window, letterT, letterL, ltChosen, spinAngle,letters,lettersDrawn)
%  Make all of the textures and data needed for this trial
tTexture = Screen('MakeTexture', window, letterT);
lTexture = Screen('MakeTexture', window, letterL);
white = WhiteIndex(window); % pixel value for white

if nargin < 6
    % Add some random degrees to spin the letters...
    spinAngle = [rand*360 rand*360 rand*360 rand*360 rand*360];
end

% Read in the ht/wdth of the letters...
letterDim = exptdesign.letterDim;

% Choose which letters are drawn and whether they are all t's, l's
% or both
if nargin < 8
    lettersDrawn = choose(9,5);
end

% Determine whether (1) all T's, (2) 4 T's and 1 L, (3) 4 L's and 1 T, or
% (4) all L's appear on the screen
if nargin < 5
    different = -1;
    ltChosen = choose(4,1);
    if ltChosen == 1
        letters = zeros(1,5);
        correctCentResponse = 0;

    elseif ltChosen == 2
        letters = zeros(1,5);
        letters(choose(5,1)) = 1;
        different = find(letters == 1);
        correctCentResponse = 1;

    elseif ltChosen == 3
        letters = ones(1,5);
        letters(choose(5,1)) = 0;
        different = find(letters == 0);
        correctCentResponse = 1;

    elseif ltChosen == 4;
        letters = ones(1,5);
        correctCentResponse = 0;
    end
end

%determine whether to draw the five letters to the screen

    % Draw the five letters to the screen
    count = 5;
    while count > 0
        % Use another function to determine the position of the 5 letters
        xPos = findLetterPosition(window, lettersDrawn(count), 0, exptdesign);
        yPos = findLetterPosition(window, lettersDrawn(count), 1, exptdesign);

        % Draw either (1) a T or (2) an L on the screen
        if letters(count) == 0
            Screen('DrawTexture', window, tTexture, [], [xPos yPos xPos+letterDim yPos+letterDim], spinAngle(count))
        elseif letters(count) == 1
            Screen('DrawTexture', window, lTexture, [], [xPos yPos xPos+letterDim yPos+letterDim], spinAngle(count))
        end
        count = count - 1;
    end
%     if exptdesign.netstationPresent
%         Screen('FillRect',window,white,[0 0 32 32]);  % This is the stimulus marker block for the photodiode
%     end

end

function [correctCentResponse, spinAngle, lettersDrawn, ltChosen, different, letters] = generateLetters(ltChosen, spinAngle,letters,lettersDrawn)

if nargin < 2
    % Add some random degrees to spin the letters...
    spinAngle = [rand*360 rand*360 rand*360 rand*360 rand*360];
end

% Choose which letters are drawn and whether they are all t's, l's
% or both
if nargin < 4
    lettersDrawn = choose(9,5);
end

% Determine whether (1) all T's, (2) 4 T's and 1 L, (3) 4 L's and 1 T, or
% (4) all L's appear on the screen
if nargin < 1
    different = -1;
    ltChosen = choose(4,1);
    if ltChosen == 1
        letters = zeros(1,5);
        correctCentResponse = 0;

    elseif ltChosen == 2
        letters = zeros(1,5);
        letters(choose(5,1)) = 1;
        different = find(letters == 1);
        correctCentResponse = 1;

    elseif ltChosen == 3
        letters = ones(1,5);
        letters(choose(5,1)) = 0;
        different = find(letters == 0);
        correctCentResponse = 1;

    elseif ltChosen == 4;
        letters = ones(1,5);
        correctCentResponse = 0;
    end
end

end


% Function takes input from the "drawLetters" function and outputs a
% randomly chosen position for the letter to be drawn in
%
% INPUT:    window and exptdesign are basic variables created by the main function
%           numPos - designates one of the nine possible positions for the
%           letters to appear at
%           xory - determines whether the function finds the x or the y
%           coordinate of the letter to be drawn
%
% OUTPUT:   none!!!
function position = findLetterPosition(window, numPos, xory, exptdesign)
% Read in the ht/wdth of the letters...
letterDim = exptdesign.letterDim;

% Caclulate the radius of the circle to be formed by the
% spinning letters....
rad = sqrt(2*((letterDim/2)^2));

[windowWdth windowHt] = Screen('WindowSize', window);
if xory == 0;
    posArrayX = [windowWdth/2 windowWdth/2 - 1.25*rad windowWdth/2 + 1.25*rad windowWdth/2 + 2.5*rad windowWdth/2 + 2.5*rad windowWdth/2 + 1.25*rad windowWdth/2 - 1.25*rad windowWdth/2 - 2.5*rad windowWdth/2 - 2.5*rad];
    position = posArrayX(numPos);
elseif xory == 1;
    posArrayY = [windowHt/2 windowHt/2 - 2.5*rad windowHt/2 - 2.5*rad windowHt/2 - 1.25*rad windowHt/2 + 1.25*rad windowHt/2 + 2.5*rad windowHt/2 + 2.5*rad windowHt/2 + 1.25*rad windowHt/2 - 1.25*rad];
    position = posArrayY(numPos);
end
end


% Choose a number (numselections) of numbers between 1 and "numOptions"
function chosen = choose(numOptions, numSelections)
array = [1:numOptions];
scramArray = randperm(length(array));
chosen = scramArray(1:numSelections);
end



% Records the peripheral response of the subject
function numericalanswerPerif = getPerifResponseWait()
numericalanswerPerif = -1;
while numericalanswerPerif == -1
    [secs, keyCode] = KbPressWait;
    if sum(keyCode)==1
        numericalanswerPerif = translateKeyPerifResponse(keyCode);
    end 
end
end



% Draws the central mask (the letter F) in the same positions and
% orientations as  the stimuli
%
% INPUT:    exptdesign and window are basic variables provided by the main
%           function
%           letterF - the image of the letterF to be used as the masking
%           image
%           spinAngle -  the angles that the original central stimuli were
%           rotated by
%           lettersDrawn -  the 5 positions that the stimuli were drawn at
function drawCentMask(exptdesign, window, letterF, spinAngle, lettersDrawn)
fTexture = Screen('MakeTexture', window, letterF);
% Read in the ht/wdth of the letters...
letterDim = exptdesign.letterDim;

% Draw the five letters to the screen
count = 5;
while count > 0
    xPos = findLetterPosition(window, lettersDrawn(count), 0, exptdesign);
    yPos = findLetterPosition(window, lettersDrawn(count), 1, exptdesign);
    Screen('DrawTexture', window, fTexture, [], [xPos yPos xPos+letterDim yPos+letterDim], spinAngle(count) + 180)
    count = count - 1;
end
end



% Calls another function to load the pictures.  Puts the target and
% distractor images into a vector and mixes the drink.  Outputs a permuted
% list of randomly chosen and ordered targets and distractors.
%
% INPUT:    exptdesign...nuff said
%
% OUTPUT:   allimages - the permuted vector of targets and distractors
%           stimulustypemarker - tells the function whether each image is a
%           target or a distractor
 function [allimages, stimulustypemarker, allimagefiles] = prepPics(exptdesign)

cat1files = dir(exptdesign.cat1Images);
if (size(cat1files,1) == 0)
    disp('NO CATEGORY 1 IMAGES!!!!');
    ME = MException('VerifyInput:OutOfBounds', ['NO CATEGORY 1 IMAGES FOUND AT ' exptdesign.cat1Images]);
    throw(ME);
end

cat2files = dir(exptdesign.cat2Images);
if (size(cat2files,1) == 0)
    disp('NO CATEGORY 2 IMAGES!!!!');
    ME = MException('VerifyInput:OutOfBounds', ['NO CATEGORY 2 IMAGES FOUND AT ' exptdesign.cat2Images]);
    throw(ME);
end

%  Load and randomize first images and second category images
%  Peripheral CATEGORY 1
%cat1files = cat1files(randperm(size(cat1files,1)));
%cat1Images = loadimages(exptdesign.cat1Directory,cat1files(1:exptdesign.numCat1PerSession));
cat1Images = loadimages_png(exptdesign.cat1Directory,cat1files);

 
%  Peripheral CATEGORY 2
%cat2files = cat2files(randperm(size(cat2files,1)));
%cat2Images = loadimages(exptdesign.cat2Directory,cat2files(1:exptdesign.numCat2PerSession));
cat2Images = loadimages_png(exptdesign.cat2Directory,cat2files);


%  Put all the PERIPHERAL CATEGORY 1 and CATEGORY 2 in one vector and permute it
permutation = randperm(exptdesign.numTrialsPerSession);
stimulustypemarker = [ones(1,exptdesign.numCat1PerSession) zeros(1,exptdesign.numCat2PerSession,1)];
stimulustypemarker = stimulustypemarker(permutation);

clear allimagefiles;
clear allimages allimages2;
%allimagefiles(:,1) = cat1files(1:exptdesign.numCat1PerSession,1);
allimagefiles(:,1) = repmat(cat1files, 1, exptdesign.numCat1PerSession);
%allimagefiles(exptdesign.numCat1PerSession+1:exptdesign.numCat1PerSession+exptdesign.numCat2PerSession,1) = cat2files(1:exptdesign.numCat2PerSession,1);
allimagefiles(exptdesign.numCat1PerSession+1:exptdesign.numCat1PerSession+exptdesign.numCat2PerSession,1) = repmat(cat2files, 1, exptdesign.numCat2PerSession);
allimagefiles = allimagefiles(permutation,1);

                     
%allimages(:,:,:,:) = cat1Images(:,:,:,:);
%allimages(exptdesign.numCat1PerSession+1:exptdesign.numCat1PerSession+exptdesign.numCat2PerSession,:,:,:) = cat2Images(:,:,:,:);
%allimages = allimages(permutation,:,:,:);

allimages(:,:,:,:) = repmat(cat1Images, [exptdesign.numCat1PerSession, 1, 1, 1]);
allimages2(:,:,:,:) = repmat(cat2Images, [exptdesign.numCat2PerSession, 1, 1, 1]);
allimages = cat(1, allimages, allimages2);
allimages = allimages(permutation,:,:,:);


end


% Draw the peripheral stimuli to the screen at a random location on an
% imaginary circle surrounding the central stimulus
%
% INPUT:    exptdesign and window are basic variables provided by the
%           function
%           allimages - the permuted vector of target and distractor
%           images
%           trial -  the trial number
%
%OUTPUT:    perifLocX/perifLocY - the X and Y coordinates of the peripheral
%           stimuli
function [perifLocX, perifLocY] = perifLocation(exptdesign, window)
    %for repeat = 1:360;
    windowRect = Screen('Rect',window);

    % Get me the info on the screen...
    [windowWdth windowHt] = Screen('WindowSize', window);

    %  calculate the center of the screen and pic, for later reference
    centerScr = [(windowRect(3)-windowRect(1))/2 (windowRect(4)-windowRect(2))/2];
    centerPic = [exptdesign.perifWdth/2 exptdesign.perifHt/2];

    %rotate = repeat;
    rotate = rand*2*pi;

    perifLocX = centerScr(1) + windowHt/3 * cos(rotate) - centerPic(1);
    perifLocY = centerScr(2) + windowHt/3 * sin(rotate) - centerPic(2);

end

function drawPics(exptdesign, window, allimages, trial, perifLocX, perifLocY)

    stimulusTexture = Screen('MakeTexture', window, squeeze(allimages(trial,:,:,:)));
    % Draw the peripheral stimuli
    Screen('DrawTexture', window, stimulusTexture, [], [perifLocX perifLocY perifLocX + exptdesign.perifWdth perifLocY + exptdesign.perifHt])
    Screen('Close', stimulusTexture);

end



% Record the subject's response
function numericalanswerCent = getCentResponseWait()
numericalanswerCent = -1;
while numericalanswerCent == -1
    [secs, keyCode] = KbPressWait;
    if sum(keyCode)==1
        numericalanswerCent = translateKeyCentResponse(keyCode);
    end
end
end



% Record the subject's response
function numericalanswerPerif = getPerifResponse(waitTime)
%Wait for a response
numericalanswerPerif = -1;
keyPressed = 0;
startWaitingPerif=GetSecs;
while GetSecs-startWaitingPerif < waitTime && keyPressed == 0
    %check to see if a button is pressed
    [keyDown,secs,keyCode] = KbCheck;

    %program accepts only LeftArrow as subject responses
    if keyPressed == 0 && sum(keyCode)==1
        numericalanswerPerif = translateKeyPerifResponse(keyCode);
        if numericalanswerPerif ~= -1
            %stop checking for a button press
            keyPressed = 1;
        end
    end
end
if numericalanswerPerif == -1
    numericalanswerPerif =0;
end
end



% Record the subject's response
function numericalanswerCent = getCentResponse(waitTime)
%Wait for response
numericalanswerCent = -1;
keyPressed = 0;
startWaitingCent = GetSecs;
while GetSecs - startWaitingCent < waitTime && keyPressed == 0
    %check to see if a button is pressed
    [keyDown,secs,keyCode] = KbCheck;

    %program accepts only RightArrow, LeftArrow and space as subject responses
    if keyPressed == 0 && sum(keyCode)==1
        numericalanswerCent = translateKeyCentfResponse(keyCode);
        if numericalanswerCent ~= -1
            %stop checking for a button press
            keyPressed = 1;
        end
    end
end
if numericalanswerCent == -1
    numericalanswerCent =0;
end
end



function [number] = translateKeyPerifResponse(keyCode)
keyName = KbName(keyCode);
%         disp(['Pressed key ' keyName]);
if strcmp(keyName, '1!')%strcmp(keyName,'LeftArrow') || strcmp(keyName,'KP_Left')
    number = 1;
elseif strcmp(keyName, '2@')%strcmp(keyName,'RightArrow') || strcmp(keyName,'KP_Right')
    number = 0;
else
    number = -1;
end
return;
end



function [number] = translateKeyCentResponse(keyCode)
keyName = KbName(keyCode);
%         disp(['Pressed key ' keyName]);
if strcmp(keyName,'LeftArrow') || strcmp(keyName,'KP_Left')%strcmp(keyName,'s')
    number = 1;
elseif strcmp(keyName,'RightArrow') || strcmp(keyName,'KP_Right')%strcmp(keyName,'d')
    number = 0;
else
    number = -1;
end

return;
end


% Load the specified image
function [images] = loadimages(directory,filenames)
total = size(filenames,1);

for i=1:total
%     disp(filenames(i).name);
    value = imread([directory, filenames(i).name]);
    %try
        %value = rgb2gray(value);
    %catch
    %end
    %images(i,:,:) = value(:,:);
    images(i,:,:,:) = value(:,:,:);

end
end

% Load the specified image
function [images] = loadimages_png(directory,filenames)
total = size(filenames,1);

for i=1:total
%     disp(filenames(i).name);
    value = imread([directory, filenames(i).name], 'png', 'BackgroundColor', [0.5 0.5 0.5]);
    %try
        %value = rgb2gray(value);
    %catch
    %end
    %images(i,:,:) = value(:,:);
    images(i,:,:,:) = value(:,:,:);

end
end




% Draw text in the middle of the screen
function drawAndCenterText(window,message,wait)
black = BlackIndex(window);
if nargin < 3
    wait = 1;
end

% Now horizontally and vertically centered:
[nx, ny, bbox] = DrawFormattedText(window, message, 'center', 'center', 0);
black = BlackIndex(window); % pixel value for black
% if exptdesign.netstationPresent
%     Screen('FillRect',window,black,[0 0 32 32]);  % This is the stimulus marker block for the photodiode
% end
Screen('Flip',window);
%     KbWait;
%     while KbCheck; end;
if wait
    KbPressWait
end
end

% Calls another function to load the pictures.  Puts the target and
% distractor images into a vector and mixes the drink.  Outputs a permuted
% list of randomly chosen and ordered targets and distractors.
%
% INPUT:    exptdesign...nuff said
%
% OUTPUT:   allimages - the permuted vector of targets and distractors
%           stimulustypemarker - tells the function whether each image is a
%           target or a distractor
function [centallimages, centstimulustypemarker, centallimagefiles] = prepCentPics(exptdesign)

cat1files = dir(exptdesign.ctrCat1Images);
if (size(cat1files,1) == 0)
    disp('NO CATEGORY 1 IMAGES!!!!');
    ME = MException('VerifyInput:OutOfBounds', ['NO CATEGORY 1 IMAGES FOUND AT ' exptdesign.cat1Images]);
    throw(ME);
end

cat2files = dir(exptdesign.ctrCat2Images);
if (size(cat2files,1) == 0)
    disp('NO CATEGORY 2 IMAGES!!!!');
    ME = MException('VerifyInput:OutOfBounds', ['NO CATEGORY 2 IMAGES FOUND AT ' exptdesign.cat2Images]);
    throw(ME);
end

%  Load and randomize first images and second category images
%  Peripheral CATEGORY 1
cat1files = cat1files(randperm(size(cat1files,1)));
cat1Images = loadimages(exptdesign.cat1Directory,cat1files(1:exptdesign.numCat1PerSession));
 
%  Peripheral CATEGORY 2
cat2files = cat2files(randperm(size(cat2files,1)));
cat2Images = loadimages(exptdesign.cat2Directory,cat2files(1:exptdesign.numCat2PerSession));

%  Put all the PERIPHERAL CATEGORY 1 and CATEGORY 2 in one vector and permute it
permutation = randperm(exptdesign.numTrialsPerSession);
stimulustypemarker = [ones(1,exptdesign.numCat1PerSession) zeros(1,exptdesign.numCat2PerSession,1)];
centstimulustypemarker = stimulustypemarker(permutation);

clear allimagefiles;
clear allimages;
allimagefiles(:,1) = cat1files(1:exptdesign.numCat1PerSession,1);
allimagefiles(exptdesign.numCat1PerSession+1:exptdesign.numCat1PerSession+exptdesign.numCat2PerSession,1) = cat2files(1:exptdesign.numCat2PerSession,1);
centallimagefiles = allimagefiles(permutation,1);
                     
allimages(:,:,:,:) = cat1Images(:,:,:,:);
allimages(exptdesign.numCat1PerSession+1:exptdesign.numCat1PerSession+exptdesign.numCat2PerSession,:,:,:) = cat2Images(:,:,:,:);
centallimages = allimages(permutation,:,:,:);

end

% Loads the images for the peripheral masks
function [centmaskimages, centmaskimagefiles] = prepCentMask(exptdesign)

maskimagefiles = dir(exptdesign.ctrmaskImages);
if (size(maskimagefiles,1) == 0)
    disp('NO MASK IMAGES!!!!');
    ME = MException('VerifyInput:OutOfBounds', ['NO MASK IMAGES FOUND AT ' exptdesign.cat1Images]);
    throw(ME);
end

% MASKS
centmaskimagefiles = maskimagefiles(randperm(size(maskimagefiles,1)));
centmaskimages = loadimages(exptdesign.imageDirectory,maskimagefiles(1:exptdesign.numTrialsPerSession));
end

