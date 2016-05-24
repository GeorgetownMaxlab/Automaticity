%run cluster searches on saved grand averages
clear;
subject = 932;

%load('data/ft_grandAverages_n12_pre_0.1-30Hz.mat')
load('./01_rawData/932/subj932_post_FT_bothStim_rejChan500hz0.1hz-30hz_fromContinuous.mat')
%load('data/ft_grandAverages_n14_post0.1-30Hz_6cond.mat')
%load('data/ft_grandAverages_n14_pre_0.1-30Hz.mat')
%load('data/ft_grandAverages_n14_post0.1-30Hz.mat')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%   Parameters to be modified   %%%%%%%%
cfg=[];
cfg.layout        = 'EGI128.lay';
cfg.method        = 'triangulation';
neighbours        = ft_prepare_neighbours(cfg)

dataM0           = removeBadChannels(dataM0, cfg);
dataM3W          = removeBadChannels(dataM3W, cfg);
dataM3B          = removeBadChannels(dataM3B, cfg);
dataM6           = removeBadChannels(dataM6, cfg);
   
cfg = []

same             = dataM0;
same.trial       = [dataM0.trial dataM3W.trial];
same.time        = [dataM0.time dataM3W.time];

diff             = dataM6;
diff.trial       = [dataM3B.trial dataM6.trial];
diff.time        = [dataM3B.time dataM6.time];


all_m0           = ft_timelockanalysis(cfg, dataM0);
all_m6           = ft_timelockanalysis(cfg, dataM6);
all_m3w          = ft_timelockanalysis(cfg, dataM3W);
all_m3b          = ft_timelockanalysis(cfg, dataM3B);
all_diff         = ft_timelockanalysis(cfg, diff);
all_same         = ft_timelockanalysis(cfg, same);

cfgbase.baseline = [-.2 0];
m0               = ft_timelockbaseline(cfgbase, all_m0);
m6               = ft_timelockbaseline(cfgbase, all_m6);
m3w              = ft_timelockbaseline(cfgbase, all_m3w);
m3b              = ft_timelockbaseline(cfgbase, all_m3b);
data_diff        = ft_timelockbaseline(cfgbase, all_diff);
data_same        = ft_timelockbaseline(cfgbase, all_same);

cfg = [];
cfg.layout           = 'EGI128.lay';
cfg.channel          = {'all'};
cfg.latency          = [0 0.4];
cfg.neighbours       = neighbours;
cfg.method           = 'montecarlo';
cfg.statistic        = 'depsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum'
cfg.minnbchan        = 2;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.025;
cfg.correcttail      = 'alpha';
cfg.numrandomization = 1000;

% subj = size(grandM0.individual,1);

% for i=1:subj
%     design(1,i) = i;
% end
% for i=1:subj
%     design(1, subj+i) = i;
% end
% design(2, 1:subj) = 1;
% design(2, subj+1:2*subj) = 2;
% cfg.design = design;
% cfg.uvar = 1;
% cfg.ivar = 2;

stat = ft_timelockstatistics(cfg, m0, m6);
%stat = ft_timelockstatistics(cfg, grandM3w, grandM3b);
%stat = ft_timelockstatistics(cfg, grandSame, grandDiff);

%%
plotClusterTopoERPBar('neg', 1, subject, 301:501, m0, m3w, m3b, m6, stat, ['aim1_m0_m6_' subject 'singleSubj_0.1-30Hz'])
plotClusterTopoERPBar('neg', 2, subject, 301:501, m0, m3w, m3b, m6, stat, ['aim1_m0_m6_' subject 'singleSubj_0.1-30Hz'])
