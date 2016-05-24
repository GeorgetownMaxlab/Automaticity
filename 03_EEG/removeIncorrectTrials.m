function neweegdata = removeIncorrectTrials(eegdata)
    indices = find(eegdata.subjectHasRightAnswer);
    neweegdata = selectIndices(eegdata,indices);
end