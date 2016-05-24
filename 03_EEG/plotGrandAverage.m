function plotGrandAverage(subject, contrast, latency, timeStep, timeWindow)

if nargin <3
    latency = [0.200 0.250];
end
if nargin < 4
    timeStep = .05;
end
if nargin < 5
    timeWindow = [0 .4];
end

scrsz = get(groot,'ScreenSize');
figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])

cfg = [];
cfg.xlim             = timeWindow(1): timeStep : timeWindow(2);
cfg.highlight        = 'on';
cfg.comment          = 'xlim';
cfg.commentpos       = 'title';
cfg.layout           = 'EGI128.lay';
cfg.highlightsize    = 6;
cfg.highlightcolor   = 'w';
cfg.colorbar         = 'yes';
cfg.interactive      = 'yes';
cfg.parameter        = 'avg';          

%initialize all structures to a data structure created in fieldtrip
grand_m0Vm6 = contrast.m6;
grand_m3wVm3b = contrast.m3w;
grand_sameVdiff = contrast.same;

%generate a matrix with the correct points to extract given a particular
%latency and the full time window
time       = -600 : 2 : 798;
time_range = find(time==latency(1)*1000):find(time==latency(2)*1000);

%take mean across subjects and extract given timewindow 
for i = 1:length(grand_m0Vm6)
    grand_m0Vm6(i).avg = grand_m0Vm6(i).avg - contrast.m0(i).avg;
    grand_m3wVm3b(i).avg = grand_m3wVm3b(i).avg - contrast.m3b(i).avg;
    grand_sameVdiff(i).avg = grand_sameVdiff(i).avg - contrast.m3b(i).avg;
end

sum_m0m6 = 0;
sum_m3wm3b = 0;
sum_same_diff = 0;
for i = 1:length(grand_m0Vm6)
    sum_m0m6 = sum_m0m6 + grand_m0Vm6(i).avg;
    sum_m3wm3b = sum_m3wm3b + grand_m3wVm3b(i).avg;
    sum_same_diff = sum_m3wm3b + grand_sameVdiff(i).avg;
end
grand_m0Vm6 = grand_m0Vm6(:,1);
grand_m3wVm3b = grand_m3wVm3b(:,1);
grand_sameVdiff = grand_sameVdiff(:,1); 

grand_m0Vm6.avg = sum_m0m6/length(subject);
grand_m3wVm3b.avg = sum_m3wm3b/length(subject);
grand_sameVdiff.avg = sum_same_diff/length(subject);

grand_m0Vm6.avg = grand_m0Vm6.avg(:,time_range);
grand_m0Vm6.time = grand_m0Vm6.time(1, time_range);
grand_m3wVm3b.avg = grand_m3wVm3b.avg(:,time_range);
grand_sameVdiff.avg = grand_sameVdiff.avg(:,time_range);

%plot and label m6-m0 with given latency 
subplot(141)
ft_topoplotER(cfg, grand_m0Vm6);
title(['m6-m0_NO997_NO976_subjects' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))])
fixFonts_topo

%plot and label m3w-m2b with given latency
subplot(142)
ft_topoplotER(cfg, grand_m3wVm3b);
title(['m3w-m3b_NO997_NO976_subjects' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))])
fixFonts_topo

%plot and label diff-same with given latency 
subplot(143)
ft_topoplotER(cfg, grand_diffVsame);
title(['different-same_NO997_NO976_subjects' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))])
fixFonts_topo

fixFonts

saveFormats('test', [contrast '_topoAvg_subject' num2str(length(subject)) '_latency' num2str(stat.cfg.latency(1)) '_' num2str(stat.cfg.latency(2))],...
            ['./topo_avg_plot/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

end
