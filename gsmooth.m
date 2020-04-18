
function [gdata,mdata,dev]=gsmooth(data,sr,ms)
%preps gaussian smoothed firing rate psths
%data is binned spikes in a mxn matrix where m is length of stim window and
%n is stim repetitions
%sr is sample rate
%ms is width of gaussian window in ms
%KA 2020 with acknowledgments to GM

%% make a  curve (thanks G. Marsat)
hh=(ms*sr/1000)*4;
xx=1:hh;
BB=hh/2;
CC=BB./4;

gg=1*exp(-((xx-BB)/CC).^2);

gg=(gg./sum(gg))';% scales the curve

%% convolve curve with bins and scale to firing rate in Hz (also thanks to G. Marsat)

gdata=zeros(size(data));
for i=1:size(data,1)
    dd=conv(data(i,:),gg);
    trop=round(length(gg)/2);
    y=dd(trop:end-trop+1);%truncates to the relevant half after convolution
    y=y.*sr;
    if length(y)>length(data)
        y=y(1:length(data));
    end
    gdata(i,:)=y;
end

%% average the firing rates and get std

mdata=mean(gdata,1);
dev=std(gdata,0,1);

