function [edges] = makeGraphMinDist(emap,params)

%% Check Inputs
if nargin<2
    thresh=10;
else
    thresh = params.graphDistOffset;
end

%% Assign Labels and Generate Sparse Map for fast computation
emap = emap>0;
[rows,cols] = size(emap);
emapClus = sparse(bwlabel(emap,8));
cc = bwconncomp(emap,8);
numComp = cc.NumObjects;

%% Generate Edges for Graph
if (numComp==1)
    edges = [1,1];
    return
end

edges = false(numComp);
for i = 1:numComp
    [r,c] = ind2sub([rows,cols],cc.PixelIdxList{i});
    currLabel = emapClus(r(1),c(1));
    r = sort(r); rmin = max(1,r(1)-thresh); rmax = min(rows,r(end)+thresh);
    c = sort(c); cmin = max(1,c(1)-thresh); cmax = min(cols,c(end)+thresh);
    box = emapClus(rmin:rmax,cmin:cmax);
    labels = unique(box((box>0) & (box~=currLabel)));
    while isempty(labels)
        rmin = max(1,rmin-2); rmax = min(rows,rmax+2);
        cmin = max(1,cmin-2); cmax = min(cols,cmax+2);
        box = emapClus(rmin:rmax,cmin:cmax);
        labels = unique(box((box>0) & (box~=currLabel)));
        if rmin==1 && rmax==rows && cmax==cols && cmin==1
            break;
        end
    end
    edges(i,labels) = true;
end
edgesMat = triu((edges+edges')>0);
[node1,node2] = ind2sub([numComp,numComp],find(edgesMat));
edges = [node1,node2];