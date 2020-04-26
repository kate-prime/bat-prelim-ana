function latency2echoes(VersionX)

[dates] = datesOrga('V4')%VersionX);

load('clutter_v2.mat')
stimnames=fieldnames(stim);

obstim={'cube' 'cyl' 'sphere' 'LD' 'SD' 'MP'}
stimulus = {'00echo_10msdelay' '20echo_10msdelay'};

warning('if it is angies computer disk is W if it is kates it is Z, check path settings')

path='W:\Kate\KA001\Analyzed\';


for idate=1:length(dates)
    day=num2str(dates(idate));
    
    depths=dir([path,day,'\']);
    
    
    for idep=1:size(depths,1)
        depth=depths(idep).name;
        if length(depth)<3 || strcmp(depth(1), 'C')
            continue
        end
        neurons=dir([path,day,'\',depth,'\*.mat']);
        
        for iNeu=1:length(neurons)
            spkcol=struct;
            for idx=1:length(stimulus)
                spkcol.(['s',stimulus{idx}])=[]
            end
            neuron=neurons(iNeu).name;
            if strcmp(neurons(iNeu),'psth')
                continue
            end
            
            load([path,day,'\',depth,'\',neuron])
            figure
            hold on
            
            for idxS=1:length(stimulus)
                for idxO=1:length(obstim)
                    stimstim= [obstim{idxO},'_',stimulus{idxS}]
                    idxstim=find(strcmp(stimstim,stimnames));
                    assert(length(idxstim)==1)
                    columns=[(idxstim-1)*20+1;idxstim*20];
                    
                    spkcol.(['s',stimulus{idxS}])=[spkcol.(['s',stimulus{idxS}]);spike_data.spike_times(:,columns(1):columns(2))];
                    
                end
                abcedges= -10 :1: 50;
                
                echo_resp=spkcol.(['s',stimulus{idxS}]);
                echo_resp(echo_resp<10)=NaN; %this line is to filter the responses before the first echo
                echo_resp=echo_resp-10; %with this line I make the latency relative to the object echo
                abc = histcounts(echo_resp(:), abcedges);
                xvalss=repelem(abcedges,2);
                yvalss=[0, repelem(abc,2), 0];
                plot(xvalss,yvalss,'LineWidth',1.5)
            end
            xlim([0 40])
            xlabel('latency from first echo')
            ylabel('counts')
            object= strsplit(stimulus{idxS},'_');
            object=object(1:end-2);
            neuronname=strrep(neuron,'_',' ');
            neuronname=neuronname(1:end-18)
            dep=strrep(depth,'_',' ')
            title([day,' ', dep,' ',neuronname])
            legend({'1 echo' '2 echo'})
            saveas(gcf,[path,'2ndecholat\',day,'_',depth,'_',neuronname,'.png'])
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




