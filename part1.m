% Reads sample.jpg into an im matrix, whose dimensions are N, M, and 3
im = imread('sample.jpg');
imblack = imread('black.png');
% Reshapes the 3D im matrix into a 2D matrix, called im2, whose
% dimensions are NxM and 3. In this 2D matrix, each row corresponds to
% a pixel, and the columns correspond to red, green, and blue channels
% in the RGB color space, respectively
kValues = 1:20;
kValues = 2;
kValues = [2,4,8,16,32];
cVec = cell(1,length(kValues));
cmap = cell(1,length(kValues));
sumOfSquares = zeros(1,length(kValues));
for i=1:length(kValues)
    [cVec{1,i}, cmap{1,i}, sumOfSquares(1,i)] = knn(im,kValues(i));
end
% Suppose that your program outputs matrix V, whose dimensions are k
% and 3, and vector cmap, whose dimension is NxM. Also suppose that
% your labels are in between 1 and k. Then you may use the following
% Matlab codes to produce the clustered image
for i=1:length(kValues)
    cmap2 = reshape(cmap{1,i},[size(im,1) size(im,2)]);
    M = cVec{1,i} / 255;
    clusteredImage = label2rgb(cmap2, M);
    % Shows the clustered image in Matlab and writes it into a bitmap file
    figure, imshow(clusteredImage)
    imwrite(clusteredImage,'output.bmp')
end

%%knn


