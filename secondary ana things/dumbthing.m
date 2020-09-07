
cd('Z:\Kate\KA001\current summary data\Clutter 2ms conv data')
load ('clust1_40clut.mat')
call=struct;
echo=struct;

for i=1:6
    call(i).data=m(i).data(:,1:20,:);
    echo(i).data=m(i).data(:,20:end,:);
end
save('c120clut_ce.mat','call','echo')
clear

load ('clust2_40clut.mat')
call=struct;
echo=struct;

for i=1:6
    call(i).data=m(i).data(:,1:20,:);
    echo(i).data=m(i).data(:,20:end,:);
end
save('c220clut_ce.mat','call','echo')
clear

load ('clust3_40clut.mat')
call=struct;
echo=struct;

for i=1:6
    call(i).data=m(i).data(:,1:20,:);
    echo(i).data=m(i).data(:,20:end,:);
end
save('c320clut_ce.mat','call','echo')
clear