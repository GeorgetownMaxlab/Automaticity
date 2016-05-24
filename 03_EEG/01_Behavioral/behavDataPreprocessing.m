filesL = dir('/Users/courtney/GoogleDrive/Riesenhuber/05_2015_scripts/Automaticity/03_EEG/02_rawData/*.mat');
for i = 1:length(filesL)
    exptDataL(i,:) = load(filesL(i).name);
end

for i = 1:length(filesL)
    trialOutput = exptDataL(i).trialOutput;
    for j = 1:length(trialOutput)
        trialOutputNew(j).endTime               = [trialOutput(j).trials.trialEndTime];
        trialOutputNew(j).startTime             = [trialOutput(j).trials.trialStartTime];
        trialOutputNew(j).ACC                   = [trialOutput(j).trials.subjectHasRightAnswer];
        trialOutputNew(j).correctResponse       = [trialOutput(j).trials.correctResponse];
        trialOutputNew(j).subjectAnimalResponse = [trialOutput(j).trials.subjectAnimalResponse];
        trialOutputNew(j).mLine                  = [trialOutput(j).trials.line];
        trialOutputNew(j).condition             = [trialOutput(j).trials.condition];
    end
    exptdesign = exptDataL(i).exptdesign;
    save([exptDataL(i).exptdesign.subjectName '_CAS_03292016'], 'trialOutputNew', 'exptdesign')
end

