%%
%Put data into fieldtrip format!! Woooot!!
clear all;
%%%%%%%%%>>>MODIFY THESE FOR EACH SUBJECT<<<%%%%%%%%%
highpass = 0.1;
samplerate = 500;
lowpass = 30;
startpoint = -0.6;
endpoint = 0.8;
sample = samplerate;
filter = [highpass lowpass];
timepoint = 'post';
iSubj = '932';
%iSubj = input('Enter Subject Number of the data you want to preprocess: \n\n');

switch iSubj
    case '829'
        exptFilename      = 's829_adapt1.5192.mat';
        
    case '801'
        exptFilename      = 's801_adapt1_2.5192.mat';
        
    case '860'
        if strcmp(timepoint,'pre')
            exptFilename  = 's860_autopre.5192.mat';
        elseif strcmp (timepoint, 'post')
            exptFilename3 = 's860_post.896.mat';
        end
        
    case '862'
        exptFilename      = 's862_autopre.5192.mat';
        
    case '794'
        if strcmp(timepoint,'pre')
            exptFilename  ='s794_session1.896.mat';
            pathString    = '~/Desktop/2013_02_automaticity/02_rawData/794/2014-02-27/';
            infoString    = ['S794_20140227_autoPre001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp (timepoint, 'post')
            timepoint='post';
            exptFilename  = 's794_post.896.mat';
            pathString    = '~/Desktop/2013_02_automaticity/02_rawData/794/2014-04-23/';
            infoString    = ['S794_20140423_post001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '858'
        if strcmp(timepoint,'pre')
            exptFilename  = 's858_pre.896.mat';
            pathString    = '~/Desktop/2013_02_automaticity/02_rawData/858/2014-02-26/';
            infoString    = ['S858_20140226_autoPre001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp(timepoint,'post')
            exptFilename  = 's858_post.896.mat';
            pathString    = '~/Desktop/2013_02_automaticity/02_rawData/858/2014-04-09/';
            infoString    = ['S858_20140409_autoPost001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '704'
        if strcmp(timepoint,'pre')
            exptFilename  = 's704.896.mat';
            pathString    = '~/Desktop/2013_02_automaticity/02_rawData/704/2014-03-04/';
            infoString    = ['s704_20140304_autoPre001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp(timepoint,'post')
            exptFilename  = 's704_post.896.mat';
            pathString    = '~/Desktop/2013_02_automaticity/02_rawData/704/2014-04-22/';
            infoString    = ['S704_20140422_post001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '882'
        if strcmp(timepoint,'pre')
            exptFilename  = 's882.696.mat';
            pathString    = '~/Desktop/2013_02_automaticity/02_rawData/882/2014-04-04-EEG1/';
            infoString    = ['S882_20140404_pre001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp(timepoint,'post')
            exptFilename  = 's882.896.mat';
            timepoint     = 'post';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/882/post/';
            infoString    = ['S882_20140530_post001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '883'
        if strcmp(timepoint,'pre')
            exptFilename  = 's883_pre.896.mat';
            pathString    = '~/Desktop/2013_02_automaticity/02_rawData/883/2014-04-24/';
            infoString    = ['S883_20140424_pre001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp(timepoint,'post')
            exptFilename  = 's883_post.896.mat';
            pathString    = '~/Desktop/2013_02_automaticity/02_rawData/883/2014-06-11/';
            infoString    = ['S883_20140611_post001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '893'
        if strcmp(timepoint,'pre')
            exptFilename  = 's893_pre.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/893/pre/';
            infoString    = ['S893_20140612_pre001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp(timepoint,'post')
            exptFilename  = 's893_post.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/893/post/';
            infoString    = ['S893_20140801_post001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '899'
        if strcmp(timepoint,'pre')
            exptFilename  = '899_pre.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/899/pre/';
            infoString    = ['S899_20140709_autoPre001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp(timepoint,'post')
            exptFilename  = 's899_post.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/899/post/';
            infoString    = ['S899_20140812_post001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '904'
        if strcmp(timepoint,'pre')
            exptFilename  = 's904.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/904/pre';
            infoString    = ['S904_20140829_autoPre001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp(timepoint,'post')
            exptFilename  = 's904_post.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/904/post';
            infoString    = ['S904_20141007_autoPost001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '910'
        if strcmp(timepoint,'pre')
            exptFilename  = 's910_pre.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/910/Pre/';
            infoString    = ['S910_20140930_autoPre001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp(timepoint,'post')
            exptFilename  = 's910_post.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/910/Post/';
            infoString    = ['S910_20141120_post001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '912'
        if strcmp(timepoint,'pre')
            exptFilename  = 's912_pre.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/912/pre/';
            infoString    = ['S912_20141009_autoPre001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp(timepoint,'post')
            exptFilename  = 's912_post.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/912/post/';
            infoString    = ['S912_20141210_post001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '913'
        if strcmp(timepoint,'pre')
            exptFilename  = 's913_pre.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/913/pre/';
            infoString    = ['S913_20141013_autoPre001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp(timepoint,'post')
            exptFilename  = 's913_post.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/913/post/';
            infoString    = ['S913_20141209001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '915'
        if strcmp(timepoint,'pre')
            exptFilename  = 's915_pre.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/915/pre/';
            infoString    = ['S915_20141020001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        elseif strcmp(timepoint,'post')
            exptFilename  = 's915_post.896.mat';
            pathString    = '/Volumes/maxlab/automaticity/01_EEG/915/post/';
            infoString    = ['S915_20141219_post001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        end
        
    case '925'
        exptFilename      = 's925.6192.mat';
        pathString        = ('~/Documents/EEG/01_rawData/925/');
        infoString        = ['S925_20150502_1030001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        
    case '955'
        exptFilename      = 's955.6192.mat';
        pathString        = ('~/Documents/EEG/02_EEG_Analysis/01_rawData/955/');
        infoString        = ['S955_20150915_autoAim1001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        
    case '932'
        exptFilename      = 's932.6192.mat';
        pathString        = ('~/Documents/EEG/02_EEG_Analysis/01_rawData/932/');
        infoString        = ['S932_20150708_autoAim1001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        
    case '895'
        exptFilename      = 's895.6192.mat';
        pathString        = ('~/Documents/EEG/01_rawData/895/');
        infoString        = ['S895_20150519_autoAim1001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        
    case '978'
        exptFilename      = 's978_20151112.6192.mat';
        pathString        = ('~/Documents/EEG/02_EEG_Analysis/01_rawData/978');
        infoString        = ['S978_20151112001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        
    case '990' %NOTE HAS 8 BLOCKS INSTEAD OF 6
        exptFilename      = 's990EditOddBlockOnly.4192.mat';
        pathString        = ('~/Documents/EEG/02_EEG_Analysis/01_rawData/990');
        infoString        = ['S990_20151215001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        
    case '991'
        exptFilename      = '991_12122015.6192.mat';
        pathString        = ('~/Documents/EEG/01_rawData/991/');
        infoString        = ['S991_20151212001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
    
    case '997'
        exptFilename      = '997_12092015EDITblock5Remove.6192.mat';
        pathString        = ('~/Documents/EEG/02_EEG_Analysis/01_rawData/997/');
        infoString        = ['S997_20151209_1414001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
    
    case '976'
        exptFilename      = 's976_20151104.6192.mat';
        pathString        = ('~/Documents/EEG/01_rawData/976/');
        infoString        = ['S976_20151104 1435001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
    
    case '996'
        exptFilename      = 's996EDITblock2Remove.6192.mat';
        pathString        = ('~/Documents/EEG/02_EEG_Analysis/01_rawData/996/');
        infoString        = ['S996_20160115_1610001SampleRate500hz_' num2str(filter(1)) 'hz-0hz-0hz-30hz_FILTERED_DINS0filtered_continuous.set'];
        
        
end
%%
%%Load set
EEG = pop_loadset([pathString '/' infoString]);

%Make the DINS even/odd
for ii=1:length(EEG.event)
    order = ii;%EEG.event(i).urevent;
    if mod(order,2) %mod(i,2)
        EEG.event(ii).type = 'DIN1';
    else
        EEG.event(ii).type = 'DIN2';
    end
end

%%Segment
EEG = pop_epoch( EEG, { 'DIN2' }, [startpoint endpoint], 'setname', 'Continuous EEG Data epochs', 'epochinfo', 'yes');
%%
EEG = pop_rmbase( EEG, [(startpoint *1000) -.4]);
baselinestring = num2str([(startpoint *1000) -.4]);
disp(['Baselined from ' baselinestring]);
EEG.comments = pop_comments(EEG.comments,'',['Extracted ''DIN'' epochs [' baselinestring '] sec, and removed baseline.'],1); % Add a description of the epoch extraction to EEG.comments.

ALLEEG=[];
CURRENTSET=[];

% Now, either overwrite the parent dataset, if you don't need the continuous version any longer, or create a new dataset
%(by removing the 'overwrite', 'on' option in the function call below).
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,  'setname', 'Continuous EEG Data epochs filtered');

%%Reject Artifacts
[EEG, ArtifactIndices] = pop_eegthresh(EEG,1,[14 21 126 127],-75, 75,-.2, 0.4,1,1); %remove blinks
numTrialsRejected = length(ArtifactIndices)


[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET,  'setname', 'Continuous EEG Data epochs baselined filtered artifacted');
%[ALLEEG, EEG, CURRENTSET] = pop_chanedit(EEG,'load', { 'dummy.elp' 'elp' }, 'delete', [3 4], ...
 %                       'convert', { 'xyz->polar' [] -1 1 }, 'save', 'mychans.loc' )
%convertToMaxlab
exptFilename = [pathString '/' exptFilename];

%%
[eegdata, EEG] = convertToMaxLab(EEG, exptFilename, ArtifactIndices);

indices        = setdiff(1:length(eegdata.trialnumber), ArtifactIndices);

eegdata        = selectBlinkIndices(eegdata, indices);
    
%%
%pull out EEG for correct answers only
EEG2          = EEG;
EEG2.trials   = length(find(eegdata.subjectHasRightAnswer==1));
EEG2.data     = EEG.data(:,:,eegdata.subjectHasRightAnswer);
EEG2.epoch    = EEG.epoch(1, eegdata.subjectHasRightAnswer);

eegdata       = removeIncorrectTrials(eegdata);
    
 %%

 EEGM0         = EEG2;
 EEGM0.trials  = length(find(eegdata.condition==1));
 EEGM0.data    = EEG2.data(:,:,eegdata.condition==1);
 EEGM0.epoch   = EEG2.epoch(1, eegdata.condition==1);
 
 EEGM3w        = EEG2;
 EEGM3w.trials = length(find(eegdata.condition==2));
 EEGM3w.data   = EEG2.data(:,:,eegdata.condition==2 );
 EEGM3w.epoch  = EEG2.epoch(1, eegdata.condition==2);
 
 EEGM3b        = EEG2;
 EEGM3b.trials = length(find(eegdata.condition==3));
 EEGM3b.data   = EEG2.data(:,:,eegdata.condition==3);
 EEGM3b.epoch  = EEG2.epoch(1, eegdata.condition==3);
 
 EEGM6         = EEG2;
 EEGM6.trials  = length(find(eegdata.condition==4));
 EEGM6.data    = EEG2.data(:,:,eegdata.condition==4);
 EEGM6.epoch   = EEG2.epoch(1, eegdata.condition==4);

    %%
    %now save each in FIELDTRIP FORMAT!!!
    dataM0     = eeglab2fieldtrip(EEGM0, 'preprocessing');
    dataM3W    = eeglab2fieldtrip(EEGM3w, 'preprocessing');
    dataM3B    = eeglab2fieldtrip(EEGM3b, 'preprocessing');
    dataM6     = eeglab2fieldtrip(EEGM6, 'preprocessing');
    
    save(['subj' num2str(iSubj) '_' timepoint '_FT_bothStim_rejChan' num2str(sample) 'hz' num2str(filter(1)) 'hz-' num2str(filter(2)) 'hz_fromContinuous.mat'], ...
        'dataM0', 'dataM3W', 'dataM3B', 'dataM6');
    clear file exptFilename EEG eegdata data*;

disp('done.')