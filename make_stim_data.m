function [stim_data,shapes] = make_stim_data()
load("W:\Kate\KA001\stimuli\clutter_v2.mat");
fieldN = fieldnames(stim);
fieldN_split =cellfun(@(x){strsplit(x,'_')}, fieldN);
for idx = 1 : length(fieldN_split)
    stim_data{idx,2} = strjoin(fieldN_split{idx}(1:end-2),'');
    stim_data{idx,3} = str2num(fieldN_split{idx}{end-1}(1:2));
    stim_data{idx,1} = str2num(fieldN_split{idx}{end}(1:2));
end
[shapes,~,ic] = unique(stim_data(:,2));
stim_data(:,4) = arrayfun(@(x){x},ic);
end

