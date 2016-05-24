function neweegdata = selectBlinkIndices(eegdata,indices)
    %neweegdata.data = eegdata.data(indices,:,:);
    neweegdata.stim = eegdata.stim(indices);
    neweegdata.subjectHasRightAnswer = eegdata.subjectHasRightAnswer(indices);
    neweegdata.responseStart = eegdata.responseStart(indices);
    neweegdata.subjectAnimalResponse = eegdata.subjectAnimalResponse(indices);         
    neweegdata.responseFinished = eegdata.responseFinished(indices);
    neweegdata.condition = eegdata.condition(indices);    
    neweegdata.trialnumber = eegdata.trialnumber(indices);
    neweegdata.line = eegdata.line(indices);
    neweegdata.imagePosition1 = eegdata.imagePosition1(indices);
    neweegdata.imagePosition2 = eegdata.imagePosition2(indices);
    neweegdata.bad = eegdata.bad(indices);
    neweegdata.experimentName = eegdata.experimentName;
    neweegdata.data = eegdata.data; %blink indexed data were already removed with pop_eegthresh
    neweegdata.name = eegdata.name;
    neweegdata.processedFilename = eegdata.processedFilename;
    %neweegdata.goodindices = eegdata.goodindices;
    neweegdata.srate = eegdata.srate;
    %neweegdata.filterSettings = eegdata.filterSettings;
%     neweegdata.block=eegdata.block(indices);
    
end