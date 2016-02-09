fprintf('distance to screen must be 120 cm\n');

rng('shuffle'); %added 6/18/2015 pc

% get subject and date info
name = input('\n\nEnter Subject ID:\n\n','s');
if isempty(name)
    name = [datestr(now,'yyyy-mm-dd-') 'MR000' 'practice'];
else
    name = [datestr(now,'yyyy-mm-dd-') name 'practice'];
end
WaitSecs(0.25);
if ~exist(['./Car_data_inScanner/' name],'dir')
    mkdir(['./Car_data_inScanner/' name])
end

exptdesign.subjectName = name;
exptdesign.responseCueTime = 1.2;       % not currently being used in main script...
exptdesign.responseCueDuration = 4.0;   % not currently being used in main script...
exptdesign.responseBox = 0;             % Controls whether we are using the keyboard or the response box for subj. responses.
exptdesign.netstationPresent = 0;       % Controls whether or not Netstation is present
exptdesign.netstationIP = '10.0.0.45';  % IP address of the Netstation Computer
exptdesign.netstationSyncLimit = 2;     % Limit under which to sync the Netstation Computer and the Psychtoolbox IN MILLISECONDS

exptdesign.numSessions = 18;              % number of sessions to repeat the experiment
% sessionType 1 = single central; 2 = single peripheral; 3 = Dual
exptdesign.sessionTypes=randperm(3);
exptdesign.numTrialsPerSession = 16;     % number of trials per session (must be multiple of 8, min 16)
exptdesign.refresh = 0.016679454248257;

%give a peripheral cue?
exptdesign.cuePeripheralLocation=1;
exptdesign.cueImage = 'imgsscaled/corners.png';
%with what probability? (.5, 1.0...)
exptdesign.cueProbability=1.0;

exptdesign.fixationDuration =0.500;             % amount of time to display the fixation point (secs)
exptdesign.cueDuration=exptdesign.refresh*2;
exptdesign.fixation2Duration=exptdesign.refresh*2;

exptdesign.fixationImage = 'imgsscaled/fixation.bmp';  % image for the fixation cross
exptdesign.blankImage = 'imgsscaled/blank.bmp';        % image for the blank screen
exptdesign.cueImage = 'imgsscaled/corners.png';

% % % exptdesign.centPerifInterval = exptdesign.refresh;    % Time between the appearance of the central and peripheral stimuli(secs)
% % % exptdesign.cent2Perif = exptdesign.refresh*1;         % Time between the onset of the central stimulus and the peripheral stimulus

% exptdesign.centSOADurations = exptdesign.refresh*2;    
% exptdesign.perifSOADurations = exptdesign.refresh*7;
centSOA = input('\n\nEnter central SOA:\n\n');
perifSOA = input('\n\nEnter peripheral SOA:\n\n');
exptdesign.centSOADurations = exptdesign.refresh*centSOA;    
exptdesign.perifSOADurations = exptdesign.refresh*perifSOA;

% Decide which response mapping you are using
exptdesign.responseKeyChange = input('\n\nEnter response key profile (option 0 or 1):\n\n');

% Data on the pictures to be displayed in the periphery -- For Cars,
exptdesign.ctrWdth = 320;             % Width of the pic, not currently being used in main script...
exptdesign.ctrHt = 320;               % Height of aforementioned pic, not currently being used in main script...
%For Animals
% exptdesign.ctrWdth = 189;             % Width of the pic
% exptdesign.ctrHt = 292;               % Height of aforementioned pic
%For Letters 
% exptdesign.perifWdth = 89;             % Width of the pic
% exptdesign.perifHt = 89;  
%for discs
exptdesign.perifWdth = 70;
exptdesign.perifHt = 70;

exptdesign.maskDuration = 0.300;                           % amount of time to display the mask in seconds

exptdesign.perifStimulusDuration = exptdesign.refresh*2;       % Time to display the perif stimuli (secs)
exptdesign.responseDuration = 4.0;                % amount of time to allow for a response in seconds

