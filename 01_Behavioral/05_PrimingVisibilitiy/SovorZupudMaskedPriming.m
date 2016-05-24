function [trialoutput] = SovorZupudMaskedPriming(subjName,exptName)
% Adapts the presentation and timing of Judy's word priming experiment to test
% subconcious sovor/zupud categorization for the Automaticity project.
% Patrick Cox 

% fprintf('distance to screen must be 70 cm\n');
% name=lower(input('subject code >> ','s'));
exptdesign.subjectName = subjName;

% Which experiment are you running?
% exptdesign.experimentName = 'sovorZupudMaskedPriming';
% exptdesign.experimentName = 'sovorZupudVisibilityTest';
exptdesign.experimentName = exptName;

% set trial timing
% exptdesign.fixationDuration = .500;
exptdesign.forwardMasks=1;%set to 0 for a blank instead of a mask
exptdesign.FWmaskDuration=.500;
exptdesign.maskFilterSize=4; %[2 4 8 16]
exptdesign.maskHeight=125;
exptdesign.maskWidth=325;
exptdesign.primeRepeats=1;
if strcmp(exptdesign.experimentName,'sovorZupudMaskedPriming') 
%     exptdesign.primeDuration=input('prime duration >> ');
    exptdesign.primeDuration=8/120;
elseif strcmp(exptdesign.experimentName,'sovorZupudVisibilityTest') 
    exptdesign.primeDuration=8/120;
end

exptdesign.targetDuration=2.000;
exptdesign.waitForResponse = 0;% controls whether we wait for a correctly entered response or continue on
exptdesign.RTcutoff = .500; 
exptdesign.RTcutoffFlag = 0;

% sovor prototypes = [0 13]
% zupuds prototypes= [5 11]
exptdesign.primes = [0 13 5 11];
exptdesign.targets = [0 13 5 11];

if strcmp(exptdesign.experimentName,'sovorZupudMaskedPriming')
    exptdesign.blocks = 1:8;
    repetitions=3;
elseif strcmp(exptdesign.experimentName,'sovorZupudVisibilityTest') 
    exptdesign.blocks = 1:2;
    repetitions=3;
end
exptdesign.numSessions=length(exptdesign.blocks);

orthogonalCond=[length(exptdesign.primes) length(exptdesign.targets) length(exptdesign.primeDuration)];
exptdesign.numTrialsPerSession = prod([orthogonalCond repetitions]);% number of trials per session
for trial=1:exptdesign.numTrialsPerSession
    [exptdesign.primeCategoryCond(trial), exptdesign.targetCategoryCond(trial),...
        exptdesign.primeDurationCond(trial), dummy] = ind2sub([orthogonalCond repetitions],trial); %#ok<NASGU>
end

exptdesign.imageDirectory=['.' filesep 'images'];
% exptdesign.responseImage=['imgsscaledbw' filesep 'fixationsquare.bmp'];
exptdesign.blankImage=['imgsscaledbw' filesep 'blank.bmp'];
% exptdesign.fixationImage=['imgsscaledbw' filesep 'fixationblack.bmp']; 
exptdesign.primeImageDirectory = ['stroopOnGray' filesep 'L01OnGray'];
exptdesign.targetImageDirectory = ['stroopOnGray' filesep 'L01OnGrayLarge'];

Screen('Preference', 'SkipSyncTests', 1); %use?
[trialoutput] = SovorZupudMaskedPrimingExperiment(subjName,exptdesign);

end

%%% TO DO
% 1) add practice trials