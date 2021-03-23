objects = {'cylE', 'cubeE','SDE','LDE','MPE'};
raw=struct();
plonkos=struct();
for idx = 1 : length(objects)
    raw.(objects{idx})=eval(objects{idx});
    
    plonkos.(objects{idx})=[];
    for cylidx=0:5:120
        plonkos.(objects{idx})(end+1,1)=mean(raw.(objects{idx})(xx>cylidx & xx<=cylidx+5));
    end
end
objvariance=var(struct2array(plonkos),0,2)


Nhist=histogram(BFcolabs(:,1),[20:5:90])
NuronNum=Nhist.Values
scatter(objvariance(5:18),NuronNum,'filled','MarkerEdgeColor','k', 'MarkerFaceColor','m')
xlabel('variance in power spectrum in 5kHz bins')
ylabel ('number of neurons with BF in each 5kHz bin')