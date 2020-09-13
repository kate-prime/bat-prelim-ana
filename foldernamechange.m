function foldernamechange
[dates] = datesOrga('V2')
sourcepath='E:\Angie data\shapes project\'
destpath='W:\Kate\KA001\IC units\';
for i_date = 1 : length(dates)
    date= num2str(dates(i_date));
    
    folder_dir=dir([sourcepath,date,'\NI\']);
    for i_dep=1:length(folder_dir)
    depth= folder_dir(i_dep).name;
        
        if depth(1)=='.' || depth(1) == 'F' %for weird empty folders
            continue
        end
        oldsource=dir([sourcepath,date,'\NI\Nat_',depth(5:end),'\*.tdms'])
                
   for ifile=1:length(oldsource)
       oldname=[sourcepath,date,'\NI\Nat_',depth(5:end),'\',oldsource(ifile).name]
       newname=[destpath,date,'\NI\Clut_',depth(5:end),'\',oldsource(ifile).name]
       avoiding3D=strsplit(oldname,'\')
       if avoiding3D{5}(1)=='F' || avoiding3D{5}(end)=='1'
           continue
       else
       newsource=mkdir([destpath,date,'\NI\Clut_',depth(5:end),'\'])    
       copyfile(oldname,newname)
       end
   end
end
end

% function foldernamechange
% [dates] = datesOrga('V2')
% sourcepath='E:\Angie data\shapes project\neural_data_2019\clutter_stim\'
% destpath='W:\Kate\KA001\uncat\';
% for i_date = 1 : length(dates)
%     date= num2str(dates(i_date));
%     
%     folder_dir=dir([sourcepath,date]);
%     for i_dep=1:length(folder_dir)
%     depth= folder_dir(i_dep).name;
%         
%         if depth(1)=='.' || depth(1) == 'F' %for weird empty folders
%             continue
%         end
%         oldsource=dir([sourcepath,date,'\All_',depth(5:end),'\times_Chn*'])
%         newsource=mkdir([destpath,date,'\Clut_',depth(5:end),'\'])
%    for ifile=1:length(oldsource)
%        oldname=[sourcepath,date,'\All_',depth(5:end),'\',oldsource(ifile).name]
%        newname=[destpath,date,'\Clut_',depth(5:end),'\',oldsource(ifile).name]
%        copyfile(oldname,newname)
%   
%    end
% end
% end

% %%
% 
% [dates] = datesOrga('V2')
% sourcepath='E:\Angie data\shapes project\'
% destpath='W:\Kate\KA001\IC units\';
% for i_date = 1 : length(dates)
%     date= num2str(dates(i_date));
%     
%     folder_dir=dir([sourcepath,date,'\Matfile\']);
%     for i_dep=1:length(folder_dir)
%     depth= folder_dir(i_dep).name;
%         
%         if depth(1)=='.' || depth(1) == 'F' || depth(1) == 'A'|| depth(1) == '3' %for weird empty folders
%             continue
%         end
%         
%         oldname=([sourcepath,date,'\Matfile\',depth,'\Chn17.mat'])
%         newsource=mkdir([destpath,date,'\Matfile\Clut',depth(8:end),'\'])
%    
%       
%        newname=[destpath,date,'\Matfile\Clut',depth(8:end),'\Chn17.mat']
%       
%        copyfile(oldname,newname)
%   
%    end
% end
