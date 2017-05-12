function [descriptor,grad] = getGradientDesc(img,cc)
    
[rows,cols,~] = size(img);
visual = 0;

if size(img,3) == 3
    img = rgb2gray(img);
end

img = double(img);

[kernel0,kernel45,kernel90,kernel135] = getGaussianKernel(1,5);

gradients = zeros(rows,cols,4);
gradients(:,:,1) = abs(imfilter(img,kernel0,'conv'));
gradients(:,:,2) = abs(imfilter(img,kernel45,'conv'));
gradients(:,:,3) = abs(imfilter(img,kernel90,'conv')); 
gradients(:,:,4) = abs(imfilter(img,kernel135,'conv'));

if visual
    gImg = gradients(:,:,1); figure; imshow(abs(gImg)/max(gImg(:))); title('0');
    gImg = gradients(:,:,2); figure; imshow(abs(gImg)/max(gImg(:))); title('45');
    gImg = gradients(:,:,3); figure; imshow(abs(gImg)/max(gImg(:))); title('90');
    gImg = gradients(:,:,4); figure; imshow(abs(gImg)/max(gImg(:))); title('135');
end

gradients = reshape(gradients,rows*cols,4);

descriptor = zeros(cc.NumObjects,4);
for i = 1:cc.NumObjects
    edgeDesc = gradients(cc.PixelIdxList{i},:);
    descriptor(i,:) = sum(edgeDesc,1);
end