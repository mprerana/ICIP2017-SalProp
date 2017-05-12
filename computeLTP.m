function ltpFeat = computeLTP(img,cc,thresh)

if (nargin<3), thresh=5; end
if (size(img,3)~=1), error('Please provide only grayscale images'); end

img = double(img);
[rows,cols,~] = size(img);
imgBool = true(rows,cols);
imgBool(1,:) = false; imgBool(end,:) = false;
imgBool(:,1) = false; imgBool(:,end) = false;

idxs = find(imgBool);
d = [-rows-1,-1,rows-1,rows,rows+1,1,-rows+1,-rows];
nhood = bsxfun(@plus,idxs,d);

cenVals   = img(idxs);
nhoodVals = img(nhood);

cenVals = repmat(cenVals,1,8);

compUpper = (nhoodVals>=cenVals+thresh);
compLower = (nhoodVals<=cenVals-thresh);

factors = [128,64,32,16,8,4,2,1];
ltpUpper = bsxfun(@times,compUpper,factors);
ltpLower = bsxfun(@times,compLower,factors);

upper = double(imgBool);
upper(idxs) = sum(ltpUpper,2);

lower = double(imgBool);
lower(idxs) = sum(ltpLower,2);

ltp = (upper+lower)/2;

kernel = fspecial('average',[3,3]);
varImg = imfilter(ltp.^2,kernel,'conv')-imfilter(ltp,kernel,'conv').^2;

ltpFeat = zeros(cc.NumObjects,1);
for i = 1:cc.NumObjects
    ltpFeat(i,1) = mean(varImg(cc.PixelIdxList{i}));
end