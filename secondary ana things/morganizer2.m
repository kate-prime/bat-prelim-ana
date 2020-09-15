objs=fieldnames(cluster1.no);
for i=1:6
    name=cell2mat(objs(i));
    call(i).data=cluster1.no.(name)(:,1:15,:);
    echo(i).data=cluster1.no.(name)(:,15:end,:);
end
save('ce_clust1_noclut','call','echo')
clear call echo

objs=fieldnames(cluster1.ten);
for i=1:6
    name=cell2mat(objs(i));
    call(i).data=cluster1.ten.(name)(:,1:15,:);
    echo(i).data=cluster1.ten.(name)(:,15:end,:);
end
save('ce_clust1_10clut','call','echo')
clear call echo

objs=fieldnames(cluster1.twenty);
for i=1:6
    name=cell2mat(objs(i));
    call(i).data=cluster1.twenty.(name)(:,1:15,:);
    echo(i).data=cluster1.twenty.(name)(:,15:end,:);
end
save('ce_clust1_20clut','call','echo')
clear call echo


objs=fieldnames(cluster2.no);
for i=1:6
    name=cell2mat(objs(i));
    call(i).data=cluster2.no.(name)(:,1:15,:);
    echo(i).data=cluster2.no.(name)(:,15:end,:);
end
save('ce_clust2_noclut','call','echo')
clear call echo

objs=fieldnames(cluster2.ten);
for i=1:6
    name=cell2mat(objs(i));
    call(i).data=cluster2.ten.(name)(:,1:15,:);
    echo(i).data=cluster2.ten.(name)(:,15:end,:);
end
save('ce_clust2_10clut','call','echo')
clear call echo

objs=fieldnames(cluster2.twenty);
for i=1:6
    name=cell2mat(objs(i));
    call(i).data=cluster1.twenty.(name)(:,1:15,:);
    echo(i).data=cluster1.twenty.(name)(:,15:end,:);
end
save('ce_clust2_20clut','call','echo')
clear call echo

objs=fieldnames(cluster3.no);
for i=1:6
    name=cell2mat(objs(i));
    call(i).data=cluster1.no.(name)(:,1:15,:);
    echo(i).data=cluster1.no.(name)(:,15:end,:);
end
save('ce_clust3_noclut','call','echo')
clear call echo

objs=fieldnames(cluster3.ten);
for i=1:6
    name=cell2mat(objs(i));
    call(i).data=cluster1.ten.(name)(:,1:15,:);
    echo(i).data=cluster1.ten.(name)(:,15:end,:);
end
save('ce_clust3_10clut','call','echo')
clear call echo

objs=fieldnames(cluster3.twenty);
for i=1:6
    name=cell2mat(objs(i));
    call(i).data=cluster1.twenty.(name)(:,1:15,:);
    echo(i).data=cluster1.twenty.(name)(:,15:end,:);
end
save('ce_clust3_20clut','call','echo')
clear call echo