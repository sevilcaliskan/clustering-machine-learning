function [meanVec, labels] = agglo(im,k)
labels = (1:size(im,1))';

while length(unique(labels))>k
    modifymean = @(x)mean(im(labels==x,:),1,'omitnan');
    lbl = unique(labels);
    meanVec = cell2mat(arrayfun(modifymean, lbl,'uniformoutput',false));
    dist = pdist(meanVec);
    [row, col] = find(squareform(dist)+eye(size(meanVec,1))*1000 == min(dist),1);
    newlabel = lbl(min(row,col));
    labels(labels==lbl(max(row,col)))= newlabel;
end

lbl = unique(labels);
modifymean = @(x)mean(im(labels==x,:),1,'omitnan');
meanVec = cell2mat(arrayfun(modifymean, lbl,'uniformoutput',false));
newlbls = (1:length(lbl))';

for i=1:length(lbl)
    labels(labels == lbl(i))=newlbls(i);
end
end
