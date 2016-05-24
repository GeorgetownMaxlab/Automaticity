function neweegdata = selectIndices(eegdata,indices)
    %changed from 3 to 4 on 11/16/2011
%    neweegdata.data = eegdata.data(:,:,:);
neweegdata.data = eegdata.data(indices,:,:);
    neweegdata.stim = eegdata.stim(indices);
%    neweegdata.soa = eegdata.soa(indices);
%    neweegdata.bad = eegdata.bad(indices);  
%    neweegdata.maskUsed = eegdata.maskUsed(indices);
    neweegdata.subjectHasRightAnswer = eegdata.subjectHasRightAnswer(indices);
    neweegdata.responseStart = eegdata.responseStart(indices);
    neweegdata.subjectAnimalResponse = eegdata.subjectAnimalResponse(indices);         
    neweegdata.responseFinished = eegdata.responseFinished(indices);
    neweegdata.condition = eegdata.condition(indices);
     neweegdata.line = eegdata.line(indices);
     neweegdata.imagePosition1 = eegdata.imagePosition1(indices);
     neweegdata.imagePosition2 = eegdata.imagePosition2(indices);
% %     neweegdata.image1 = eegdata.image1(indices);
% %     neweegdata.image2 = eegdata.image2(indices);
%     neweegdata.stim1cat = eegdata.stim1cat(indices);
%     neweegdata.morphLine = eegdata.morphLine(indices);
%     neweegdata.morphPosition = eegdata.morphPosition(indices);
% %     neweegdata.name = eegdata.name;
% neweegdata.block=eegdata.block(indices);
neweegdata.experimentName = eegdata.experimentName;

  if isfield(eegdata, 'interTrialDuration')
        neweegdata.interTrialDuration = eegdata.interTrialDuration(indices);
    end
    
end