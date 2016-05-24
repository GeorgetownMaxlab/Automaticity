%                     ? vbm,.,mnbvc% 1. Data Preprocessing
% a). Artifact rejection (by threshold and by improbability) b). Filtering c). Segmentation d). Baselining e). Rereferencing (if desired) f). Read Channel locations
%Lines altered for NovelFam vs. Adaptation:  24 (convertToMaxlab), 188-95 (re-DIN), 203 (DIN->DIN1)

function [eegdata, EEG] = preprocess( eegfilename,experimentfilename, params, startpoint, endpoint,usecache)
 filtersettings = [0.1 0 0 30];
 params.samplerate = 500;
 params.filtersettings = filtersettings;
 params.rereference = 0;
 params.reworkDINs = 0;
        
    if nargin < 6
        usecache = 0;
    end
    
    if usecache
        [exists eegdata, EEG] = checkCache(eegfilename,params);
        if exists
            disp('Using cached version.....');
            return;
        end
    end
    
    
    %  Do the EEG LAB Processing
    %  Filtering, Baselining, Artifact Rejection, Segmentation
    [EEG, ALLEEG, CURRENTSET] = preprocessEEGLAB(eegfilename,experimentfilename,params, startpoint, endpoint);
     
end

function [EEG, ALLEEG, CURRENTSET] = preprocessEEGLAB( eegfilename, experimentfilename, params, startpoint, endpoint )
    if nargin < 3 
        usefilter =1;
    end
    if nargin < 4
        startpoint = -0.2;
        endpoint = 0.8;
        disp(['Using default startpoint=' num2str(startpoint) ' and endpoint=' endpoint]);
    end
    
    filtersettings = params.filtersettings;
    samplerate = params.samplerate;
    reference = params.rereference;
    
    %PREPROCESS Summary of this function goes here
    %   preprocesses the eegdata and returns it 

    tic; 
    % Load eeglab
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    % Load the dataset
    if size(strfind(eegfilename,'001.raw'),2 > 0)
        EEG = pop_readsegegi(eegfilename);
    else
        EEG = pop_readegi(eegfilename);
    end
    
    
    % Store the dataset into EEGLAB
    [ALLEEG, EEG, CURRENTSET ] = eeg_store(ALLEEG, EEG); 
    infoString = '';
    
    
    
    % % %
    % % %  RESAMPLE
    % % %
    resampleit = 0;
    if EEG.srate ~= samplerate
        resampleit = 1;
    end
    
    if resampleit
        [EEG] = pop_resample( EEG, samplerate);
        EEG.comments = pop_comments(EEG.comments,'',['Dataset was resampled at ' samplerate 'hz'],1);
        infoString = ['SampleRate' num2str(samplerate) 'hz'];
    else
        infoString = ['SampleRate' num2str(EEG.srate) 'hz'];
    end
    
    % % %
    % % %  Remove/interpolate bad channels 
    % % %
    interp = 1;
    if interp
        badChannel = 114;
        EEG = eeg_interp(EEG, badChannel);
    end
    
    % % %
    % % %  DETREND
    % % %
    detrend = 0;
    if detrend
        [EEG] = eeg_detrend(EEG);
        EEG.comments = pop_comments(EEG.comments,'',['Dataset was detrended'],1);
        infoString = [infoString 'DETRENDED_'];
    end
    
    
    % % % 
    % % % FILTERING
    % % % 
    if filtersettings(1,1) > 0 || filtersettings(1,2) > 0 || filtersettings(1,3) > 0 || filtersettings(1,4) > 0 
        usefilter = 1;
    else
        usefilter = 0;
    end
    
    if usefilter
        highpass  = filtersettings(1,1);
        lownotch  = filtersettings(1,2);
        highnotch = filtersettings(1,3);
        lowpass   = filtersettings(1,4);
        
        % Low pass filter the data with frequency of 50 Hz.
         if lowpass ~=0
            EEG = pop_eegfilt( EEG, 0, lowpass,0,0); 
         end
    
        % Notch filter the data with cutoff frequency of 55-65 Hz.
        if lownotch ~= 0 && highnotch ~=0
            EEG = pop_iirfilt(EEG,lownotch,highnotch,0,1);
        end
        
        % High pass filter the data with cutoff frequency of 1 Hz.
        if highpass ~= 0
            EEG = pop_eegfilt( EEG, highpass, 0, 0,0); 
        end
   
        % Below, create a new dataset with the name 'filtered Continuous EEG Data'
        [ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, CURRENTSET, 'setname', 'filtered Continuous EEG Data'); % Now CURRENTSET= 2
            
        % Save the EEG dataset structure
        infoString = [infoString '_' num2str(highpass) 'hz-' num2str(lownotch) 'hz-' num2str(highnotch) 'hz-' num2str(lowpass) 'hz_FILTERED_DINS' num2str(params.reworkDINs)];
        
        % This might be a good time to add a comment to the dataset.
        % You can see the comments stored with the dataset either by typing ">> EEG.comments" or selecting the menu option Edit->About this dataset.
        EEG.comments = pop_comments(EEG.comments,'',['Dataset was filtered ' infoString],1);
     
        setfilename = strrep(eegfilename,'.raw',infoString);
       %%% pop_saveset(EEG,'filename',[setfilename '.set'],'savemode','onefile');
    end

        pop_saveset(EEG,'filename',[setfilename 'filtered_continuous.set'],'savemode','onefile');
end
