
xlookup = 20:10:80;
ylookup = 20:5:90;
versionselector = [3,4];
trials_sorted_sorted = {};
for i_v= 1 : length(versionselector)
    i_v
    liste = [];
    days = dir(['G:\Angie data\IC Angie\units\V' num2str(versionselector(i_v)) '\201*']);
    
    for i_day = 1 : length(days)
        fts = dir(['G:\Angie data\IC Angie\', days(i_day).name, '\Matfile\FT_*']);
        for i_fts = 1 : length(fts)
            
            Ttimes = dir([fts(i_fts).folder '\' fts(i_fts).name, '\times_*']);
            for i_times = 1 : length(Ttimes)
                timesfile=load([Ttimes(i_times).folder '\' Ttimes(i_times).name]);
                for i_clus = reshape(unique(timesfile.cluster_class(:,1)),1,[])
                    if ~strcmp('G:\Angie data\IC Angie\20180411\Matfile\FT_1430\times_Chn8.mat',[Ttimes(i_times).folder '\' Ttimes(i_times).name])
                        
                        trials_sorted_sorted(end+1,:) = {freqtunnin_2mainAnalysis(...
                            [Ttimes(i_times).folder '\'], ...
                            Ttimes(i_times).name,...
                            i_clus), [Ttimes(i_times).folder '\' Ttimes(i_times).name]};
                    end
                end
            end
        end
    end
end
%%
limits = [1,133,213,457];
for i_plot = 1%:3
    figure
    mm=[];
    for idx = limits(i_plot) : limits(i_plot+1)-1
        t = trials_sorted_sorted{idx,1};
        t=t(:,t(2,:)==70);
        [~,u] = max(t(3,:));
        sps = strsplit(trials_sorted_sorted{idx,2},'\');
        if t(3,u)>0.3 && t(3,u)<3
            mm(end+1,:) = [t(1,u), str2num(sps{6}(4:end)),t(3,u)];
        end
    end
    scatter(mm(:,1),mm(:,2),[24],'filled')
    xlabel('Best frequency (kHz)','FontSize',15)
    ylabel('Depth (\mum)','FontSize',15)
    
    hold on
    set(gcf, 'color', 'white','Position', [100   100   350   450]);
    set(gca,'FontSize',15,'LineWidth',1.5,'Tickdir',' out');
    xlim([10 100])
    title('Tonotopy','Fontsize',20)
    disp('Data for first second of statistic stored in SECONDSHEET')
    SECONDSHEET = [mm(:,1),mm(:,2)];
    %h = colorbar;
    %ylabel(h, 'Depth (\mum)','FontSize',15)
    
    axesLimits1 = xlim;
    xplot1 = linspace(axesLimits1(1), axesLimits1(2));
    
    % Find coefficients for polynomial (order = 1)
    fitResults1 = polyfit(mm(:,1),mm(:,2),1);
    % Evaluate polynomial
    yplot1 = polyval(fitResults1,xplot1);
    % Plot the fit
    fitLine1 = plot(xplot1,yplot1,'LineWidth',2, 'Color',[0.929 0.694 0.125]);
end
%%
xplot=zeros(1000,1600);
dd=80;
[rr cc] = meshgrid(1:dd*2);
C = sqrt((rr-dd).^2+(cc-dd).^2)<=dd;
for idx = 1 : size(mm,1)
    xplot1 = xplot(mm(idx,1)*10-dd:mm(idx,1)*10+dd-1,mm(idx,2)-dd:mm(idx,2)+dd-1);
    xplot1(C) = xplot1(C)+1;
    xplot(mm(idx,1)*10-dd:mm(idx,1)*10+dd-1,mm(idx,2)-dd:mm(idx,2)+dd-1)=xplot1;
end

%%
% for idx = 1%:length(liste)
%     %figure
%     %hold on
%     spl = strsplit(liste(idx).name,'_');
%     trials_sorted_sorted = freqtunnin_2mainAnalysisAnalysis(...
%         ['G:\Angie data\IC Angie\20180411\Matfile\FT_', spl{2}, '\'], ...
%         ['times_' spl{3}],...
%         str2num(spl{5}));
%     for idx2 = 1 : 7
%         [~,mm(idx,idx2)] = max(trials_sorted_sorted(3,(idx2-1)*15+1:idx2*15));
%         %plot(ylookup, trials_sorted_sorted(3,(idx2-1)*15+1:idx2*15),'DisplayName',num2str(xlookup(idx2)))
%     end
%
% end
% legend;
% xlabel('frequency [Hz]');
% ylabel('spike rate');

% plot(xlookup,ylookup(mm(1,:)))
% xlabel('loudness [db]')
% ylabel('prefered frequency [Hz]')
startat=133;
[C,~,ic]=unique(trials_sorted_sorted(startat:212,2));
for idx =[1,11,28] %1 : length(C)
    titlestring = '';
    
    for idx3=1: length(activeunit_save)
        assert(strcmp(activeunit_save{idx3}(end-7),'_'))
        CC=strsplit(C{idx},filesep);
        if strcmp(activeunit_save{idx3}(2:end-8),[CC{end-3},CC{end-1}(3:end),CC{end}(6:end-4)])
            if ismember(activeunit_save{idx3},ECHOpref)
                titlestring = [titlestring 'e'];
            else
                if ismember(activeunit_save{idx3},FMBpref)
                    titlestring = [titlestring 'f'];
                else
                    titlestring = [titlestring 'o'];
                end
            end
        end
    end
    if (isempty(titlestring))
        continue;
    end
    figure('Position',[184   278   931   280]);
    
    idx_here = find(ic==idx);
    for idx2=1:length(idx_here)+1
        
        subplot(1,4,idx2);
        h=imagesc(flipud(reshape(trials_sorted_sorted{idx_here(min(idx2,length(idx_here)))+startat-1}(3,:),15,7)')*20,[0,40]);
        xticks(1:4:15)
        xticklabels(arrayfun(@(x){num2str(x)},ylookup))
        xlabel('Frequency (kHz)')
        
        yticklabels(arrayfun(@(x){num2str(x)},fliplr(xlookup)))
        ylabel('Volume (dB)')
        
        set(gca,'FontSize',15,'LineWidth',1.5,'Tickdir','out');
        if idx2==1
            
            %title([CC{end-1}(4:end),CC{end}(7:end-4),' ', titlestring]);
            if idx==1
                title('1050 \mum                        ','FontSize',20,'HorizontalAlignment','center')
            end
            if idx==11
                title('150 \mum                         ','FontSize',20,'HorizontalAlignment','center')
            end
            if idx==28
                title('800 \mum                         ','FontSize',20,'HorizontalAlignment','center')
            end
            
        end
        if idx2==length(idx_here)+1
            axis off
            
            set(h,'visible','off')
            hh = colorbar;
            ylabel(hh, 'Sipke number','FontSize',15)
        end
        
        
    end
    %saveas(gcf,[num2str(idx),'.pdf']);
end
