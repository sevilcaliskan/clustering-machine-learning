im = imread('sample.jpg');
im2 = reshape(im,[size(im,1)*size(im,2) 3]);

%Split the image into smaller parts
rowNum = 250;
colNum = 400;
groups = cell(size(im,1)/rowNum, size(im,2)/colNum);
count = 1;
for j=0:(size(im,2)/colNum)-1
    for i = 0:(size(im,1)/rowNum)-1
        imPart = im(i*rowNum+1:(rowNum*(i+1)),j*colNum+1:(colNum*(j+1)),:);
        groups{i+1,j+1} = imPart;
    end
end
modifyreshape = @(x)reshape(x,[size(x,1)*size(x,2) 3]);
newgroups = cellfun(modifyreshape, groups,'uniformoutput',false);

%cluster smaller parts with knn
k = 100;
modifyknn = @(x)knn(x,k);
modifyagglo = @(x)agglo(x,k);
[meanVec, labels, ~] = cellfun(modifyknn, groups,'uniformoutput',false);
realLabels = labels;
means = cell2mat(reshape(meanVec,[size(meanVec,1)*size(meanVec,2) 1]));

%cluster with agglomerative
[meansaglo, labelsaglo] = agglo(means, 4);

%Label each pixel
kclusts = 1:k;
for j = 1:size(labels,2)
    for i = 1:size(labels,1)
        rowsC=(j-1)*size(labels,1)*k;
        labelpart = labelsaglo(rowsC+k*(i-1)+1:rowsC+k*i);
        for m = 1:k
            labels{i,j}(realLabels{i,j}==m)=labelpart(m);
        end
    end
end

% Shows the clustered image in Matlab and writes it into a bitmap file
cmp = cell2mat(labels);
M = meansaglo / 255;
clusteredImage = label2rgb(cmp, M);
figure, imshow(clusteredImage)
imwrite(clusteredImage,'output.bmp')


