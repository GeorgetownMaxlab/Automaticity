fprintf('distance to screen must be 90 cm\n');
name=lower(input('subject code >> ','s'))
respType = lower(input('response same Left, input 1. Response same Right, input 2 >>'))
exptdesign.responseType = respType;

exptdesign.subjectName = name;
exptdesign.netstationPresent = 1;       % Controls whether or not Netstation is present
exptdesign.netstationIP = '10.0.0.45';  % IP address of the Netstation Computer
exptdesign.netstationSyncLimit = 2;     % Limit under which to sync the Netstation Computer and the Psychtoolbox IN MILLISECONDS


exptdesign.numPracticeTrials = 0;       % number of practice trials
exptdesign.numSessions = 6;             % number of sessions to repeat the experiment
exptdesign.numTrialsPerSession = 192;     % number of trials per session
%exptdesign.numTrialsPerSession2 = 96;     % number of trials per session
% exptdesign.refresh = 0.0166667;
exptdesign.refresh = 0.016679454248257;

%12 frames is approximately 200 ms (200.2 ms);
exptdesign.stimulusDuration = 12 * exptdesign.refresh;    % amount of time to display the stimulus in seconds (0.0166667 is the frame time for 60hz)
% exptdesign.soaDurations = [2 * 0.0166667 1 * 0.0166667];         % amount of time after stimulus display before the mask is presented
exptdesign.isiDuration = [12 * exptdesign.refresh];         % amount of time after stimulus display before the second stimulus is presented
%exptdesign.maskDuration = [1 * 0.0166667];                % amount of time to display the mask in seconds
exptdesign.responseDuration = 2.00;            % amount of time to allow for a response in seconds
exptdesign.fixationDuration =0.500;             % amount of time to display the fixation point (secs)

%  Figure out ratio to use
% exptdesign.numTargetsPerSession = round(exptdesign.percentTargets * exptdesign.numTrialsPerSession);
% exptdesign.numDistractorsPerSession = exptdesign.numTrialsPerSession - exptdesign.numTargetsPerSession;


exptdesign.randomMask = 0;              % controls whether a random mask is chosen
exptdesign.getRatingResponse= 0;        % controls whether to ask for a visibility rating
exptdesign.maskType = 1;                % controls the type of mask used if not randomly chosen (0=small, 1=med, 2=large)
exptdesign.replacement = 0;             % controls whether or not the chosen images are ever used again within a trial
exptdesign.waitForResponse = 0;         % controls whether we wait for a correctly entered response or continue on
exptdesign.randomizeMaskPresentation  = 1;                 % controls whether we randomly choose a mask or a blank
exptdesign.usespace=0;                  % use space bar to start each trial?


    exptdesign.line1files1 = 'xnew/jittered_f0t5*_0.jpg';
    exptdesign.line2files1 = 'xnew/jittered_f13t5*_0.jpg';
    exptdesign.line3files1 = 'xnew/jittered_f13t11*_0.jpg';
    exptdesign.line4files1 = 'xnew/jittered_f0t11*_0.jpg';
    exptdesign.line5files1 = 'xnew/jittered_f0t13*_0.jpg';
    exptdesign.line6files1 = 'xnew/jittered_f5t11*_0.jpg';
    
    exptdesign.line1files2 = 'xnew/jittered_f0t5*_2.jpg';
    exptdesign.line2files2 = 'xnew/jittered_f13t5*_2.jpg';
    exptdesign.line3files2 = 'xnew/jittered_f13t11*_2.jpg';
    exptdesign.line4files2 = 'xnew/jittered_f0t11*_2.jpg';
    exptdesign.line5files2 = 'xnew/jittered_f0t13*_2.jpg';
    exptdesign.line6files2 = 'xnew/jittered_f5t11*_2.jpg';
    
    exptdesign.line1files3 = 'xnew/jittered_f0t5*_4.jpg';
    exptdesign.line2files3 = 'xnew/jittered_f13t5*_4.jpg';
    exptdesign.line3files3 = 'xnew/jittered_f13t11*_4.jpg';
    exptdesign.line4files3 = 'xnew/jittered_f0t11*_4.jpg';
    exptdesign.line5files3 = 'xnew/jittered_f0t13*_4.jpg';
    exptdesign.line6files3 = 'xnew/jittered_f5t11*_4.jpg';
    
    exptdesign.line1files4 = 'xnew/jittered_f0t5*_6.jpg';
    exptdesign.line2files4 = 'xnew/jittered_f13t5*_6.jpg';
    exptdesign.line3files4 = 'xnew/jittered_f13t11*_6.jpg';
    exptdesign.line4files4 = 'xnew/jittered_f0t11*_6.jpg';
    exptdesign.line5files4 = 'xnew/jittered_f0t13*_6.jpg';
    exptdesign.line6files4 = 'xnew/jittered_f5t11*_6.jpg';
    
    exptdesign.line1files5 = 'xnew/jittered_f0t5*_8.jpg';
    exptdesign.line2files5 = 'xnew/jittered_f13t5*_8.jpg';
    exptdesign.line3files5 = 'xnew/jittered_f13t11*_8.jpg';
    exptdesign.line4files5 = 'xnew/jittered_f0t11*_8.jpg';
    exptdesign.line5files5 = 'xnew/jittered_f0t13*_8.jpg';
    exptdesign.line6files5 = 'xnew/jittered_f5t11*_8.jpg';
    
    exptdesign.line1files6 = 'xnew/jittered_f0t5*_10.jpg';
    exptdesign.line2files6 = 'xnew/jittered_f13t5*_10.jpg';
    exptdesign.line3files6 = 'xnew/jittered_f13t11*_10.jpg';
    exptdesign.line4files6 = 'xnew/jittered_f0t11*_10.jpg';
    exptdesign.line5files6 = 'xnew/jittered_f0t13*_10.jpg';
    exptdesign.line6files6 = 'xnew/jittered_f5t11*_10.jpg';


