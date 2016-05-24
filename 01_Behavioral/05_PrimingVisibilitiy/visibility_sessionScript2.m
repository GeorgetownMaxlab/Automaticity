 clear
% input session info
    %get subject and date info
    name = input('\n\nEnter Subject NUMBER:\n\n','s');
    number=name;
    exptdesign.number=number;
    
    subjName=[number 'visibility'];
    exptName='sovorZupudVisibilityTest';
    exptdesign.subjectName = subjName;
    if isempty(name)
        name = [datestr(now,'yyyy-mm-dd-HH-MM-') 'MR000'];
    else
        name = [datestr(now,'yyyy-mm-dd-HH-MM-') 'MR' name];
    end
    WaitSecs(0.25);
    if exist(['./sovorZupudVisibilityTestResults/' name],'dir')
    else
        mkdir(['./sovorZupudVisibilityTestResults/' name])
    end

% %run priming experiment
% subjName=['subj' subjectNumber '_priming_' day];
% exptName='sovorZupudMaskedPriming';
% SovorZupudMaskedPriming(subjName,exptName)

% % analyze priming
% [maskedPrimingData] = convertToMaxLab_maskedPriming(['sovorZupudMaskedPrimingResults' filesep subjName '.8.48.mat']);
% [primingAnalysis]=analyzePriming20140516(maskedPrimingData); 
% % close all
% 
% disp('Press any key to continue')
% KbWait
% % subjectNumber=882;
% % day=20140604;
% % run visibiliy test
SovorZupudMaskedPriming(subjName,exptName)
% % 
% % analyze visibility
% % [maskedVisibilityData] = convertToMaxLab_maskedPriming(['sovorZupudVisibilityTestResults'  filesep subjName '.2.48.mat']);
% % 
% % [visibilityAnalysis] = analyzeVisibility20140516(maskedVisibilityData);