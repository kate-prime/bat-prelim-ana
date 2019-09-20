function [ dates, stimnumbClutter,stimnumbFT ] = datesOrga( versionX )
if strcmp(versionX,'V1')
    dates=[20190628,20190708,20190709,20190710,20190711];
    stimnumbClutter=680;
    stimnumbFT=1350;%change if needed is numb of different stim*times played each stim, usually 20, for FT is 15
    %onehund=[1,2,10,11,13,14,15,16,17,20,21,29,30,31,32,33,38,39,...
        %40,41,42,43,44,45,46,47,48,49];%put in all stim that are 100ms long for the stim set
end
if strcmp(versionX,'V2')
    dates=[20190904,20190905,20190906,20190909,20190910,20190911];
    stimnumbClutter=2100;
    stimnumbFT=1350;%change if needed is numb of different stim*times played each stim, usually 20, for FT is 15
end
end

