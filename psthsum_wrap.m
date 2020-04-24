
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
            load([file_dir(i_data).folder,'/', file_dir(i_data).name],'groups_3');
            disp([file_dir(i_data).folder,'/', file_dir(i_data).name]) %can be removed but makes sure I record what files are being loaded
            
            groups=groups_3;%remember this
            
            fave=findfave(groups);
%             fave=cell2mat(fave);
%             fdata=groups.(fave).mdata;
%             fdata_raw=groups.(fave).gdata;
            
            peaks_data=findresptype(groups);
            save([file_dir(i_data).folder,'/', file_dir(i_data).name],'peaks_data','fave','-append');
            
            if peaks_data.echo>0
                
                 list=fieldnames(groups);
                    for j=1:length(list)
                        name=cell2mat(list(j));
                        mdata=groups.(name).mdata;
                        gdata=groups.(name).gdata;
                        try
                            summary.allpop.(name).ID(size(summary.allpop.(name).ID,1)+1,:)={[date,depth,fname]};
                            summary.allpop.(name).mean_10(size(summary.allpop.(name).mean_10,1)+1,:)=mdata(1,:);
                            summary.allpop.(name).mean_20(size(summary.allpop.(name).mean_20,1)+1,:)=mdata(2,:);
                            summary.allpop.(name).mean_40(size(summary.allpop.(name).mean_40,1)+1,:)=mdata(3,:);
                            summary.allpop.(name).raw_10(:,:,size(summary.allpop.(name).raw_10,3)+1)=gdata(:,:,1);
                            summary.allpop.(name).raw_20(:,:,size(summary.allpop.(name).raw_20,3)+1)=gdata(:,:,2);
                            summary.allpop.(name).raw_40(:,:,size(summary.allpop.(name).raw_40,3)+1)=gdata(:,:,3);
                        catch
                            summary.allpop.(name).ID(1,:)={[date,depth,fname]};
                            summary.allpop.(name).mean_10(1,:)=mdata(1,:);
                            summary.allpop.(name).mean_20(1,:)=mdata(2,:);
                            summary.allpop.(name).mean_40(1,:)=mdata(3,:);
                            summary.allpop.(name).raw_10(:,:,1)=gdata(:,:,1);
                            summary.allpop.(name).raw_20(:,:,1)=gdata(:,:,2);
                            summary.allpop.(name).raw_40(:,:,1)=gdata(:,:,3);
                        end
                    end
