fprintf('distance to screen must be 120 cm\n');

    %get subject and date info
    name = input('\n\nEnter Subject ID:\n\n','s');
    if isempty(name)
        name = [datestr(now,'yyyy-mm-dd-') 'MR000']
    else
        name = [datestr(now,'yyyy-mm-dd-') name];
    end
    WaitSecs(0.25);
    if exist(['./data/' name],'dir')
    else
        mkdir(['./data/' name])
    end
%name=lower(input('subject code >> ','s'));

exptdesign.initialCentSOA = input('\nEnter initial central SOA in frames\n');
exptdesign.initialPerifSOA = input('\nEnter initial peripheral SOA in frames\n');
exptdesign.testLines = input('\Enter test line set 1 or 2\n');

exptdesign.subjectName = name;
exptdesign.netstationPresent = 0;       % Controls whether or not Netstation is present
exptdesign.netstationIP = '10.0.0.45';  % IP address of the Netstation Computer
exptdesign.netstationSyncLimit = 2;     % Limit under which to sync the Netstation Computer and the Psychtoolbox IN MILLISECONDS

exptdesign.numSessions = 18;              % number of sessions to repeat the experiment
%sessionType 1 = single central; 2 = single peripheral; 3 = Dual
exptdesign.sessionType=[1 2 3 2 3 1 3 2 1 2 1 3 3 1 2 1 3 2 1 2 3 2 3 1 3 2 1 2 1 3 3 1 2 1 3 2];
exptdesign.numTrialsPerSession = 36;     % number of trials per session (each session is roughly 1.5 minutes)
exptdesign.refresh = 0.016679454248257;

%give a peripheral cue?
exptdesign.cuePeripheralLocation=1;
exptdesign.cueImage = 'imgsscaled/corners.png';

%with what probability? (.5, 1.0...)
exptdesign.cueProbability=1.0;

exptdesign.cueDuration=[exptdesign.refresh*2];
exptdesign.fixation2Duration=[exptdesign.refresh*2];

exptdesign.stimulusDuration = 100 * exptdesign.refresh;    % amount of time to display the stimulus in seconds (0.0166667 is the frame time for 60hz)
exptdesign.fixationDuration =0.500;             % amount of time to display the fixation point (secs)

exptdesign.fixationImage = 'imgsscaled/fixation.bmp';  % image for the fixation cross
exptdesign.blankImage = 'imgsscaled/blank.bmp';        % image for the blank screen
exptdesign.cueImage = 'imgsscaled/corners.png';

exptdesign.calibrateCentSOA = 0;         % Run the sequence to set the subject's SOA for the central task
exptdesign.calibratePerifSOA = 0;        % Run the sequence to set the subject's SOA for the peripheral task

exptdesign.centPerifInterval = exptdesign.refresh;    % Time between the appearance of the central and peripheral stimuli(secs)

exptdesign.sessionsPerCentPractice =3;    % Number of sessions used to determine the subject's central SOA
exptdesign.sessionsPerPerifPractice = 3;   % Number of sessions used to determine the subject's peripheral SOA

exptdesign.cent2Perif = exptdesign.refresh*1;             % Time between the onset of the central stimulus and the peripheral stimulus
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    CENTRAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exptdesign.centSOADurations = exptdesign.refresh*exptdesign.initialCentSOA;    
exptdesign.perifSOADurations = exptdesign.refresh*exptdesign.initialPerifSOA;
%exptdesign.centSOADurations = 0.0500;                        
                 % Cent SOA for subjects 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    PERIPHERAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%exptdesign.perifSOADurations = 0.200;                 % DO NOT CHANGE!!! Perif SOA for subjects who have not yet calibrated their SOA
%exptdesign.perifSOADurations = 0.0570;                % Perif SOA for subjects who have already calibrated their SOA's


% Data on the pictures to be displayed in the periphery -- For Cars,
 exptdesign.perifWdth = 320;             % Width of the pic
 exptdesign.perifHt = 320;               %Height of aforementioned pic
% %For Animals
%exptdesign.ctrWdth = 236;             % Width of the pic
%exptdesign.ctrHt = 364;               %Height of aforementioned pic
%For Letters 
% exptdesign.perifWdth = 89;             % Width of the pic
% exptdesign.perifHt = 89;  
%for discs
exptdesign.perifWdth = 70;
exptdesign.perifHt = 70;

exptdesign.maskDuration = 0.300;                           % amount of time to display the mask in seconds
% exptdesign.maskDuration = [1 * 0.0166667];                % amount of time to display the mask in seconds

exptdesign.perifStimulusDuration = exptdesign.refresh*1;       % Time to display the perif stimuli (secs)
exptdesign.responseDuration = 2.3;                % amount of time to allow for a response in seconds
exptdesign.percentCat1 = 0.5;                % number of times to select first category vs. second category
                                                %  Figure out ratio to use

exptdesign.numCat1PerSession = round(exptdesign.percentCat1 * exptdesign.numTrialsPerSession);
exptdesign.numCat2PerSession = exptdesign.numTrialsPerSession - exptdesign.numCat1PerSession;
exptdesign.numPerifCue=round(exptdesign.cueProbability * exptdesign.numTrialsPerSession);
exptdesign.numCentralCue = exptdesign.numTrialsPerSession - exptdesign.numPerifCue;

exptdesign.randomMask = 1;              % controls whether a random mask is chosen
exptdesign.maskType = 1;                % controls the type of mask used if not randomly chosen (0=small, 1=med, 2=large)
exptdesign.replacement = 1;             % controls whether or not the chosen images are ever used again within a trial
exptdesign.waitForPerifResponse = 1;    % controls whether we wait for a correctly entered peripheral response or continue on
exptdesign.waitForCentResponse = 1;     %    "       "      "  "    "  "    "         "    central       "      "     "     "
exptdesign.usespace=0;                  % use space bar to start each trial?
exptdesign.giveFeedback=1;
exptdesign.animOrCar = 2;               % 0 = animals, 1 = cars, 2 = colored disk

if exptdesign.testLines==1
     exptdesign.ctrCat1Images = 'Category1/set1_f*';         % car images to use as the first category
     exptdesign.ctrCat2Images = 'Category2/set1_f*';         % car images to use as the second category
else
     exptdesign.ctrCat1Images = 'Category1/set2_f*';         % car images to use as the first category
     exptdesign.ctrCat2Images = 'Category2/set2_f*';         % car images to use as the second category
end


%exptdesign.ctrCat1Images = 'Category1/Xanim*';
%exptdesign.ctrCat2Images = 'Category2/Xno*';
exptdesign.ctrmaskImages = 'imgsscaled/Xmask*';



exptdesign.maskImages = 'imgsscaled/circleMask*';          % car mask images to use as the masks
exptdesign.imageDirectory = 'imgsscaled/';

 exptdesign.cat1Images = 'Category1/redGreen_70.png';          % circle images to use as the first category 
 exptdesign.cat2Images = 'Category2/greenRed_70.png';          % circle images to use as the second category
% exptdesign.maskImages = 'Circles/RedGreenMaskGray*';    % circle mask images to use as the masks
% exptdesign.imageDirectory = 'Circles/';

%exptdesign.cat1Images = 'Category1/Xanim*';            % animal images to use as the first category
%exptdesign.cat2Images = 'Category2/Xno*';              % animal images to use as the second category

exptdesign.cat1Directory = 'Category1/';
exptdesign.cat2Directory = 'Category2/';


[trialoutput] = diskCarsExperiment(name,exptdesign);