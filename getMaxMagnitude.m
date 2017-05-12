function emag = getMaxMagnitude(emap,cc)

pixIdx = cc.PixelIdxList;
pixIdx = cell2array(pixIdx,0);
pixIdx = reshape(pixIdx,size(pixIdx,1),cc.NumObjects);

pixIdx(pixIdx==0) = 1;

mags = emap(pixIdx);
emag = (max(mags,[],1))';