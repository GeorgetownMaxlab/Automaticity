function plotClusterTopoERPBar_ind(sign, number, subject, time_range, grand_m0, grand_m3w, grand_m3b, grand_m6, stat, contrast)
%time_range=time_range+200;
qq=number;
for i = 1:length(subject)

    iGrand_m0vsm6 = grand_m6;
    iGrand_m0vsm6.individual = iGrand_m0vsm6.individual(i,:,:);
    iGrand_m0.individual = grand_m0.individual(i,:,:);
    iGrand_m0vsm6.individual = squeeze(iGrand_m0vsm6.individual - iGrand_m0.individual);

    if strcmp(sign, 'pos')
        titleText=(['cluster p=' num2str(stat.posclusters(qq).prob, '%1.3f')]);
        value = ismember(stat.posclusterslabelmat, qq);
        duration = ismember(stat.posclusterslabelmat, qq);
    elseif strcmp(sign, 'neg')
        titleText=(['cluster p=' num2str(stat.negclusters(qq).prob, '%1.3f')]);
        value = ismember(stat.negclusterslabelmat, qq);
        duration = ismember(stat.negclusterslabelmat, qq);
    end


    channels = 1:128;

    clusterChan = find(any(value(:,:), 2));

    durationVector=stat.time(any(duration,1));

    cfg = [];
    cfg.xlim = [min(durationVector) max(durationVector)];
    cfg.highlight = 'on';

    cfg.highlightchannel = clusterChan;
    cfg.comment = 'xlim';
    cfg.commentpos = 'title';
    cfg.layout    = 'EGI128.lay';
    cfg.highlightsize = 6;
    cfg.highlightcolor='w';
    cfg.colorbar ='yes';
    cfg.interactive = 'yes';
    cfg.parameter = 'avg';
    
    figure; ft_topoplotER(cfg, iGrand_m0vsm6);
    saveFormats('test', [num2str(subject(i)) '_timeCourse_' contrast '_topoERPBarCluster_' sign num2str(number) 'clusterAlpha' num2str(stat.cfg.clusteralpha) 'minnbchan' num2str(stat.cfg.minnbchan) ...
        'latency' num2str(stat.cfg.latency(1)) '_' num2str(stat.cfg.latency(2)) 'numRand' num2str(stat.cfg.numrandomization)], './excel_figures/', 100)

    cfg.xlim = [min(durationVector) max(durationVector)];
    scrsz=[0 0 2560 1440];
    figure('Position', [scrsz(1), scrsz(2), scrsz(3)*.75, scrsz(4)*.5]);
    subplot(131)
    ft_topoplotER(cfg, iGrand_m0vsm6);
    %ft_topoplotTFR(cfg, grandm0vsm6);
    fixFonts_topo
    

    
    title([titleText ' time [' num2str(min(durationVector)) ' ' num2str(max(durationVector)) ']'])
    fixFonts

    subplot(132)

    secondStim=1:700;

    range=-600:2:798;

    plot(range,squeeze(mean(grand_m0.individual(i,clusterChan,secondStim))), 'b', 'LineWidth', 6)
    xlim([-200 600])
    hold on
    plot(range,squeeze(mean(grand_m3w.individual(i,clusterChan,secondStim))), 'c--', 'LineWidth', 5)
    plot(range,squeeze(mean(grand_m3b.individual(i,clusterChan,secondStim))), 'm--', 'LineWidth', 5)
    plot(range,squeeze(mean(grand_m6.individual(i,clusterChan,secondStim))), 'r', 'LineWidth', 6)
    %title('P2 cluster ERPs')
    ylabel('\muV')


    legend('M0', 'M3W', 'M3B', 'M6', 'Location', 'SouthWest')
    %ylim([-7.5 2])

    ylims=ylim;
    fixFonts(gca, 14, 3)
    plot([-600 798], [0 0], 'k--', 'LineWidth', 1)
    plot([-200 -200], [ylims(1) ylims(2)], 'k--', 'LineWidth', 1)
    plot([0 0], [ylims(1) ylims(2)], 'k--', 'LineWidth', 1)
    plot([200 200], [ylims(1) ylims(2)], 'k--', 'LineWidth', 1)
    highlightpatchOne(min(durationVector)*1000, max(durationVector)*1000)

    title([titleText ' time [' num2str(min(durationVector)) ' ' num2str(max(durationVector)) ']'])
    fixFonts(gca, 14, 3)

    if strcmp(sign, 'pos')
        m0 = sum(sum(squeeze(grand_m0.individual(i,channels,time_range)).*(stat.posclusterslabelmat==qq)))/sum(sum(stat.posclusterslabelmat==qq));
        m3w = sum(sum(squeeze(grand_m3w.individual(i,channels,time_range)).*(stat.posclusterslabelmat==qq)))/sum(sum(stat.posclusterslabelmat==qq));
        m3b = sum(sum(squeeze(grand_m3b.individual(i,channels,time_range)).*(stat.posclusterslabelmat==qq)))/sum(sum(stat.posclusterslabelmat==qq));
        m6 = sum(sum(squeeze(grand_m6.individual(i,channels,time_range)).*(stat.posclusterslabelmat==qq)))/sum(sum(stat.posclusterslabelmat==qq));
        
        titleText=(['cluster p=' num2str(stat.posclusters(qq).prob, '%1.3f')]);
        
    elseif strcmp(sign, 'neg')
        m0 = sum(sum(squeeze(grand_m0.individual(i,channels,time_range)).*(stat.negclusterslabelmat==qq)))/sum(sum(stat.negclusterslabelmat==qq));
        m3w = sum(sum(squeeze(grand_m3w.individual(i,channels,time_range)).*(stat.negclusterslabelmat==qq)))/sum(sum(stat.negclusterslabelmat==qq));
        m3b = sum(sum(squeeze(grand_m3b.individual(i,channels,time_range)).*(stat.negclusterslabelmat==qq)))/sum(sum(stat.negclusterslabelmat==qq));
        m6 = sum(sum(squeeze(grand_m6.individual(i,channels,time_range)).*(stat.negclusterslabelmat==qq)))/sum(sum(stat.negclusterslabelmat==qq));
        
        titleText=(['cluster p=' num2str(stat.negclusters(qq).prob, '%1.3f')]);
    end
    
    fHand = subplot(133);
    aHand = subplot(fHand);
    writepvalueNeg_ind(aHand, m0, m3w, m3b, m6)
    title(titleText)
    fixFonts

    saveFormats('test', [num2str(subject(i)) contrast '_topoERPBarCluster_' sign num2str(number) 'clusterAlpha' num2str(stat.cfg.clusteralpha) 'minnbchan' num2str(stat.cfg.minnbchan) ...
        'latency' num2str(stat.cfg.latency(1)) '_' num2str(stat.cfg.latency(2)) 'numRand' num2str(stat.cfg.numrandomization)], ['./excel_figures/' datestr(now,'yyyy-mm-dd-HH-MM') '/'], 100)
end