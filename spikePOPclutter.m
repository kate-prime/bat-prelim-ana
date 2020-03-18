function [s,heatcombined]=spikePOPclutter(spike_data,stim_data,heatcombined,idxNeuron,shapes)


for idxShape=1:24
%     figure(99)
%     set(gcf, 'Position', get(0, 'Screensize'));
%     subplot(4,6,idxShape)
%     hold on
    
    clutterPOPspikes=[];
    [clutterPOPspikes,sterrorPOP,labelshape]=whosbigger(stim_data,spike_data,idxShape);
    
    if ~isempty(strfind(shapes{idxShape}, 'AMPsphere'))
       % title(labelshape);
        continue
    end
    
%     s=scatter(clutterPOPspikes(:,1),clutterPOPspikes(:,2));
    s=[];
    
    lookupLARGER={'r','b','m'}; %r 10 is larger, b, 0 is larger, m 20 is larger
    lookupSMALLER={'g','c','y'}; %g 10 is smaller, c, 0 is smaller,y 20 is smaller
    heatcolorLARG=[1,2,3];
    heatcolorSMAL=[4,5,6];
    
    outlierscore = abs(clutterPOPspikes(:,2)-mean(clutterPOPspikes(:,2)));
    [~, maxoutlier] = max(outlierscore);
    notoutliers = setdiff(1:3, maxoutlier);
    [result] = comparison (clutterPOPspikes(maxoutlier,2),clutterPOPspikes(notoutliers(1),2),clutterPOPspikes(notoutliers(2),2),sterrorPOP);
    switch (result)
        case 'larger'
%             s.MarkerFaceColor=lookupLARGER{maxoutlier};
            heatcombined(idxNeuron,idxShape)=heatcolorLARG(maxoutlier);
        case  'smaller'
%             s.MarkerFaceColor=lookupSMALLER{maxoutlier};
            heatcombined(idxNeuron,idxShape)=heatcolorSMAL(maxoutlier);
        case 'murky'
%             s.MarkerFaceColor='w';
            heatcombined(idxNeuron,idxShape)=7;
    end
%     
%     s.MarkerEdgeColor='k';
%     ylim([0 50])
%     title(labelshape);
    
end

end