%exptdesign.line1files = 'xnew/Subj685f0t5*.jpg';
%exptdesign.line2files = 'xnew/Subj685f13t5*.jpg';
%exptdesign.line3files = 'xnew/Subj685f13t11*.jpg';
%exptdesign.line4files = 'xnew/Subj685f0t11*.jpg';


% % exptdesign.targetImages = 'xnew/cat1*.bmp';         % images to use as the targets
% % exptdesign.distractorImages = 'xnew/cat2*.bmp';       % images to use as the distractors

% % exptdesign.sampleImagesCategory1 = 'xnew/cat1*n4.bmp';           % images to use as the samples 
% % exptdesign.sampleImagesCategory2 = 'xnew/cat2*n14.bmp';           % images to use as the samples

%exptdesign.maskImages = 'xnew/mask*.bmp';         % images to use as the masks
exptdesign.fixationImage = 'xnew/fixationg.jpg';  % image for the fixation cross
%exptdesign.fixationImage = 'imgs/animal_16new.bmp';  % image for the fixation cross
exptdesign.blankImage = 'xnew/blankg.jpg';        % image for the blank screen
exptdesign.imageDirectory = 'xnew/';
% exptdesign.intertrialinterval=0.2; % FP duration (secs)
% exptdesign.postfixationpoint=0.5; %fix duration after FP in seconds
% exptdesign.postfixationrandominc=0.5; %rand duration after FP in seconds
% exptdesign.stimduration=53/1000; % stimulus duration (sec)
% exptdesign.aftertrialinterval=1; % post stim interval (secs)
% exptdesign.randSOAconditions=0; % 1=random, 0=fix order
% exptdesign.postfixationpoint=[0.5 3]; %fix duration after FP in seconds
% exptdesign.postfixationrandominc=[5 0]; %rand duration after FP in seconds

% exptdesign.takebreakbeforecycle=999;%61??
% exptdesign.adaptseconds=30; % light adaptation time (sec) before 1st staircase
% exptdesign.adaptsec2=round(60/5);
% exptdesign.showtext=1; % when 1, descriptions of task & button presses are shown before 1st trial
% exptdesign.stimcontrastvariance=40*6.1136e-04;
exptdesign
[trialoutput] = AdaptationExperiment(name,exptdesign)
