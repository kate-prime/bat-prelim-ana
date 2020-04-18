
%a wrapper for making psth figures for clutter conditions

dates=datesOrga('V4');
%dates=[20191106];
summary=struct;
home=('Z:\Kate\KA001');
for i_date = 1 : length(dates)
    date= num2str(dates(i_date));
    folder_dir=dir([home,'/Analyzed/',date,'/Clut*']);
    for i_dep=1:length(folder_dir)
        depth= folder_dir(i_dep).name;
        
        if length(depth)<3 
            continue
        end
        file_dir=dir([home,'/Analyzed/',date,'/',depth,'/','*_psth.mat']);
        for i_data=1:size(file_dir,1)
            cd([home,'/Analyzed/',date,'/',depth,'/'])
            fname=file_dir(i_data,1).name;
            load([file_dir(i_data).folder,'/', file_dir(i_data).name],'groups');
            disp([file_dir(i_data).folder,'/', file_dir(i_data).name]) %can be removed but makes sure I record what files are being loaded
            %fave=findfave(groups);
            %fave=cell2mat(fave);
            %fdata=groups.(fave).mdata;
            %fdata_raw=groups.(fave).gdata;
            try
                summary.(fave).ID(size(summary.(fave).ID,2)+1)={[date,depth,fname]};
                summary.(fave).mean_10(size(summary.(fave).mean_10,1)+1,:)=fdata(1,:);
                summary.(fave).mean_20(size(summary.(fave).mean_20,1)+1,:)=fdata(2,:);
                summary.(fave).mean_40(size(summary.(fave).mean_40,1)+1,:)=fdata(3,:);
                summary.(fave).raw_10(:,:,size(summary.(fave).raw_10,3)+1)=fdata_raw(:,:,1);
                summary.(fave).raw_20(:,:,size(summary.(fave).raw_20,3)+1)=fdata_raw(:,:,2);
                summary.(fave).raw_40(:,:,size(summary.(fave).raw_40,3)+1)=fdata_raw(:,:,3);
            catch
                summary.(fave).ID(1)={[date,depth,fname]};
                summary.(fave).mean_10(1,:)=fdata(1,:);
                summary.(fave).mean_20(1,:)=fdata(2,:);
                summary.(fave).mean_40(1,:)=fdata(3,:);
                summary.(fave).raw_10(:,:,1)=fdata_raw(:,:,1);
                summary.(fave).raw_20(:,:,1)=fdata_raw(:,:,2);
                summary.(fave).raw_40(:,:,1)=fdata_raw(:,:,3);
            end
                
        end
    end
end
save('summary_ptsh_data','summary');