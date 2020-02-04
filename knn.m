function [cVec, cmp, sumOfSquares] = knn(im,k)
%KNN This function takes an image matrix (RGB) and find k number of
%clusters and returns a center matrix and label matrix
image = reshape(im,[size(im,1)*size(im,2) 3]);
rowNum = size(image,1);
colNum = size(image,2);
cVecBefore = rand(k, colNum);
%Initialize centers randomly

cVec = zeros(k, colNum);
count=0;
while count < k
    v = image(ceil(rand*rowNum),:);
    if sum(ismember(cVec,v,'rows'))==0
        count = count +1;
        cVec(count,:) = v;
    end
end

while ~isequal(cVec, cVecBefore)
    %calculate distance
    dist = pdist2(image, cVec);
    [~,idx] = min(dist,[],2);
    cVecBefore = cVec;
    %Find new centers
    for i=1:k
        cVec(i,:) = mean(image(idx==i,:),1);
    end
end
cmp = reshape(idx,[size(im,1) size(im,2)]);
dist = pdist2(image, cVec);
[~,idx] = min(dist,[],2);
sumOfSquares = 0;
for i=1:k
    sumOfSquares = sumOfSquares + sum(dist(idx==i,i), 'omitnan');
end
%figure
%silhouette(image, idx);

end
