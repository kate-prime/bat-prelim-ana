function latency2echoes(VersionX)

[dates] = datesOrga('V4')%VersionX);

load('clutter_v2.mat')
stimnames=fieldnames(stim);

stimulus = {'cube_00echo_10msdelay' 'cube_20echo_10msdelay'};

warning('if it is angies computer disk is W if it is kates it is Z, check path settings')

path='W:\Kate\KA001\Analyzed\';
for idate=1:size(dates,2)
    day=num2str(dates(idate))
    
    depths=dir([path,day,'\']);
    
   
    for idep=size(depths,2)
        depth=depths(idep).name
        if length(depth)<3 || strcmp(depth(1), 'C')
            continue
        end
        neurons=dir([path,day,depth,'*.mat']);
    figure
    hold on
    for iNeu=1:size(neurons, 2)
        if strcmp(neurons(iNeu),'psth')
            continue
        end
        load([path,day,neurons(iNeu)])
        for idxS=1:size(stimulus,2)
            idxstim=find(strcmp(stimulus{idxS},stimnames));
            assert(length(idxstim)==1)
            columns=[(idxstim-1)*20+1;idxstim*20]
            spkcol.(stimulus{idxS})=spike_data.spike_times(:,columns(1):columns(2));
            
            abcedges= -10 : 50;
              
            echo_resp=spkcol.(stimulus{idxS});  
            echo_resp(echo_resp<10)=NaN %this line is to filter the responses before the first echo
               echo_resp=echo_resp-10 %with this line I make the latency relative to the object echo
                abc = histcounts(echo_resp(:), abcedges);
                 xvalss=repelem(abcedges,2);
                yvalss=[0, repelem(abc,2), 0];
                plot(xvalss,yvalss,'LineWidth',1.5)
                xlim([0 40])
                xlabel('latency from first echo')
                ylabel('counts')
                object= strsplit(stimulus{idxS},'_');
                object=object(1:end-2);
                neuron=strrep(neurons(iNeu),'_',' ');
                title([neuron, '-', object])
                
        end
              
    end
                
        
    end
end

%%
asdf

for iNum = 1 : length(dates)
    
    StimMod= 'data_equalechoes';
    
    
    
    for idat = 1 : length(dates{iNum})
        files{iNum}{iCat} = load([StimMod '_' dates{iNum}{iCat} '.mat']);
        nNeuron{iNum}(iCat) = size(files{iNum}{iCat}.([StimMod,'01']).neuron, 1);
    end
    
    alltimes = [];
    for iCat = 1 : length(dates{iNum})
        for iField = 1 : length (stimulus{iNum})
            if strcmp('xx', stimulus{iNum}{iField})
                continue
            end
            fieldA = files{iNum}{iCat}.([StimMod stimulus{iNum}{iField}]);
            alltimes = [alltimes; fieldA.responsive_delays(:)];
        end
    end
    alltimes = setdiff(unique(alltimes),0);
    meas = {'spk_num','jitter'};
    N = 500;
    timerange = min(alltimes):0.01:max(alltimes);
    timeidxs = find(ismember(round(timerange*100), round(alltimes*100)));
    
    pictureall{iNum} = zeros([
        length(stimulus{iNum})
        length(timerange) + 2*N
        length(meas)
        length(dates{iNum})]');
    call_onsets_mat = load('times_pepairs01.mat', 'x');
    call_onset_seq01 = call_onsets_mat.x / 250;
    spikes_col = {};
    for iCat = 1:length(dates{iNum})
        for iNeuron = 1 : nNeuron{iNum}(iCat)
            filename = files{iNum}{iCat}.([StimMod,'01']).neuron(iNeuron,:);
            if strcmp('change', dates{iNum}{iCat}) && filename(2) == '_' %filenames are inconsistent with .neuron field
                filename = ['0' filename];
            end
            filename(filename == 0) = [];
            stub = ['01 Both echoes equal/', dates{iNum}{iCat}];
            if threeechoes
                stub = '02 Three echoes/change';
            end
            rawdata = load([ ...
                'Batch/', ...
                stub, ...
                filesep, ...
                filename]);
            p = zeros(length(stimulus{iNum}), length(alltimes), length(meas));
            fA = {};
            for iSec = 1 : length(stimulus{iNum}) % iterate over secondary delays
                second_accessor = (iSec-1)*20+1 : iSec*20;
                rawspikes = rawdata.trials_sorted(:, second_accessor);
                rawspikes = rawspikes(:);
                rawspikes(isnan(rawspikes)) = [];
                rawSpikesS{iSec}=rawspikes;
                spikes_col{iCat, iNeuron, iSec} = {};
                for iFirst = 1 : length(alltimes)
                    if ~strcmp('xx', stimulus{iNum}{iSec})
                        makeSafe = @(x,y)round(x * 100) == round(y * 100); % equality for floats is risky
                        fA{iSec} = ...
                            files{iNum}{iCat}.([StimMod stimulus{iNum}{iSec}]);
                        Nfirst = size(fA{iSec}.responsive_delays,2);
                        first_meta = fA{iSec}.responsive_delays(iNeuron, :);
                        safeIdx = find(makeSafe(alltimes(iFirst), first_meta));
                        if ~isempty(safeIdx) % neuron responds under given 1st delay
                            for iMeas = 1 : length(meas)
                                p(iSec, iFirst, iMeas) = ...
                                    fA{iSec}.(meas{iMeas})(iNeuron, safeIdx(end));
                                % 1.1ms is repeated twice, historically we have used the second (=last) one
                            end
                        end
                    end
                    first_meta_no2ndecho = ...
                        fA{1}.responsive_delays(iNeuron, :);
                    safeIdx_no2ndecho = ...
                        find(makeSafe(alltimes(iFirst),first_meta_no2ndecho));
                    if ~isempty(safeIdx_no2ndecho) % neuron responds to given 1st delay
                        onset = call_onset_seq01(31 - iFirst);
                        onset_next = call_onset_seq01(32 - iFirst);
                        filterspikes = @(x)x(x > onset & x < onset_next);
                        spikes_col{iCat, iNeuron, iSec}{end + 1} = ...
                            filterspikes(rawspikes) - onset - alltimes(iFirst);
                    end
                end
                abcedges= -20 : 120;
                abcdata = cell2mat(spikes_col{iCat, iNeuron, iSec}');
                abc{iNum}{iCat}{iNeuron, iSec} = histcounts(abcdata, abcedges);
            end
            
            center ...
                = sum(p(5,:, strcmp('spk_num',meas)).*alltimes')...
                / sum(p(5,:, strcmp('spk_num',meas)));
            [~, center_idx] = min(abs(timerange-center));
            center_idx = center_idx - ceil(length(timerange)/2);
            pInterp = zeros(length(stimulus{iNum}),length(timerange),length(meas));
            pInterp(:, timeidxs, :) = p;
            pShift = zeros(size(pInterp)+[0, 2*N, 0]);
            pShift(:,(N+1:end-N)-center_idx, :) = pInterp;
            data{iNum}{iCat}(iNeuron, :) = ...
                mean(pShift(:, round(size(pShift, 2) / 2) + (-130 : 130), 1), 2);
            data2{iNum}{iCat}(iNeuron) = ...
                std(repelem(pShift(4, :, iCat), round(10 * pShift(4, :, iCat))));
            pictureall{iNum}(:,:,:,iCat) = pictureall{iNum}(:,:,:,iCat) + pShift;
        end
        
    end
end
%% latency analysis
for iNum = 1 : length(dates)
    threeechoes = iNum==2;
    if threeechoes==true
        StimMod= 'data_3echoes';
    else
        StimMod= 'data_equalechoes';
    end
    for iCat = 1:length(dates{iNum})
        for iNeuron = 1 : nNeuron{iNum}(iCat)
            figure;
            hold on
            for iSec = 1 : length(stimulus{iNum})
                
               
                
                
                
            end
            filename = files{iNum}{iCat}.([StimMod,'01']).neuron(iNeuron,:);
            legend(stimulus{iNum},'FontSize',20)
            xlabel('latency from first echo','FontSize',20)
            ylabel('counts','FontSize',20)
            title(strrep(filename(1:end-4), '_', ' '));
            ylim([0,100]);
            xlim([-20,40]);
            
            saveas(gcf,['latencyhisto/',dates{iNum}{iCat},'/',filename(1:end-4), '.png']);
            close
        end
    end
end
%% combined latency analysis
for iNum = 1 : length(dates)
    for iCat=1 : length(dates{iNum})
        figure
        hold on
        for iSec=1 : length(stimulus{iNum})
            abccol=mean(cell2mat(abc{iNum}{iCat}(:, iSec)));
            plot(abcedges(1:end-1),abccol,'LineWidth', 1.5)
        end
        legend(stimulus{iNum},'FontSize', 20)
        xlabel('latency from first echo', 'FontSize', 20)
        ylabel('average spike counts', 'FontSize', 20)
        
        ylim([0, 50]);
        xlim([-10, 40]);
        title(dates{iCat}{iNum})
        saveas(gcf,['latencyhisto/', dates{iCat}{iNum}, '/popu', dates{iCat}{iNum}, '.png'])
    end
end
%% latency population mean from first echo
for iNum = 1 : length(dates)
    figure
    for iCat = 1 : length(dates{iNum})
        p4m = ...
            squeeze(cell2mat(reshape(abc{iNum}{iCat}, 1, 1, [], length(stimulus{iNum}))));
        maxsFound{iCat} = ...
            max((max(p4m) == p4m).*transpose(1:size(p4m, 1)));
        for iSec = 2 : length(stimulus{iNum})
            signrank(maxsFound{iCat}(:, :, 1), maxsFound{iCat}(:,:,iSec))
        end
        subplot(1, 2, iCat)
        %boxplot(squeeze(maxsFound{iCat}) - 20)
        errorbar( ...
            mean(squeeze(maxsFound{iCat})) - 20, ...
            std(squeeze(maxsFound{iCat})) / sqrt(nNeuron{iNum}(iCat)), ...
            'd','MarkerEdgeColor','none',...
            'MarkerFaceColor',[252/255, 3/255, 111/255],...
            'MarkerSize',10, ...
            'LineStyle','none')
        ylim([5,20])
        xticklabels({'0','2','4','6','10'})
        xlim ([0 length(stimulus{iNum}) + 1])
        
        ylabel('latency population mean from first echo','FontSize',20)
        xlabel('IEI','FontSize',20)
        title(dates{iNum}{iCat},'FontSize',20)
        set(gca,'FontSize',20)
        if iCat==2
            ylim([0,15])
        end
    end
end
if threeechoes==false
    ranksum(maxsFound{1}(:, :, 1), maxsFound{2}(:,:,1))
end

%% jitter
legendStore = {{'Population II', 'Population I'},{'three echoes'}};
for iNum = 1 : length(dates)
    figure;
    hold on
    for iCat = 1 : length(dates{iNum})
        %scatter(repelem(1:5,length(data{idx})),data{idx}(:));
        dataHere = data{iNum}{iCat}(:, ~strcmp('xx',stimulus{iNum}));
        errorbar(mean(dataHere),std(dataHere)/sqrt(nNeuron{iNum}(iCat)), ...
            '-s', ...
            'MarkerSize',5,...
            'linewidth',2)
        
    end
    xlabel ('IEI')
    ylabel ('jitter')
    xticklabels({'0','','2','','4','','6','','10'})
    xlim ([0.5 5.5])
    legend (legendStore{iNum})
end

