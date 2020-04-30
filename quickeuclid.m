function [distance]=quickeuclid(data,dima,dimb)
%quick and dirty euclidean distance ana fr plots
%dima= variable dimension
%dimb= dimension to compare across
%remember to build another dim into distance to compare all piecewise
distance=NaN(size(data,dima),size(data,dimb),size(data,dima));
for i=1:size(data,dima)
    base=data(i,:);
    for j=1:size(data,dima)
        comp=data(j,:);
        distance(j,:,i)=sqrt((base-comp).^2);
    end
end