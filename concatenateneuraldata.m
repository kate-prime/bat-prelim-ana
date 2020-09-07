
day='20190628'

path=['G:\Angie data\shapes project\',day,'\Matfile\'];

files=dir([path 'FT*'])
for idx2 = 1 : length(files)
    for idx=1:16;
        channel=['Chn',num2str(idx)]
%         categ=strrep(files(idx2).nam e,'FT','3D'); %this is only necessary for 3D
%         categ(end)='1';%this is only necessary for 3D
%         temp=load([path,categ,'\',channel,'.mat']); %this is the 3D
        temp=load([path,strrep(files(idx2).name,'FT','clutter'),'\',channel,'.mat']); %this is the clutter
%         
        temp2=load([path,files(idx2).name,'\',channel,'.mat']); %this is the FT
        
        data=[temp2.data,temp.data];%temp2 is always FT so FT comes before clutter and 3D ALWAYS
        sr=temp.sr;
        
%  newpath=([path,strrep(files(idx2).name,'FT','3DplusFT'),filesep]);%this is for 3D
        newpath=([path,strrep(files(idx2).name,'FT','All'),filesep])% this is for clutter
       mkdir(newpath)
       save([newpath,channel,'.mat'],'data','sr')
    end
end