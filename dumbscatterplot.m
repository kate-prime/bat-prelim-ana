figure; hold on
for i=1:length(friends)
    num=zeros(size(friends{1,i}));
    num=num+i;
    scatter(num,friends{1,i})
end