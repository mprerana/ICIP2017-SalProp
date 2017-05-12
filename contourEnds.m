%emap should contain only 1 contour
function ends = contourEnds(emap)

[rows,~] = size(emap);
ends = bwmorph(emap,'endpoints');
idx = find(ends);
d = [-rows-1,-rows,-rows+1,-1,1,rows-1,rows,rows+1];
vals = emap(bsxfun(@plus,idx,d));
numNeighbor = sum(vals,2);
ends = idx(numNeighbor<=2);
v = vals(numNeighbor<=2,:);

condition = ((v(:,1)|v(:,2)|v(:,3)) & (v(:,6)|v(:,7)|v(:,8))) | ((v(:,1)|v(:,4)|v(:,6)) & (v(:,3)|v(:,5)|v(:,8)));

ends = ends(~condition);