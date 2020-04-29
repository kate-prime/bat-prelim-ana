function [distance]=quickeuclid(data1,data2,dima,dimb)
%quick and dirty euclidean distance ana fr plots
%dima= variable dimension
%dimb= dimension to compare across
%remember to build another dim into distance to compare all piecewise

distance=NaN(size(data1));
distance=sqrt((data1-data2).^2)