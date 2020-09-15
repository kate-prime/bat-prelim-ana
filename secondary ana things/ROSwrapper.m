%bootstrapping wrapper
cd('Z:\Kate\KA001\current summary data\Clutter 2ms conv data')
load ('ce_clust2_10clut.mat','call','echo');

err30call=zeros(36,100);
err30echo=zeros(36,100);
callsdata=struct;
echoesdata=struct;

for i=1:10;
    numb=num2str(i);
    name=(['iteration_',numb]);
    [min_error,across,KL]=Spike_Distance_Analysis_ROS(call,.3,0,0,0);
    callsdata.(name).min_error=min_error;
    %callsdata.(name).across=across;
    err30call(:,i)=min_error(:,30);
end

for i=1:10;
    numb=num2str(i);
    name=(['iteration_',numb]);
    [min_error,across,KL]=Spike_Distance_Analysis_ROS(echo,.3,0,0,0);
    echodata.(name).min_error=min_error;
    %%echodata.(name).across=across;
    err30echo(:,i)=min_error(:,30);
end


save ('c2_10clut_strapped','echodata','callsdata','err30call','err30echo');
call_mat=dumbheat(call_vals,'calls: No Clutter');
echo_mat=dumbheat(echo_vals,'echos: No Clutter');