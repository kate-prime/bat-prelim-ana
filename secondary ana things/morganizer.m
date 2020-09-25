
cd('Z:\Kate\KA001\current summary data\Clutter 2ms conv data')
load ('clustered_psth_2.mat','cluster3')
call=struct;
echo=struct;
names=fieldnames(cluster3.no);
for i=1:6
    obj=cell2mat(names(i));
    data=cluster3.no.(obj);
    call(i).data=data(:,1:19,:);
    echo(i).data=data(:,19:end,:);
end
save('c3noclut_ce.mat','call','echo')
clear

load ('clustered_psth_2.mat','cluster3')
call=struct;
echo=struct;
names=fieldnames(cluster3.ten);
for i=1:6
    obj=cell2mat(names(i));
    data=cluster3.ten.(obj);
    call(i).data=data(:,1:19,:);
    echo(i).data=data(:,19:end,:);
end
save('c310clut_ce.mat','call','echo')
clear

load ('clustered_psth_2.mat','cluster3')
call=struct;
echo=struct;
names=fieldnames(cluster3.twenty);
for i=1:6
    obj=cell2mat(names(i));
    data=cluster3.twenty.(obj);
    call(i).data=data(:,1:19,:);
    echo(i).data=data(:,19:end,:);
end
save('c320clut_ce.mat','call','echo')
clear