clear
subj = '996'; %'996' 990' 997'
%Note:
%996 is missing ALL of DINs from block 2 therefore removed trialoutput from
%block 2
%997 is missing some of the DINS from block 5 therefore removed trialoutput
%from block 5
%990 was run on the wrong paradigm and therefore only need odd blocks -
%even blocks removed

switch subj
    case '997'
        file = load('997_12092015.6192.mat');
        fileSaveName = '997_12092015EDITblock5Remove.6192.mat';
        blockRemove = 5;
    case '996'
        file = load('s996.6192.mat');
        fileSaveName = 's996EDITblock2Remove.6192.mat';
        blockRemove = 2;
    case '990'
        file = load('s990.896.mat');
        fileSaveName = 's990EditOddBlockOnly.4192.mat';
        blockRemove = 2:2:8;
end

counter = 1;
for i = 1:length(file.trialOutput)
    if i ~= blockRemove
        trialOutput(counter) = file.trialOutput(i);
        counter = counter + 1;
    end
end
exptdesign = file.exptdesign;

save(fileSaveName, 'trialOutput', 'exptdesign')