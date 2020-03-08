%Last touched by KA 20200229
function [ dates,stimnumb3D, stimnumbClutter,stimnumbFT,subProws] = datesOrga( versionX )
if strcmp(versionX,'V1')
    dates=[20190628,20190708,20190709,20190710,20190711];
    subProws=4;
    stimnumb3D=680;
    stimnumbClutter=680;
    stimnumbFT=1350;%change if needed is numb of different stim*times played each stim, usually 20, for FT is 15
    %onehund=[1,2,10,11,13,14,15,16,17,20,21,29,30,31,32,33,38,39,...
        %40,41,42,43,44,45,46,47,48,49];%put in all stim that are 100ms long for the stim set
end

if strcmp(versionX,'V2')
    dates=[20190904,20190905,20190906,20190909,20190910,20190911];
    subProws=10;
    stimnumb3D=1320;
    stimnumbClutter=2100;
    stimnumbFT=1350;%change if needed is numb of different stim*times played each stim, usually 20, for FT is 15
end

if strcmp(versionX,'V3')
    dates=[20200217,20191105,20191106,20191107,20191108,20191111,20191112];
    subProws=10;
    stimnumb3D=880;
    stimnumbClutter=1400;
    stimnumbFT=1350;
end

