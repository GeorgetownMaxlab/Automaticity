   
function conditionTopoPlot(m6, m3b, m3w, m0, data_same, data_diff, subject, subjectList, flag)
    %plot and label m6-m0 with given latency
    cfg = [];
    latency = [0 .4];
    cfg.xlim             = [latency(1) latency(2)];
    cfg.highlight        = 'off';
    cfg.comment          = 'xlim';
    cfg.commentpos       = 'title';
    cfg.layout           = 'EGI128.lay';
    cfg.highlightsize    = 6;
    cfg.highlightcolor   = 'w';
    cfg.colorbar         = 'yes';
    cfg.interactive      = 'yes';
    cfg.parameter        = 'avg';
    
    if flag == 0
        disp('No individual plots of conditions will be generated')
    else
        subplot(231)
        ft_topoplotER(cfg, m6(subject));
        title(['m6-subjects' num2str(length(subjectList)) '-' num2str(subjectList(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
        fixFonts_topo

        saveFormats('test', ['topoAvg_subject_m6' num2str(length(subjectList)) '_' num2str(subjectList(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
                            ['./topo_avg_plot/' num2str(subjectList(subject)) '/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

        %plot and label m3w-m2b with given latency
        subplot(232)
        ft_topoplotER(cfg, m3b(subject));
        title(['m3b-subjects' num2str(length(subjectList)) '-' num2str(subjectList(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
        fixFonts_topo

        saveFormats('test', ['topoAvg_subject_m3b' num2str(length(subjectList)) '_' num2str(subjectList(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
                            ['./topo_avg_plot/' num2str(subjectList(subject)) '/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

        %plot and label diff-same with given latency
        subplot(233)
        ft_topoplotER(cfg, m3w(subject));
        title(['m3w-subjects' num2str(length(subjectList)) '-' num2str(subjectList(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
        fixFonts_topo

        saveFormats('test', ['topoAvg_subject_m3w' num2str(length(subjectList)) '_' num2str(subjectList(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
                            ['./topo_avg_plot/' num2str(subjectList(subject)) '/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

        subplot(234)
        ft_topoplotER(cfg, m0(subject));
        title(['m0-subjects' num2str(length(subjectList)) '-' num2str(subjectList(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
        fixFonts_topo

        saveFormats('test', ['topoAvg_subject_m0' num2str(length(subjectList)) '_' num2str(subjectList(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
                            ['./topo_avg_plot/' num2str(subjectList(subject)) '/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

        subplot(235)
        ft_topoplotER(cfg, data_same(subject));
        title(['same-subjects' num2str(length(subjectList)) '-' num2str(subjectList(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
        fixFonts_topo

        saveFormats('test', ['topoAvg_subject_same' num2str(length(subjectList)) '_' num2str(subjectList(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
                            ['./topo_avg_plot/' num2str(subjectList(subject)) '/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)

        subplot(236)
        ft_topoplotER(cfg, data_diff(subject));
        title(['diff-subjects' num2str(length(subjectList)) '-' num2str(subjectList(subject)) '-latency' num2str(latency(1)) '-' num2str(latency(2))])
        fixFonts_topo

        saveFormats('test', ['topoAvg_subject_diff' num2str(length(subjectList)) '_' num2str(subjectList(subject)) '_latency' num2str(latency(1)) '_' num2str(latency(2))],...
                            ['./topo_avg_plot/' num2str(subjectList(subject)) '/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)
    end
                    