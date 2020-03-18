function y = colorSortingBySimilarity(x)

Z = linkage(x);
figure;
dendrogram(Z, 0);
tempmap = gca();
sortingZ = str2num(tempmap.XTickLabel);
close
y = x(sortingZ,:);

end