function [feature,emap] = computeFeatures(emap,cc,feat,params)

if nargin<2
    error('computeFeatForCRF requires 2 inputs');
end

%% Get Edge Map Size and Connected Components
emapOrig = emap;
emap = emap>0;
[rows,cols] = size(emap);
numComps = cc.NumObjects;

%% Convert 3D Feature to 2D
featureLen = size(feat,3);
feat = reshape(feat,rows*cols,featureLen);

%% Initialize storage variables
zeromap = false([rows,cols]);
edgeRemove = false(numComps,1);
feature = [];

%% Loop over all components to compute features
for i = 1:numComps
    
    % Get Pixel Indexes of components
    pixId = cc.PixelIdxList{i};
    contour = zeromap;
    
    % Dilate Component
    disk = strel('disk',params.strelRadius,0);
    contour(pixId) = true;
    ends = contourEnds(contour);
    contour = imdilate(contour,disk);
    
    % Remove end-point dilation
    if ~isempty(ends)
        endsmap = zeromap;
        endsmap(ends) = true;
        contour(imdilate(endsmap,disk)) = false;
    end
    contour(pixId) = 0;
    cComps = bwconncomp(contour,4);
    
    % Get points on two sides of the contour
    if cComps.NumObjects > 1
        if cComps.NumObjects>2
            area = zeros(cComps.NumObjects,2);
            for j = 1:cComps.NumObjects
                area(j,:) = [j,length(cComps.PixelIdxList{j})];
            end
            area = flipud(sortrows(area,2));
            a1 = cComps.PixelIdxList{area(1,1)};
            a2 = cComps.PixelIdxList{area(2,1)};
            cComps.PixelIdxList{1} = a1;
            cComps.PixelIdxList{2} = a2;
        end
        A1 = cComps.PixelIdxList{1};
        A2 = cComps.PixelIdxList{2};
        area1 = numel(A1);
        area2 = numel(A2);
        A1 = datasample(A1,ceil(area1/2),'Replace',false);
        A2 = datasample(A2,ceil(area2/2),'Replace',false);
        f1 = double(feat(A1,:)); f2 = double(feat(A2,:));
        if mean(var(f1,[],1))<mean(var(f2,[],1))
            feature = [feature;[mean(f1,1),mean(f2,1)]];
        else
            feature = [feature;[mean(f2,1),mean(f1,1)]];
        end
    else
        edgeRemove(i) = true;
        emap(pixId) = 0;
    end
end

emap = emapOrig.*double(emap);