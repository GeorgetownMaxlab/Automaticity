%AUTOCRANK Summary of this function goes here
function [ eegdata ] = autocrank(expttype,usecache,iSubj, reworkDINs, filtersettings)
    if nargin < 1
        expttype = 'ALL';
    end
    
    if nargin < 2
        usecache = 1;
    end
%
       samplerate = 500;

      % filtersettings = [0 0 0 0];
      % filtersettings %= [0.1 0 0 30];

       rereference = 0;
       
       %reworkDINs = 1;
        
        params.samplerate = samplerate;
        params.filtersettings = filtersettings;
        params.rereference = rereference;
        params.reworkDINs = reworkDINs;
        
    if strcmp(expttype, 'ADAPT') 
        params.expttype='ADAPT';
        
        %%Replace all -0.2 with -2.2
           
        if strcmp('704-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/704/pre/
            eegFilename = 's704_20140304_autoPre001.raw'; exptFilename = 's704.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('704-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/704/post/
            eegFilename = 'S704_20140422_post001.raw'; exptFilename = 's704_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('794-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/794/pre/
            eegFilename = 'S794_20140227_autoPre001.raw'; exptFilename = 's794_session1.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('794-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/794/post/
            eegFilename = 'S794_20140423_post001.raw'; exptFilename = 's794_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('801-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/801/pre/
            eegFilename = 'Subj801_20130405001.raw'; exptFilename = 's801_adapt1_2.5192.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
            %Function to load the fieldtrip data and look at the signals
        elseif strcmp('801-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/801/post/
            eegFilename = 'S801_20130726_postT001.raw'; exptFilename = 's801_adapt_postt.5192.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('858-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/858/pre/
            eegFilename = 'S858_20140226_autoPre001.raw'; exptFilename = 's858_pre.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('858-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/858/post/
            eegFilename = 'S858_20140409_autoPost001.raw'; exptFilename = 's858_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('860-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/860/pre
            eegFilename = 'Subj860_20131024_autoPre001.raw'; exptFilename = 's860_autopre.5192.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('860-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/860/post
            eegFilename = 'S860_20140212_post001.raw'; exptFilename = 's860_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('882-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/882/pre/
            eegFilename = 'S882_20140404_pre001.raw'; exptFilename = 's882.696.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('882-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/882/post/
            eegFilename = 'S882_20140530_post001.raw'; exptFilename = 's882.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('883-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/883/pre/
            eegFilename = 'S883_20140424_pre001.raw'; exptFilename = 's883_pre.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('883-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/883/post/
            eegFilename = 'S883_20140611_post001.raw'; exptFilename = 's883_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('893-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/893/pre/
            eegFilename = 'S893_20140612_pre001.raw'; exptFilename = 's893_pre.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('893-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/893/post/
            eegFilename = 'S893_20140801_post001.raw'; exptFilename = 's893_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('899-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/899/pre/
            eegFilename = 'S899_20140709_autoPre001.raw'; exptFilename = '899_pre.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('899-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/899/post/
            eegFilename = 'S899_20140812_post001.raw'; exptFilename = 's899_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('904-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/904/pre/
            eegFilename = 'S904_20140829_autoPre001.raw'; exptFilename = 's904.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('904-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/904/post/
            eegFilename = 'S904_20141007_autoPost001.raw'; exptFilename = 's904_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);    
        elseif strcmp('910-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/910/pre/
            eegFilename = 'S910_20140930_autoPre001.raw'; exptFilename = 's910_pre.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);    
        elseif strcmp('910-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/910/post/
            eegFilename = 'S910_20141120_post001.raw'; exptFilename = 's910_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);    
        elseif strcmp('912-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/912/pre/
            eegFilename = 'S912_20141009_autoPre001.raw'; exptFilename = 's912_pre.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);   
        elseif strcmp('912-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/912/post/
            eegFilename = 'S912_20141210_post001.raw'; exptFilename = 's912_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);  
        elseif strcmp('913-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/913/pre/
            eegFilename = 'S913_20141013_autoPre001.raw'; exptFilename = 's913_pre.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);    
        elseif strcmp('913-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/913/post/
            eegFilename = 'S913_20141209001.raw'; exptFilename = 's913_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);   
        elseif strcmp('915-pre', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/915/pre/
            eegFilename = 'S915_20141020001.raw'; exptFilename = 's915_pre.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);    
        elseif strcmp('915-post', iSubj)
            cd /Users/courtney/Documents/EEG/02_EEG_Analysis/01_rawData/aim2/915/post/
            eegFilename = 'S915_20141219_post001.raw'; exptFilename = 's915_post.896.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);   
        elseif strcmp('925', iSubj)
            cd ~/Documents/EEG/02_EEG_Analysis/01_rawData/925/
            eegFilename = 'S925_20150502_1030001.raw'; exptFilename = 's925.6192.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);   
        elseif strcmp('955', iSubj)
            cd ~/Documents/EEG/02_EEG_Analysis/01_rawData/955/
            eegFilename = 'S955_20150915_autoAim1001.raw'; exptFilename = 's955.6192.mat';
            doit(eegFilename,exptFilename,params,-2.2,3.6, usecache);
        elseif strcmp('895', iSubj)
            cd ~/Documents/EEG/02_EEG_Analysis/01_rawData/895/
            eegFilename = 'S895_20150519_autoAim1001.raw'; exptFilename = 's895.6192.mat';
            doit(eegFilename,exptFilename, params,-2.2,3.6, usecache);
        elseif strcmp('939', iSubj)
            cd ~/Documents/EEG/02_EEG_Analysis/01_rawData/939/
            eegFilename = 'S939_20150610_autoAim1001.raw'; exptFilename = 's939.6192.mat';
            doit(eegFilename,exptFilename, params,-2.2,3.6, usecache);
        elseif strcmp('932', iSubj)
            cd ~/Documents/EEG/02_EEG_Analysis/01_rawData/932/
            eegFilename = 'S932_20150708_autoAim1001.raw'; 
            exptFilename = 's932.6192.mat';
            doit(eegFilename,exptFilename, params,-2.2,3.6, usecache);
        elseif strcmp('978', iSubj)
            cd ~/Documents/EEG/02_EEG_Analysis/01_rawData/978/
            eegFilename = 'S978_20151112001.raw'; exptFilename = 's978.6192.mat';
            doit(eegFilename,exptFilename, params,-2.2,3.6, usecache);
       elseif strcmp('990', iSubj)
            cd ~/Documents/EEG/02_EEG_Analysis/01_rawData/990/
            eegFilename = 'S990_20151215001.raw'; exptFilename = 's990EditOddBlockOnly.4192.mat';
            doit(eegFilename,exptFilename, params,-2.2,3.6, usecache); 
        elseif strcmp('991', iSubj)
            cd ~/Documents/EEG/02_EEG_Analysis/01_rawData/991/
            eegFilename = 'S991_20151212001.raw'; exptFilename = '991_12122015.6192.mat';
            doit(eegFilename,exptFilename, params,-2.2,3.6, usecache);
        elseif strcmp('997', iSubj)
            cd ~/Documents/EEG/02_EEG_Analysis/01_rawData/997/
            eegFilename = 'S997_20151209_1414001.raw'; %exptFilename = '997_12092015.6192.mat';
            exptFilename = '997_12092015EDITblock5Remove.6192.mat'; %note due to no din
            %recordings in block 5 marked as incorrect
            doit(eegFilename,exptFilename, params,-2.2,3.6, usecache);
        elseif strcmp('976', iSubj)
            cd ~/Documents/EEG/02_EEG_Analysis/01_rawData/976/
            eegFilename = 'S976_20151104 1435001.raw'; exptFilename = 's976_20151104.6192.mat';
            doit(eegFilename,exptFilename, params,-2.2,3.6, usecache);
        elseif strcmp('996', iSubj)
            cd ~/Documents/EEG/02_EEG_Analysis/01_rawData/996/
            eegFilename = 'S996_20160115_1610001.raw'; exptFilename = 's996EDITblock2Remove.6192.mat';
            doit(eegFilename,exptFilename, params,-2.2,3.6, usecache);
        end
        
    end
    
    if strcmp(expttype, 'novelFam')
        params.expttype='novelFam';
        if iSubj==1
            %Subj 307
            cd ~/Desktop/MaxLabProjects/CarCatPsychtoolbox/210_novelFamiliar/003_rawFiles/
            eegFilename = 'Subj307_20091030_1517001.raw'; exptFilename = 'subj307_novelfamiliar.10120.mat';
            doit(eegFilename,exptFilename,params,-0.2,1.4, usecache);
        elseif iSubj==2
            %Subj289
            cd ~/Desktop/MaxLabProjects/CarCatPsychtoolbox/210_novelFamiliar/003_rawFiles/
            eegFilename = 'Subj289_novelFamiliar001.raw'; exptFilename = 'subj_289.10120.mat';
            doit(eegFilename,exptFilename,params,-0.2,1.4, usecache);
        end 
    end
       
end


function doit(eegFilename,exptFilename,params,starttime,endtime,usecache)
    if nargin < 6
        usecache = 1;
    end
    try
        preprocess(eegFilename, exptFilename,params,starttime,endtime,usecache);
  
    catch ME
        rep = getReport(ME, 'extended');
        disp(['Caught exception ' rep]);
    end 
    close all
    close all hidden
end

%Function
%Load the fieldtrip data and look at key channels; look @ signals in ROIs
%defined with whole group... (N1, P2, FB)
%end

