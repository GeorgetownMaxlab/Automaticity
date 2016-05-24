%run this for each of 5 groups of subjects
%for qqq=1%:2
%set this to one if you want individual topo plots for each subject for
%each condition - referes to conditionTopoPlot
indPlot = 0;
qqq=2;
if qqq==1
    saveName = 'pre';
    subject = [801 860 858 704 794 882 883 893 899 904];
elseif qqq==2
    saveName = 'post';
    %subject = [895 925 939 955 976 978 991]; %removed 932 because was causing massive data problems 
%     subject = [895 925 932 939 955 976 978 990 991 996 997]; %removed 976
%     and 991 because no categorical signal on individual plots
    subject = [895 925 932 939 955 978 990 991 996 997]; %removed 976 for pooor performance and poor categorical signal
end

for i = 1:length(subject);
    if qqq == 1
        load(sprintf('./subj%03d_pre_FT_bothStim_rejChan500hz0.1hz-30hz_fromContinuous.mat', subject(i)));
    elseif qqq == 2
        load(sprintf('../01_rawData/%03d/subj%03d_post_FT_bothStim_rejChan500hz0.1hz-30hz_fromContinuous.mat', subject(i), subject(i)));
    end
    
    cfg=[];
    cfg.layout       = 'EGI128.lay';
    cfg.method       = 'triangulation';
    cfg.feedback     = 'no';
    cfg.neighbours   = ft_prepare_neighbours(cfg);
    
    %did this in eeglab preprocessing step - unnessary for now 
%     dataM0           = removeBadChannels(dataM0, cfg);
%     dataM3W          = removeBadChannels(dataM3W, cfg);
%     dataM3B          = removeBadChannels(dataM3B, cfg);
%     dataM6           = removeBadChannels(dataM6, cfg);
    
    cfg              = [];
    cfg.reref        = 'yes';
    cfg.refchannel   = 'all';
    cfg.refmethod    = 'avg';
    
    all_data         = dataM0;
    all_data.trial   = [dataM0.trial dataM3W.trial dataM3B.trial dataM6.trial];
    all_data.time    = [dataM0.time dataM3W.time dataM3B.time dataM6.time];
    data_all(i)      = ft_timelockanalysis(cfg, all_data);
    
    same             = dataM0;
    same.trial       = [dataM0.trial dataM3W.trial];
    same.time        = [dataM0.time dataM3W.time];
    
    diff             = dataM6;
    diff.trial       = [dataM3B.trial dataM6.trial];
    diff.time        = [dataM3B.time dataM6.time];
    
%     m0(i)            = ft_timelockanalysis(cfg, dataM0);
%     m6(i)            = ft_timelockanalysis(cfg, dataM6);
%     m3w(i)           = ft_timelockanalysis(cfg, dataM3W);
%     m3b(i)           = ft_timelockanalysis(cfg, dataM3B);
%     data_diff(i)     = ft_timelockanalysis(cfg, diff);
%     data_same(i)     = ft_timelockanalysis(cfg, same);
%     
    all_m0(i)        = ft_timelockanalysis(cfg, dataM0);
    all_m6(i)        = ft_timelockanalysis(cfg, dataM6);
    all_m3w(i)       = ft_timelockanalysis(cfg, dataM3W);
    all_m3b(i)       = ft_timelockanalysis(cfg, dataM3B);
    all_diff(i)      = ft_timelockanalysis(cfg, diff);
    all_same(i)      = ft_timelockanalysis(cfg, same);
    
    cfgbase.baseline = [-.2 0];
    m0(i)            = ft_timelockbaseline(cfgbase, all_m0(i));
    m6(i)            = ft_timelockbaseline(cfgbase, all_m6(i));
    m3w(i)           = ft_timelockbaseline(cfgbase, all_m3w(i));
    m3b(i)           = ft_timelockbaseline(cfgbase, all_m3b(i));
    data_diff(i)     = ft_timelockbaseline(cfgbase, all_diff(i));
    data_same(i)     = ft_timelockbaseline(cfgbase, all_same(i));
    
     
    %plot individual condition plots for each subject
    conditionTopoPlot(m6, m3b, m3w, m0, data_same, data_diff, i, subject, indPlot)
    
    %plot and label m6-m0 with given latency

    clear dataM0 dataM3W dataM3B dataM6 same diff all_data;
