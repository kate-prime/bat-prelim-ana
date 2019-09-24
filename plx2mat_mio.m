clear
close all


path='G:\Angie data\shapes project\20190911\';
 
load_path=[path,'Plexon\'];
save_path=[path,'Matfile\'];
mkdir(save_path)
file_dir=dir([load_path,'*.plx']); 

for i_name=1:length(file_dir) 
    
    fname=file_dir(i_name).name;
    depth_cell=strsplit(fname,'.');     
    depth=depth_cell{1};
    mkdir([save_path, depth])
    
    
    for i_ch = 1:17
        chn = i_ch-1;
        [sr, ~, ~, ~, ad] = plx_ad_v([load_path,fname], chn);
        data = ad';
        save([save_path,depth,'\Chn',num2str(i_ch),'.mat'],'data','sr')
    end
end