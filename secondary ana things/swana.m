inter.pair=struct;
intra.pair=struct;

for k=1:size(across,1)
    ident=across(k,1).pairID;
    if ident(1)==ident(2)
        name=['name','_',num2str(ident(1,1)),'_',num2str(ident(1,2))];
        for kk=1:size(across,2)
            intra.pair.(name)(:,kk)=across(k,kk).dist;
        end
    else
        name=['name','_',num2str(ident(1,1)),'_',num2str(ident(1,2))];
        for kk=1:size(across,2)
            inter.pair.(name)(:,kk)=across(k,kk).dist;
        end
    end
end

perf=struct;
pairs=fieldnames(inter.pair);
for j=1:30
    set=num2str(j);
    alsoname=['set','_',set];
    
    if j<=5
        intra_dist=intra.pair.name_1_1;
    elseif j>5 && j<=10
        intra_dist=intra.pair.name_1_2;
    elseif j>10 && j<=15
        intra_dist=intra.pair.name_1_3;
    elseif j>15 && j<=20
        intra_dist=intra.pair.name_1_4;
    elseif j>20 && j<=25
        intra_dist=intra.pair.name_1_5;
    elseif j>25 && j<=30
        intra_dist=intra.pair.name_1_6;
    end
    current=cell2mat(pairs(j));
    inter_dist=inter.pair.(current);
    inter_dist(~isfinite(inter_dist)) = 0;
    intra_dist(~isfinite(intra_dist)) = 0;
    
    for jj=1:size(inter_dist,1)
        [Pmiss, Pfa] = pairwise_discrimination(intra_dist(jj,:), inter_dist(jj,:), 'logn');
        perf.(alsoname).pmiss(jj,:)=Pmiss;
        perf.(alsoname).pfa(jj,:)=Pfa;
    end
end