end
cfg.keepindividual = 'yes';

grand_m0   = ft_timelockgrandaverage(cfg, m0(1),  m0(2),  m0(3),  m0(4),  m0(5),  m0(6),  m0(7),  m0(8), m0(9), m0(10));
grand_m3w  = ft_timelockgrandaverage(cfg, m3w(1), m3w(2), m3w(3), m3w(4), m3w(5), m3w(6), m3w(7),  m3w(8), m3w(9), m3w(10));
grand_m3b  = ft_timelockgrandaverage(cfg, m3b(1), m3b(2), m3b(3), m3b(4), m3b(5), m3b(6), m3b(7),  m3b(8), m3b(9), m3b(10));
grand_m6   = ft_timelockgrandaverage(cfg, m6(1),  m6(2),  m6(3),  m6(4),  m6(5),  m6(6),  m6(7),  m6(8), m6(9), m6(10));
grand_same = ft_timelockgrandaverage(cfg, data_same(1), data_same(2), data_same(3), data_same(4),...
                                           data_same(5), data_same(6), data_same(7), data_same(8), data_same(9), data_same(10));
grand_diff = ft_timelockgrandaverage(cfg, data_diff(1), data_diff(2), data_diff(3), data_diff(4),...
                                           data_diff(5), data_diff(6), data_diff(7), data_diff(8), data_diff(9), data_diff(10));  
grand_all = ft_timelockgrandaverage(cfg, data_all(1), data_all(2), data_all(3), data_all(4),...
                                           data_all(5), data_all(6), data_all(7), data_all(8), data_all(9), data_all(10));  

                                       %%
save(['NO976_grand_aim1_' num2str(length(subject)) 'subj_.1-30Hz_reref_noBaseline_all.mat'], 'grand*')

%%
subject = [895 925 932 939 955 978 990 991 996 997];

load(['NO976_grand_aim1_' num2str(length(subject)) 'subj_.1-30Hz_reref_noBaseline_all.mat'])

grand_m0.avg=squeeze(mean(grand_m0.individual, 1));
grand_m3w.avg=squeeze(mean(grand_m3w.individual, 1));
grand_m3b.avg=squeeze(mean(grand_m3b.individual, 1));
grand_m6.avg=squeeze(mean(grand_m6.individual, 1));

grand_same.avg=squeeze(mean(grand_same.individual, 1));
grand_diff.avg=squeeze(mean(grand_diff.individual, 1));
grand_all.avg=squeeze(mean(grand_all.individual, 1));

%%


cfg = [];
latency = [-.4 0];
cfg.xlim             = latency(1):.02: latency(2);
% cfg.zlim             = [-5 2];
cfg.highlight        = 'off';
cfg.comment          = 'xlim';
cfg.commentpos       = 'title';
cfg.layout           = 'EGI128.lay';
cfg.highlightsize    = 6;
cfg.highlightcolor   = 'w';
cfg.colorbar         = 'yes';
cfg.interactive      = 'yes';
cfg.parameter        = 'avg';


%%
scrsz = get(groot,'ScreenSize');
figure('Position',[1 scrsz(4) scrsz(3) scrsz(4)])