exptdesign.percentCat1 = 0.5;                % number of times to select first category vs. second category
exptdesign.numCat1PerSession = round(exptdesign.percentCat1 * exptdesign.numTrialsPerSession);
exptdesign.numCat2PerSession = exptdesign.numTrialsPerSession - exptdesign.numCat1PerSession;
exptdesign.numPerifCue=round(exptdesign.cueProbability * exptdesign.numTrialsPerSession);% not currently being used in main script...
exptdesign.numCentralCue = exptdesign.numTrialsPerSession - exptdesign.numPerifCue;% not currently being used in main script...

exptdesign.randomMask = 1;              % controls whether a random mask is chosen, not currently being used in main script...
exptdesign.maskType = 1;                % controls the type of mask used if not randomly chosen (0=small, 1=med, 2=large), not currently being used in main script...
exptdesign.replacement = 1;             % controls whether or not the chosen images are ever used again within a trial, not currently being used in main script...
exptdesign.waitForPerifResponse = 0;    % controls whether we wait for a correctly entered peripheral response or continue on
exptdesign.waitForCentResponse = 0;     %    "       "      "  "    "  "    "         "    central       "      "     "     "
exptdesign.usespace=0;                  % use space bar to start each trial?, not currently being used in main script...
exptdesign.giveFeedback=0;              % not currently being used in main script...
exptdesign.animOrCar = 2;               % 0 = animals, 1 = cars, 2 = colored disk

% exptdesign.cat1Images = 'Category1/f*';         % car images to use as the first category
% exptdesign.cat2Images = 'Category2/f*';         % car images to use as the second category
% exptdesign.cat1Images = 'Category1/Xanim*';            % animal images to use as the first category
% exptdesign.cat2Images = 'Category2/Xno*';              % animal images to use as the second category

sovorf0t5=dir('dualTaskInScanner_80_20/d*f0t5*');
sovorf0t11=dir('dualTaskInScanner_80_20/d*f0t11*');
sovorf13t5=dir('dualTaskInScanner_80_20/d*f13t5*');
sovorf13t11=dir('dualTaskInScanner_80_20/d*f13t11*');
zupudf5t0=dir('dualTaskInScanner_80_20/d*f5t0*');
zupudf5t13=dir('dualTaskInScanner_80_20/d*f5t13*');
zupudf11t0=dir('dualTaskInScanner_80_20/d*f11t0*');
zupudf11t13=dir('dualTaskInScanner_80_20/d*f11t13*');
for nFiles=1:length(sovorf0t5)
    sovorf0t5files{nFiles}=['dualTaskInScanner_80_20' filesep sovorf0t5(nFiles).name];
    sovorf0t11files{nFiles}=['dualTaskInScanner_80_20' filesep sovorf0t11(nFiles).name];
    sovorf13t5files{nFiles}=['dualTaskInScanner_80_20' filesep sovorf13t5(nFiles).name];
    sovorf13t11files{nFiles}=['dualTaskInScanner_80_20' filesep sovorf13t11(nFiles).name];
    zupudf5t0files{nFiles}=['dualTaskInScanner_80_20' filesep zupudf5t0(nFiles).name];
    zupudf5t13files{nFiles}=['dualTaskInScanner_80_20' filesep zupudf5t13(nFiles).name];
    zupudf11t0files{nFiles}=['dualTaskInScanner_80_20' filesep zupudf11t0(nFiles).name];
    zupudf11t13files{nFiles}=['dualTaskInScanner_80_20' filesep zupudf11t13(nFiles).name];
