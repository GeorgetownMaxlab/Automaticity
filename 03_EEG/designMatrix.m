%DesignMatrix Code

subj                 = length(subject);
design               = zeros(2, 2*subj);

for i=1:subj
    design(1,i) = i;
end
for i=1:subj
    design(1, subj+i) = i;
end


design(2, 1:subj) = 1;
design(2, subj+1:2*subj) = 2;
cfg.design = design;
cfg.uvar = 1;
cfg.ivar = 2;