ft_topoplotER(cfg, grand_all);
title(['all-NO976-subjects' num2str(length(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
fixFonts_topo

saveFormats('test', ['topoAvg_subject_all' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
    ['./topo_avg_plot/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

subplot(231)
ft_topoplotER(cfg, grand_m0);
title(['m0-NO976-subjects' num2str(length(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
fixFonts_topo

saveFormats('test', ['topoAvg_subject_m0' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
    ['./topo_avg_plot/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

subplot(232)
ft_topoplotER(cfg, grand_m6);
title(['m6-NO976-subjects' num2str(length(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
fixFonts_topo

saveFormats('test', ['topoAvg_subject_m6' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
    ['./topo_avg_plot/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

subplot(233)
ft_topoplotER(cfg, grand_m3w);
title(['m3w-NO976-subjects' num2str(length(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
fixFonts_topo

saveFormats('test', ['topoAvg_subject_m3w' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
    ['./topo_avg_plot/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

subplot(234)
ft_topoplotER(cfg, grand_m3b);
title(['m3b-NO976-subjects' num2str(length(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
fixFonts_topo

saveFormats('test', ['topoAvg_subject_m3b' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
    ['./topo_avg_plot/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

subplot(235)
ft_topoplotER(cfg, grand_same);
title(['same-NO976-subjects' num2str(length(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
fixFonts_topo

saveFormats('test', ['topoAvg_subject_same' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
    ['./topo_avg_plot/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

subplot(236)
ft_topoplotER(cfg, grand_diff);
title(['diff-NO976-subjects' num2str(length(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
fixFonts_topo

saveFormats('test', ['topoAvg_subject_diff' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
    ['./topo_avg_plot/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)




%%


grand_m6_m0 = grand_m6;
grand_m6_m0.avg = grand_m6.avg - grand_m0.avg;
subplot(141)
ft_topoplotER(cfg, grand_m6_m0);
title(['m6-m0-NO976-subjects' num2str(length(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
fixFonts_topo

saveFormats('test', ['topoAvg_subject_m6_m0' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
    ['./topo_avg_plot/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

%plot and label m3w-m2b with given latency
grand_m3bVm3w = grand_m3b;
grand_m3bVm3w.avg = grand_m3b.avg - grand_m3w.avg;
subplot(142)
ft_topoplotER(cfg, grand_m3bVm3w);
title(['m3b-m3w-NO976-subjects' num2str(length(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
fixFonts_topo

saveFormats('test', ['topoAvg_subject_m3b_m3w' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
    ['./topo_avg_plot/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

%plot and label diff-same with given latency
grand_diffVsame = grand_diff;
grand_diffVsame.avg = grand_diff.avg - grand_same.avg;

subplot(143)
ft_topoplotER(cfg, grand_diffVsame);
title(['different-same-NO976-subjects' num2str(length(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
fixFonts_topo

saveFormats('test', ['topoAvg_subject_same_diff' num2str(length(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
    ['./topo_avg_plot/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)



                                       
                                     
%%
save(['NO976_grand_aim1_' num2str(length(subject)) 'subj_.1-30Hz_reref.mat'], 'grand*')




                        
%%

subject = [895 925 932 939 955 978 990 991 996 997];

load(['NO976_grand_aim1_' num2str(length(subject)) 'subj_.1-30Hz.mat'])



%%
cfg                  = [];
cfg.layout           = 'EGI128.lay';
cfg.method           = 'triangulation';
cfg.feedback         = 'no';
neighbours           = ft_prepare_neighbours(cfg);
contrast             = 'N1_8mm';
latency              = [0.0 0.4];
time                 = -600:2:798;
time_range           = find(time==latency(1)*1000):find(time==latency(2)*1000);
timestep             = 0.1;

%N170 any

cfg                  = [];
cfg.layout           = 'EGI128.lay';
cfg.channel          = {'all'};
cfg.latency          = latency;%[0.58 0.61]; %[.5 1.0]%[.33 .38]%[0 0.4]%[.17 .22];
cfg.neighbours       = neighbours;
cfg.method           = 'montecarlo';
cfg.statistic        = 'depsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 2;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.025;
cfg.correcttail      = 'alpha';
cfg.numrandomization = 1000;

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

stat = ft_timelockstatistics(cfg, grand_m0, grand_m6);
%stat = ft_timelockstatistics(cfg, grand_m3w, grand_m3b);
%stat = ft_timelockstatistics(cfg, grand_same, grand_diff);
%%

grand_m0.avg=squeeze(mean(grand_m0.individual, 1));
grand_m3w.avg=squeeze(mean(grand_m3w.individual, 1));
grand_m3b.avg=squeeze(mean(grand_m3b.individual, 1));
grand_m6.avg=squeeze(mean(grand_m6.individual, 1));

grand_same.avg=squeeze(mean(grand_same.individual, 1));
grand_diff.avg=squeeze(mean(grand_diff.individual, 1));

%%
plotClusterTopoERPBar_ind('neg', 1, subject, time_range, grand_m0, grand_m3w, grand_m3b, grand_m6, stat, ['aim1_m0_m6_' num2str(length(subject)) 'subj_0.1-30Hz'])
plotClusterTopoERPBar_ind('pos', 1, subject, time_range, grand_m0, grand_m3w, grand_m3b, grand_m6, stat, ['aim1_m0_m6_' num2str(length(subject)) 'subj_0.1-30Hz'])
      
%%

plotClusterTopoERPBar('pos', 1, subject, time_range, grand_m0, grand_m3w, grand_m3b, grand_m6, stat, ['aim1_m0_m6_' num2str(length(subject)) 'subj_0.1-30Hz'])
plotClusterTopoERPBar('pos', 2, subject, time_range, grand_m0, grand_m3w, grand_m3b, grand_m6, stat, ['aim1_m0_m6_' num2str(length(subject)) 'subj_0.1-30Hz'])
plotClusterTopoERPBar('neg', 1, subject, time_range, grand_m0, grand_m3w, grand_m3b, grand_m6, stat, ['aim1_m0_m6_' num2str(length(subject)) 'subj_0.1-30Hz'])
plotClusterTopoERPBar('neg', 2, subject, time_range, grand_m0, grand_m3w, grand_m3b, grand_m6, stat, ['aim1_m0_m6_' num2str(length(subject)) 'subj_0.1-30Hz'])

%%
qq=1;
if strcmp(sign, 'pos')
    titleText=(['cluster p=' num2str(stat.posclusters(qq).prob, '%1.3f')]);
    value = ismember(stat.posclusterslabelmat, qq);
    duration = ismember(stat.posclusterslabelmat, qq);
elseif strcmp(sign, 'neg')
    titleText=(['cluster p=' num2str(stat.negclusters(qq).prob, '%1.3f')]);
    value = ismember(stat.negclusterslabelmat, qq);
    duration = ismember(stat.negclusterslabelmat, qq);
end

clusterChan = find(any(value(:,:), 2));

durationVector=stat.time(any(duration,1));

stringm0   = []; 
stringm3w  = [];
stringm3b  = [];
stringm6   = [];
cfg = [];
cfg.mvarmethod = 'scalar';
cfg.channel    = clusterChan;

granger_m0   = ft_mvaranalysis(cfg, m0(1));
granger_m3w  = ft_mvaranalysis(cfg, m3w(1));
granger_m3b  = ft_mvaranalysis(cfg, m3b(1));
granger_m6   = ft_mvaranalysis(cfg, m6(1));
granger_same = ft_mvaranalysis(cfg, data_same(1));
granger_diff = ft_mvaranalysis(cfg, data_diff(1));

%%
cfg            = [];
cfg.layout     = 'EGI128.lay';
cfg.graphcolor ='bcmr';
ft_multiplotER(cfg, grand_m0, grand_m3w, grand_m3b, grand_m6)
%%

%plot the results! In 10 ms steps
grandm0vsm6 = grand_m6;
grandm0vsm6.avg = grand_m6.avg - grand_m0.avg;
%figure;
timestep = 0.01;
sampling_rate = 500;
sample_count = length(stat.time);
j = [0.17:timestep:0.22];
m = [1:timestep*sampling_rate:sample_count];

% %Positive Clusters
pos_cluster_pvals    = [stat.posclusters(:).prob];
pos_signif_clust     = find(pos_cluster_pvals < 1.05);
pos                  = ismember(stat.posclusterslabelmat, pos_signif_clust);
%Negative Clusters
neg_cluster_pvals    = [stat.negclusters(:).prob];
neg_signif_clust     = find(neg_cluster_pvals < .05);
pos                  = ismember(stat.negclusterslabelmat, neg_signif_clust);

scrsz = get(0,'ScreenSize');
figa = figure('Position', [scrsz(1), scrsz(2), scrsz(3)/2, scrsz(4)/4]);
for k=1:5;
    subplot(1,5,k);
    cfg = [];
    cfg.xlim = [j(k) j(k+1)];
    cfg.zlim = [-6 2];
    cfg.highlight = 'on';
    pos_int = any(pos(:, m(k):m(k+1)), 2);
    cfg.highlightchannel = find(pos_int);
    cfg.comment = 'xlim';
    cfg.commentpos = 'title';
    cfg.layout    = 'EGI128.lay';
    cfg.highlightsize = 8;
    ft_topoplotER(cfg, grandm0vsm6);
    fixFonts
end
%%
%saveFormats(figa, ['01_clusterStats/ft_N1_' saveName num2str(alpha)], './')
%saveas(figa, ['01_clusterStats/ft_N1cluster_any_who' saveName num2str(alpha) '.fig'], 'fig')
%close(figa)


%Find the channels in our cluster -- allchannels (conjunction)
anyN1cluster  = find(any(pos(:,:), 2))

%plot with stats...
for i=1:1000
    [h p1(i)] = ttest(mean(grand_m0.individual(:, anyN1cluster, i),2), mean(grand_m6.individual(:, anyN1cluster, i), 2));
    [h p2(i)] =  ttest(mean(grand_m3w.individual(:, anyN1cluster, i),2), mean(grand_m3b.individual(:, anyN1cluster, i), 2));
end

%Plot the mean amplitudes over time for the 4 conditions
channels       = ft_channelselection(anyN1cluster, grand_m0.label);
cfg            = [];
cfg.linewidth  = 3;
cfg.channel    = channels;
cfg.xlim       = [-0.2 0.8];
cfg.graphcolor = 'bcmr';
figb           = figure('Position', [scrsz(1), scrsz(2), scrsz(3)/2, scrsz(4)/2]);

subplot(211); 
ft_singleplotER(cfg, grand_m0, grand_m3w, grand_m3b, grand_m6)
legend('m0', 'm3w', 'm3b', 'm6')
title('N1 cluster ERP')
fixFonts

subplot(212)
%Plot the mean amplitudes over time for the 4 conditions
plotpValue(p1(:,1:500), p2(:,1:500), 'N1 cluster stats')
fixFonts

saveFormats(figb, ['01_clusterStats/ft_N1_cluster' saveName num2str(alpha)], './')
saveas(figb, ['01_clusterStats/ft_N1ERP_any_who' saveName num2str(alpha) '.fig'], 'fig')
%close(figb)

%Find the time range of the cluster and pull out the stats
vals           = any(pos(:,:));
start          = find(vals==1, 1, 'first' )+185;
stop           = find(vals==1, 1, 'last' )+185;

%     m0n1 = mean(mean(grand_m0.individual(:, anyN1cluster, start:stop),3),2);
%     m3wn1 = mean(mean(grand_m3w.individual(:, anyN1cluster, start:stop),3),2);
%     m3bn1 = mean(mean(grand_m3b.individual(:, anyN1cluster, start:stop),3),2);
%     m6n1 = mean(mean(grand_m6.individual(:, anyN1cluster, start:stop),3),2);

m0n1=zeros(length(subject),1);
m3wn1=zeros(length(subject),1);
m3bn1=zeros(length(subject),1);
m6n1=zeros(length(subject),1);


for i = 1:length(subject)
    m0n1(i)  = sum(sum(squeeze(grand_m0.individual(i,:,186:211)).*stat.posclusterslabelmat))/sum(sum(stat.posclusterslabelmat));
    m3wn1(i) = sum(sum(squeeze(grand_m3w.individual(i,:,186:211)).*stat.posclusterslabelmat))/sum(sum(stat.posclusterslabelmat));
    m3bn1(i) = sum(sum(squeeze(grand_m3b.individual(i,:,186:211)).*stat.posclusterslabelmat))/sum(sum(stat.posclusterslabelmat));
    m6n1(i)  = sum(sum(squeeze(grand_m6.individual(i,:,186:211)).*stat.posclusterslabelmat))/sum(sum(stat.posclusterslabelmat));
end

figc = figure('Position', [scrsz(1), scrsz(2), scrsz(3)/6, scrsz(4)/4]);
bar([mean(m0n1) mean(m3wn1) mean(m3bn1) mean(m6n1)])
hold on
errorbar([mean(m0n1) mean(m3wn1) mean(m3bn1) mean(m6n1)], [std(m0n1) std(m3wn1) std(m3bn1) std(m6n1)]./sqrt(length(subject)), '*b', 'linewidth', 4)
title('N1 ROI mean amplitude')
set(gca,'XTickLabel',{'M0','M3W', 'M3b', 'M6'})
fixfonts

saveFormats(figc, ['01_clusterStats/ft_330_380' saveName num2str(alpha)], './')
saveas(figc, ['01_clusterStats/ft_N1bar_any_who' saveName num2str(alpha) '.fig'], 'fig')

[~, pm0m6]       = ttest(m0n1, m6n1)
[~, pm3wm3b]     = ttest(m3wn1, m3bn1)
[~, pm0m3w]      = ttest(m0n1, m3wn1)
[~, pm3bm6]      = ttest(m3bn1, m6n1)
[~, pm0m3b]      = ttest(m0n1, m3bn1)
[~, pm3wm6]      = ttest(m3wn1, m6n1)

[~, out.pm0m6]   = ttest(m0n1, m6n1)
[~, out.pm3wm3b] = ttest(m3wn1, m3bn1)
[~, out.pm0m3w]  = ttest(m0n1, m3wn1)
[~, out.pm3bm6]  = ttest(m3bn1, m6n1)
[~, out.pm0m3b]  = ttest(m0n1, m3bn1)
[~, out.pm3wm6]  = ttest(m3wn1, m6n1)

save(['01_clusterStats/ft_N1_' saveName num2str(alpha) '.mat'], 'out', 'pm0m6', 'pm3wm3b', 'pm0m3w', 'pm3bm6', 'anyN1cluster', 'm3wn1', 'm3bn1', 'm0n1', 'm6n1', 'stat')


% catch
%     vals = [saveName 'failed'];
%     save(['01_clusterStats/N1ST' vals num2str(alpha) '.mat'], 'vals');
% end
    % % %

%%
%make the plots we want for the paper using the data above
%first make the topo erp figure

figa = figure('Position', [scrsz(1), scrsz(2), scrsz(3)/2, scrsz(4)/4]);
for k = 1:5
    subplot(1,5,k);
    cfg                  = [];
    cfg.xlim             = [j(k) j(k+1)];
    cfg.zlim             = [-6 2];
    cfg.highlight        = 'on';
    pos_int              = any(pos(:, m(k):m(k+1)), 2);
    cfg.highlightchannel = find(pos_int);
    cfg.comment          = 'xlim';
    cfg.commentpos       = 'title';
    cfg.layout           = 'EGI128.lay';
    cfg.highlightsize    = 8;
    cfg.markersymbol     = 'o';

    ft_topoplotER(cfg, grandm0vsm6);

    fixFonts_topo
end

%%
t=colorbar
fixFonts
set(get(t,'xlabel'),'string','\muV','Fontsize',14)

%%
saveFormats(figa, ['01_clusterStats/ft_N1_colorbar' saveName num2str(alpha)], './')
saveas(figa, ['01_clusterStats/ft_N1cluster_all_colorbar' saveName num2str(alpha) '.fig'], 'fig')
close(figa)
%%
%plot the ERPs ~ with stats
channels       = ft_channelselection(anyN1cluster, grand_m0.label);
cfg            = [];
cfg.linewidth  = 3;
cfg.channel    = channels;
cfg.xlim       = [-0.2 0.8];
cfg.graphcolor = 'bcmr';
figb           = figure('Position', [scrsz(1), scrsz(2), scrsz(3)/2, scrsz(4)/2]);
range          = [-200:2:798];

subplot(211);
xlim([-200 800])
ylim([-7 3])


plot(range,squeeze(mean(grand_m0.avg(anyN1cluster,1:500))), 'r', 'LineWidth', 6)
hold on
plot(range,squeeze(mean(grand_m3w.avg(anyN1cluster,1:500))), 'm--', 'LineWidth', 5)
plot(range,squeeze(mean(grand_m3b.avg(anyN1cluster,1:500))), 'c', 'LineWidth', 5)
plot(range,squeeze(mean(grand_m6.avg(anyN1cluster,1:500))), 'b--', 'LineWidth', 6)
title('N1 cluster ERPs')
ylabel('\muV')
ylim([-7.5 2])
legend('M0', 'M3W', 'M3B', 'M6', 'Location', 'SouthWest')

ylims = ylim;
fixFonts(gca, 14, 3)
plot([-200 798], [0 0], 'k--', 'LineWidth', 1)
plot([-200 -200], [ylims(1) ylims(2)], 'k--', 'LineWidth', 1)
plot([0 0], [ylims(1) ylims(2)], 'k--', 'LineWidth', 1)
plot([200 200], [ylims(1) ylims(2)], 'k--', 'LineWidth', 1)

subplot(212)
%Plot the mean amplitudes over time for the 4 conditions

plotpValue(p1(:,1:500), p2(:,1:500), 'N1 cluster paired t-test over time')
xlabel('time, ms')

saveFormats(figb, ['01_clusterStats/ft_N1_cluster' saveName num2str(alpha)], './')
saveas(figb, ['01_clusterStats/ft_N1ERP_fig' saveName num2str(alpha) '.fig'], 'fig')
 
%%
    %P1 ANY
    % % %2) DO the cluster analysis over P2!!!!!!!
    contrast             = 'P2_best_who';
    window               = [0.20 0.250];
    timestep             = 0.01;
    
    cfg                  = [];
    cfg.channel          = {'all'};
    cfg.latency          = window;%[0.58 0.61]; %[.5 1.0]
    cfg.method           = 'montecarlo';
    cfg.statistic        = 'depsamplesT';
    cfg.correctm         = 'cluster';
    cfg.clusteralpha     = alpha;
    cfg.clusterstatistic = 'maxsum';
    cfg.layout           = 'EGI128.lay';
    cfg.minnbchan        = 2;
    cfg.tail             = 0;
    cfg.clustertail      = 0;
    cfg.alpha            = alpha;
    cfg.numrandomization = 100;
    
    subj                 = length(subject);
    design               = zeros(2, 2*subj);
    
    for i=1:subj
        design(1,i)       = i;
    end
    
    for i=1:subj
        design(1, subj+i) = i;
    end
    
    design(2, 1:subj)        = 1;
    design(2, subj+1:2*subj) = 2;
    cfg.design               = design;
    cfg.uvar                 = 1;
    cfg.ivar                 = 2;
    
    stat = ft_timelockstatistics(cfg, grand_m0, grand_m6);
    
    %plot the results! In 10 ms steps
    grandm0vsm6 = grand_m6;
    grandm0vsm6.avg = grand_m6.avg - grand_m0.avg;
    
    %figure;
    timestep = 0.02;
    sampling_rate = 500;
    sample_count = length(stat.time);
    j = [window(1):timestep:window(2)];
    m = [1:timestep*sampling_rate:sample_count];
    
    %Positive Clusters
    neg_cluster_pvals = [stat.negclusters(:).prob];
    neg_signif_clust = find(neg_cluster_pvals < 1.05);
    neg = ismember(stat.negclusterslabelmat, neg_signif_clust);
    
    %Find the channels in our cluster -- allchannels (conjunction)
    anyP2cluster = find(any(neg(:,:), 2))
    
    %plot with stats...
    for i=1:1000
        [h p1(i)] = ttest(mean(grand_m0.individual(:, anyP2cluster, i),2), mean(grand_m6.individual(:, anyP2cluster, i), 2));
        [h p2(i)] =  ttest(mean(grand_m3w.individual(:, anyP2cluster, i),2), mean(grand_m3b.individual(:, anyP2cluster, i), 2));
    end
    
    %Plot the mean amplitudes over time for the 4 conditions
    channels = ft_channelselection(anyP2cluster, grand_m0.label);
    cfg=[];
    cfg.linewidth = 3;
    cfg.channel = channels;
    cfg.xlim=[-0.2 0.8];
    figb = figure('Position', [scrsz(1), scrsz(2), scrsz(3)/2, scrsz(4)/2]);
    subplot(211); ft_singleplotER(cfg, grand_m0, grand_m3w, grand_m3b, grand_m6)
    legend('m0', 'm3w', 'm3b', 'm6')
    title('P2 cluster ERP')
    fixFonts
    
    subplot(212)
    %Plot the mean amplitudes over time for the 4 conditions
    
    plotpValue(p1(:,1:500), p2(:,1:500), 'P2 cluster stats')
    fixFonts
    
    %Find the time range of the cluster and pull out the stats
    vals=all(neg(:,:));
    % % start = find(vals==1, 1, 'first' )+215;
    % % stop = find(vals==1, 1, 'last' )+215;
    
    m0n1         = zeros(length(subject),1);
    m3wn1        = zeros(length(subject),1);
    m3bn1        = zeros(length(subject),1);
    m6n1         = zeros(length(subject),1);
    
    
    for i=1:length(subject)
        m0n1(i)  = sum(sum(squeeze(grand_m0.individual(i,:,201:226)).*stat.negclusterslabelmat))/sum(sum(stat.negclusterslabelmat));
        m3wn1(i) = sum(sum(squeeze(grand_m3w.individual(i,:,201:226)).*stat.negclusterslabelmat))/sum(sum(stat.negclusterslabelmat));
        m3bn1(i) = sum(sum(squeeze(grand_m3b.individual(i,:,201:226)).*stat.negclusterslabelmat))/sum(sum(stat.negclusterslabelmat));
        m6n1(i)  = sum(sum(squeeze(grand_m6.individual(i,:,201:226)).*stat.negclusterslabelmat))/sum(sum(stat.negclusterslabelmat));
        
    end
    
    figc = figure('Position', [scrsz(1), scrsz(2), scrsz(3)/6, scrsz(4)/4]);
    bar([mean(m0n1) mean(m3wn1) mean(m3bn1) mean(m6n1)])
    hold on
    errorbar([mean(m0n1) mean(m3wn1) mean(m3bn1) mean(m6n1)], [std(m0n1) std(m3wn1) std(m3bn1) std(m6n1)]./sqrt(length(subject)), '*b', 'linewidth', 4)
    %ylim([-6 0])
    title('P2 ROI amplitude')
    set(gca,'XTickLabel',{'M0','M3W', 'M3b', 'M6'})
    fixfonts
    
    [~, pm0m6]       = ttest(m0n1, m6n1)
    [~, pm3wm3b]     = ttest(m3wn1, m3bn1)
    [~, pm0m3w]      = ttest(m0n1, m3wn1)
    [~, pm3bm6]      = ttest(m3bn1, m6n1)
    
    [~, out.pm0m6]   = ttest(m0n1, m6n1)
    [~, out.pm3wm3b] = ttest(m3wn1, m3bn1)
    [~, out.pm0m3w]  = ttest(m0n1, m3wn1)
    [~, out.pm3bm6]  = ttest(m3bn1, m6n1)
    [~, out.pm0m3b]  = ttest(m0n1, m3bn1)
    [~, out.pm3wm6]  = ttest(m3wn1, m6n1)
    
    save(['01_clusterStats/ft_P2variables_ST_200_300ms' contrast saveName num2str(alpha) '.mat'], 'out', 'pm0m6', 'pm3wm3b', 'pm0m3w', 'pm3bm6', 'anyP2cluster', 'm3wn1', 'm3bn1', 'm0n1', 'm6n1')
    
% catch error
%     vals = [saveName 'failed'];
%     save(['01_clusterStats/P2_ST_200_300' vals num2str(alpha) '.mat'], 'vals', 'error');
% end
