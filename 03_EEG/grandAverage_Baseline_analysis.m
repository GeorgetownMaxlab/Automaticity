%run this for each of 5 groups of subjects
%for qqq=1%:2
qqq=2;
if qqq==1
    saveName = 'pre';
    subject = [801 860 858 704 794 882 883 893 899 904];
elseif qqq==2
    saveName = 'post';
    %subject = [895 925 939 955 976 978 991]; %removed 932 because was causing massive data problems 
%     subject = [895 925 932 939 955 976 978 990 991 996 997]; %removed 976
%     and 991 because no categorical signal on individual plots
    subject = [895 925 932 939 955 978 990 991 996 997];
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
    
    dataM0           = removeBadChannels(dataM0, cfg);
    dataM3W          = removeBadChannels(dataM3W, cfg);
    dataM3B          = removeBadChannels(dataM3B, cfg);
    dataM6           = removeBadChannels(dataM6, cfg);
    
    cfg              = [];
    
    same             = dataM0;
    same.trial       = [dataM0.trial dataM3W.trial];
    same.time        = [dataM0.time dataM3W.time];
    
    diff             = dataM6;
    diff.trial       = [dataM3B.trial dataM6.trial];
    diff.time        = [dataM3B.time dataM6.time];
    
    
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
    
    clear dataM0 dataM3W dataM3B dataM6 same diff;
end

cfg.keepindividual = 'yes';

stringm0   = []; 
stringm3w  = [];
stringm3b  = [];
stringm6   = [];

% grand_m0   = ft_timelockgrandaverage(cfg, m0(1),  m0(2),  m0(3),  m0(4),  m0(5),  m0(6),  m0(7),  m0(8), m0(9));
% grand_m3w  = ft_timelockgrandaverage(cfg, m3w(1), m3w(2), m3w(3), m3w(4), m3w(5), m3w(6), m3w(7),  m3w(8), m3w(9));
% grand_m3b  = ft_timelockgrandaverage(cfg, m3b(1), m3b(2), m3b(3), m3b(4), m3b(5), m3b(6), m3b(7),  m3b(8), m3b(9));
% grand_m6   = ft_timelockgrandaverage(cfg, m6(1),  m6(2),  m6(3),  m6(4),  m6(5),  m6(6),  m6(7),  m6(8), m6(9));
% grand_same = ft_timelockgrandaverage(cfg, data_same(1), data_same(2), data_same(3), data_same(4),...
%                                            data_same(5), data_same(6), data_same(7), data_same(8), data_same(9));
% grand_diff = ft_timelockgrandaverage(cfg, data_diff(1), data_diff(2), data_diff(3), data_diff(4),...
%                                            data_diff(5), data_diff(6), data_diff(7), data_diff(8), data_diff(9));

                                       
grand_m0   = ft_timelockgrandaverage(cfg, m0(1),  m0(2),  m0(3),  m0(4),  m0(5),  m0(6),  m0(7),  m0(8), m0(9), m0(10));
grand_m3w  = ft_timelockgrandaverage(cfg, m3w(1), m3w(2), m3w(3), m3w(4), m3w(5), m3w(6), m3w(7),  m3w(8), m3w(9), m3w(10));
grand_m3b  = ft_timelockgrandaverage(cfg, m3b(1), m3b(2), m3b(3), m3b(4), m3b(5), m3b(6), m3b(7),  m3b(8), m3b(9), m3b(10));
grand_m6   = ft_timelockgrandaverage(cfg, m6(1),  m6(2),  m6(3),  m6(4),  m6(5),  m6(6),  m6(7),  m6(8), m6(9), m6(10));
grand_same = ft_timelockgrandaverage(cfg, data_same(1), data_same(2), data_same(3), data_same(4),...
                                           data_same(5), data_same(6), data_same(7), data_same(8), data_same(9), data_same(10));
grand_diff = ft_timelockgrandaverage(cfg, data_diff(1), data_diff(2), data_diff(3), data_diff(4),...
                                           data_diff(5), data_diff(6), data_diff(7), data_diff(8), data_diff(9), data_diff(10));    