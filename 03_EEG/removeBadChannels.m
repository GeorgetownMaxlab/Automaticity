function [cleanData] = removeBadChannels(data, cfg)

    for j = 1:length(data.trial)
        for k = 2:size(data.trial{j},2)
            val(:,k-1,j) = abs(bsxfun(@minus, data.trial{j}(:,k), data.trial{j}(:,k-1)));
        end
    end
    
    chans=max(max(val,[],3),[],2);
    chans=find(chans>100);
    channels=ft_channelselection(chans, data.label);
    data.cfg.badchannel=channels;
    data.cfg.neighbours=cfg.neighbours;
    data.cfg.method = 'nearest';
    data.cfg.feedback = 'yes';
    cleanData = ft_channelrepair_casEdits03072016(data.cfg, data);
end