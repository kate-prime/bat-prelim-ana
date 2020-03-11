function [s]=spikePOPclutter(spike_data,stim_data)


for idxShape=1:24
    figure(99)
    set(gcf, 'Position', get(0, 'Screensize'));
    subplot(4,6,idxShape)
    hold on
    
    clutterPOPspikes=[];
    [clutterPOPspikes,sterrorPOP,labelshape]=whosbigger(stim_data,spike_data,idxShape);
    
    if length(clutterPOPspikes) <3
        title(labelshape);
        continue
    end
    
    s=scatter(clutterPOPspikes(:,1),clutterPOPspikes(:,2));
    
    lookupLARGER={'r','b','m'};
    lookupSMALLER={'g','c','y'};
    
    
    outlierscore = abs(clutterPOPspikes(:,2)-mean(clutterPOPspikes(:,2)));
    [~, maxoutlier] = max(outlierscore);
    notoutliers = setdiff(1:3, maxoutlier);
    [result] = comparison (clutterPOPspikes(maxoutlier,2),clutterPOPspikes(notoutliers(1),2),clutterPOPspikes(notoutliers(2),2),sterrorPOP)
    switch (result)
        case 'larger'
            s.MarkerFaceColor=lookupLARGER{maxoutlier};
        case  'smaller'
            s.MarkerFaceColor=lookupSMALLER{maxoutlier};
        case 'murky'
            s.MarkerFaceColor='w';
    end
    
    s.MarkerEdgeColor='k';
    ylim([0 50])
    title(labelshape);
    
end

end
