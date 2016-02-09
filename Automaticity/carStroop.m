% carStroop: wrapper for car stroop experiment to test
% task independent categorization for the Automaticity project.
% Patrick Cox 1/4/2014

% initialize random number generator
% randn('state',sum(100*clock));  
rng('shuffle');

fprintf('distance to screen must be 70 cm\n');
rng('shuffle');%added 6/18/2015 pc

    %get subject and date info
    name = input('\n\nEnter Subject NUMBER:\n\n','s');
    number=name;
    exptdesign.number=number;
    if isempty(name)
        name = [datestr(now,'yyyy-mm-dd-HH-MM-') 'MR000'];
    else
        name = [datestr(now,'yyyy-mm-dd-HH-MM-') 'MR' name];
    end
    WaitSecs(0.25);

% set test trial types
exptdesign.carLabels=[1 2]; %1=sovor, 2=zupud
exptdesign.carImages=[1 2]; %1=sovor, 2=zupud
exptdesign.imagePrototype=[1 2];
exptdesign.imageDifficulty=[1 2]; %1=easy, 2=hard
exptdesign.stimLayout=[1 2]; %1=label top, 2=label bottom

% make test trials
repetitions=1;
orthogonalCond=[length(exptdesign.carLabels) length(exptdesign.carImages) length(exptdesign.imagePrototype)...
    length(exptdesign.imageDifficulty) length(exptdesign.stimLayout)];
exptdesign.numTestTrialsPerSession = prod([orthogonalCond repetitions]);% number of trials per session
for trial=1:exptdesign.numTestTrialsPerSession
    [exptdesign.carLabelCond(trial) exptdesign.carImageCond(trial) exptdesign.imagePrototypeCond(trial)...
        exptdesign.imageDifficultyCond(trial) exptdesign.stimLayoutCond(trial) dummy]...
        = ind2sub([orthogonalCond repetitions],trial);
end

% add control trials, neutral cars
repetitions=1;
orthogonalCond=[length(exptdesign.carLabels) length(exptdesign.imagePrototype) length(exptdesign.stimLayout)];
exptdesign.numControlTrialsPerSession = prod([orthogonalCond repetitions]);% number of trials per session
for trial=exptdesign.numTestTrialsPerSession+1:exptdesign.numTestTrialsPerSession+exptdesign.numControlTrialsPerSession 
    [exptdesign.carLabelCond(trial) exptdesign.imagePrototypeCond(trial)...
        exptdesign.stimLayoutCond(trial) dummy] = ind2sub([orthogonalCond repetitions],trial);
    exptdesign.carImageCond(trial)=3;
    exptdesign.imageDifficultyCond(trial)=1;
end

exptdesign.numTrialsPerSession=exptdesign.numTestTrialsPerSession+exptdesign.numControlTrialsPerSession;
exptdesign.numSessions=10;

% set trial timing
%exptdesign.fixationDuration = (ceil(200* rand(1)) + 800) / 1000; %need to change this to adjust for every trial
exptdesign.targetDuration = .100; %target stimulus duration is 100 ms
exptdesign.waitForResponse = 0; %controls whether we wait for a correctly entered response or continue on
exptdesign.responseWindow = 1.000; %subjects must respond within 1000 ms of stimulus offset.
exptdesign.warningToneFlag=1;
exptdesign.interTrialDuration = 1.500;
exptdesign.labelDist = 40; %amount the label is shifted above/below fixation.
exptdesign.imageDist = 40; %amount the car image are shifted above/below fixation.

exptdesign.imageDirectory=['.' filesep 'images'];
exptdesign.responseImage=['imgsscaledbw' filesep 'blank.bmp'];%['imgsscaledbw' filesep 'fixationsquare.bmp'];
exptdesign.blankImage=['imgsscaledbw' filesep 'blank.bmp'];
exptdesign.fixationImage=['imgsscaledbw' filesep 'fixationblack.bmp']; 
exptdesign.carImageDirectory = 'stroopOnGray';

Screen('Preference', 'SkipSyncTests', 1); %use?
[trialoutput] = carStroopExperiment(name,exptdesign);