end
sovorf0t5filesRand=sovorf0t5files(randperm(length(sovorf0t5files)));
sovorf0t11filesRand=sovorf0t11files(randperm(length(sovorf0t11files)));
sovorf13t5filesRand=sovorf13t5files(randperm(length(sovorf13t5files)));
sovorf13t11filesRand=sovorf13t11files(randperm(length(sovorf13t11files)));
zupudf5t0filesRand=zupudf5t0files(randperm(length(zupudf5t0files)));
zupudf5t13filesRand=zupudf5t13files(randperm(length(zupudf5t13files)));
zupudf11t0filesRand=zupudf11t0files(randperm(length(zupudf11t0files)));
zupudf11t13filesRand=zupudf11t13files(randperm(length(zupudf11t13files)));
    
% exptdesign.ctrCat1Images = 'Category1_resized/Xanim*';
% exptdesign.ctrCat2Images = 'Category2_resized/Xno*';
exptdesign.ctrmaskImages = 'imgsscaled/Xmask*';

exptdesign.maskImages = 'imgsscaled/circleMask*';          % car mask images to use as the masks
exptdesign.imageDirectory = 'imgsscaled/';

exptdesign.cat1Images = 'Category1/redGreen_70.png';          % circle images to use as the first category 
exptdesign.cat2Images = 'Category2/greenRed_70.png';          % circle images to use as the second category
% exptdesign.maskImages = 'Circles/RedGreenMaskGray*';    % circle mask images to use as the masks
% exptdesign.imageDirectory = 'Circles/';

exptdesign.cat1Directory = 'Category1/';
exptdesign.cat2Directory = 'Category2/';
    
if exptdesign.responseBox
    % Ensure button-box configuration is correct
    disp('Ensure dip switches are set to E-PRIME and 5+');
    input('Hit Enter to Continue...');
    exptdesign.boxHandle = CMUBox('Open', 'pst', 'COM1', 'norelease');
end

% make sure subject can see peripheral stim in scanner.
% testPerifVisibility(exptdesign)

randomizeRuns=randperm(size(exptdesign.sessionTypes,1));
for run = 1:size(exptdesign.sessionTypes,1)
    exptdesign.ctrCat1Images = [sovorf0t5filesRand((run-1)*(exptdesign.numCat1PerSession/4)+1:(run-1)*(exptdesign.numCat1PerSession/4)+(exptdesign.numCat1PerSession/4)) sovorf0t11filesRand((run-1)*(exptdesign.numCat1PerSession/4)+1:(run-1)*(exptdesign.numCat1PerSession/4)+(exptdesign.numCat1PerSession/4))...
        sovorf13t5filesRand((run-1)*(exptdesign.numCat1PerSession/4)+1:(run-1)*(exptdesign.numCat1PerSession/4)+(exptdesign.numCat1PerSession/4)) sovorf13t11filesRand((run-1)*(exptdesign.numCat1PerSession/4)+1:(run-1)*(exptdesign.numCat1PerSession/4)+(exptdesign.numCat1PerSession/4))];
    exptdesign.ctrCat2Images = [zupudf5t0filesRand((run-1)*(exptdesign.numCat2PerSession/4)+1:(run-1)*(exptdesign.numCat2PerSession/4)+(exptdesign.numCat2PerSession/4)) zupudf5t13filesRand((run-1)*(exptdesign.numCat2PerSession/4)+1:(run-1)*(exptdesign.numCat2PerSession/4)+(exptdesign.numCat2PerSession/4))...
        zupudf11t0filesRand((run-1)*(exptdesign.numCat2PerSession/4)+1:(run-1)*(exptdesign.numCat2PerSession/4)+(exptdesign.numCat2PerSession/4)) zupudf11t13filesRand((run-1)*(exptdesign.numCat2PerSession/4)+1:(run-1)*(exptdesign.numCat2PerSession/4)+(exptdesign.numCat2PerSession/4))];
    exptdesign.sessionType=exptdesign.sessionTypes(randomizeRuns(run),:);
    exptdesign.run=run;
    [trialoutput] = diskCarsExperiment_inScanner(name,exptdesign);  
end

if exptdesign.responseBox
    CMUBox('Close',exptdesign.boxHandle);
    disp('Ensure dip switches are set back to 4');
end