%                 if peaks_data.onset>0
%                     for j=1:length(list)
%                         name=cell2mat(list(j));
%                         mdata=groups.(name).mdata;
%                         gdata=groups.(name).gdata;
%                         try
%                             summary.onsetpop.(name).ID(size(summary.onsetpop.(name).ID,1)+1,:)={[date,depth,fname]};
%                             summary.onsetpop.(name).mean_10(size(summary.onsetpop.(name).mean_10,1)+1,:)=mdata(1,:);
%                             summary.onsetpop.(name).mean_20(size(summary.onsetpop.(name).mean_20,1)+1,:)=mdata(2,:);
%                             summary.onsetpop.(name).mean_40(size(summary.onsetpop.(name).mean_40,1)+1,:)=mdata(3,:);
%                             summary.onsetpop.(name).raw_10(:,:,size(summary.onsetpop.(name).raw_10,3)+1)=gdata(:,:,1);
%                             summary.onsetpop.(name).raw_20(:,:,size(summary.onsetpop.(name).raw_20,3)+1)=gdata(:,:,2);
%                             summary.onsetpop.(name).raw_40(:,:,size(summary.onsetpop.(name).raw_40,3)+1)=gdata(:,:,3);
%                         catch
%                             summary.onsetpop.(name).ID(1,:)={[date,depth,fname]};
%                             summary.onsetpop.(name).mean_10(1,:)=mdata(1,:);
%                             summary.onsetpop.(name).mean_20(1,:)=mdata(2,:);
%                             summary.onsetpop.(name).mean_40(1,:)=mdata(3,:);
%                             summary.onsetpop.(name).raw_10(:,:,1)=gdata(:,:,1);
%                             summary.onsetpop.(name).raw_20(:,:,1)=gdata(:,:,2);
%                             summary.onsetpop.(name).raw_40(:,:,1)=gdata(:,:,3);
%                         end
%                     end
%                 else
%                     for j=1:length(list)
%                         name=cell2mat(list(j));
%                         mdata=groups.(name).mdata;
%                         gdata=groups.(name).gdata;
%                         try
%                             summary.nonsetpop.(name).ID(size(summary.nonsetpop.(name).mean_10,1)+1,:)={[date,depth,fname]};
%                             summary.nonsetpop.(name).mean_10(size(summary.nonsetpop.(name).mean_10,1)+1,:)=mdata(1,:);
%                             summary.nonsetpop.(name).mean_20(size(summary.nonsetpop.(name).mean_20,1)+1,:)=mdata(2,:);
%                             summary.nonsetpop.(name).mean_40(size(summary.nonsetpop.(name).mean_40,1)+1,:)=mdata(3,:);
%                             summary.nonsetpop.(name).raw_10(:,:,size(summary.nonsetpop.(name).raw_10,3)+1)=gdata(:,:,1);
%                             summary.nonsetpop.(name).raw_20(:,:,size(summary.nonsetpop.(name).raw_20,3)+1)=gdata(:,:,2);
%                             summary.nonsetpop.(name).raw_40(:,:,size(summary.nonsetpop.(name).raw_40,3)+1)=gdata(:,:,3);
%                         catch
%                             summary.nonsetpop.(name).ID(1,:)={[date,depth,fname]};
%                             summary.nonsetpop.(name).ID(1)={[date,depth,fname]};
%                             summary.nonsetpop.(name).mean_10(1,:)=mdata(1,:);
%                             summary.nonsetpop.(name).mean_20(1,:)=mdata(2,:);
%                             summary.nonsetpop.(name).mean_40(1,:)=mdata(3,:);
%                             summary.nonsetpop.(name).raw_10(:,:,1)=gdata(:,:,1);
%                             summary.nonsetpop.(name).raw_20(:,:,1)=gdata(:,:,2);
%                             summary.nonsetpop.(name).raw_40(:,:,1)=gdata(:,:,3);
%                         end
%                     end                    
%                 end
%             
            %% is it a sharp responder?        
                list=fieldnames(groups);
                if peaks_data.sharp>peaks_data.tonic
                    for j=1:length(list)
                        name=cell2mat(list(j));
                        mdata=groups.(name).mdata;
                        gdata=groups.(name).gdata;
                        try
                            summary.sharppop.(name).ID(size(summary.sharppop.(name).ID,1)+1,:)={[date,depth,fname]};
                            summary.sharppop.(name).mean_10(size(summary.sharppop.(name).mean_10,1)+1,:)=mdata(1,:);
                            summary.sharppop.(name).mean_20(size(summary.sharppop.(name).mean_20,1)+1,:)=mdata(2,:);
                            summary.sharppop.(name).mean_40(size(summary.sharppop.(name).mean_40,1)+1,:)=mdata(3,:);
                            summary.sharppop.(name).raw_10(:,:,size(summary.sharppop.(name).raw_10,3)+1)=gdata(:,:,1);
                            summary.sharppop.(name).raw_20(:,:,size(summary.sharppop.(name).raw_20,3)+1)=gdata(:,:,2);
                            summary.sharppop.(name).raw_40(:,:,size(summary.sharppop.(name).raw_40,3)+1)=gdata(:,:,3);
                        catch
                            summary.sharppop.(name).ID(1,:)={[date,depth,fname]};
                            summary.sharppop.(name).mean_10(1,:)=mdata(1,:);
                            summary.sharppop.(name).mean_20(1,:)=mdata(2,:);
                            summary.sharppop.(name).mean_40(1,:)=mdata(3,:);
                            summary.sharppop.(name).raw_10(:,:,1)=gdata(:,:,1);
                            summary.sharppop.(name).raw_20(:,:,1)=gdata(:,:,2);
                            summary.sharppop.(name).raw_40(:,:,1)=gdata(:,:,3);
                        end
                    end
                else
                    for j=1:length(list)
                        name=cell2mat(list(j));
                        mdata=groups.(name).mdata;
                        gdata=groups.(name).gdata;
                        try
                            summary.tonicpop.(name).ID(size(summary.tonicpop.(name).ID,1)+1,:)={[date,depth,fname]};
                            summary.tonicpop.(name).mean_10(size(summary.tonicpop.(name).mean_10,1)+1,:)=mdata(1,:);
                            summary.tonicpop.(name).mean_20(size(summary.tonicpop.(name).mean_20,1)+1,:)=mdata(2,:);
                            summary.tonicpop.(name).mean_40(size(summary.tonicpop.(name).mean_40,1)+1,:)=mdata(3,:);
                            summary.tonicpop.(name).raw_10(:,:,size(summary.tonicpop.(name).raw_10,3)+1)=gdata(:,:,1);
                            summary.tonicpop.(name).raw_20(:,:,size(summary.tonicpop.(name).raw_20,3)+1)=gdata(:,:,2);
                            summary.tonicpop.(name).raw_40(:,:,size(summary.tonicpop.(name).raw_40,3)+1)=gdata(:,:,3);
                        catch
                            summary.tonicpop.(name).ID(1,:)={[date,depth,fname]};
                            summary.tonicpop.(name).mean_10(1,:)=mdata(1,:);
                            summary.tonicpop.(name).mean_20(1,:)=mdata(2,:);
                            summary.tonicpop.(name).mean_40(1,:)=mdata(3,:);
                            summary.tonicpop.(name).raw_10(:,:,1)=gdata(:,:,1);
                            summary.tonicpop.(name).raw_20(:,:,1)=gdata(:,:,2);
                            summary.tonicpop.(name).raw_40(:,:,1)=gdata(:,:,3);
                        end
                    end                    
                end
            end
            
        end
    end
end
        save('summary_ptsh_data','summary');