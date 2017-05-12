%% Function to generate Edge Saliency Map
function [salmap] = getEdgeSaliency(emap,features)

%% Initialize saliency map
salmap = zeros(size(emap));
cc = bwconncomp(emap);

%% Extract cues for prior computation
f = [features(:,1)/1000,features(:,6)];
dist = sqrt(sum(f.^2,2));
emag = features(:,7);

%% Compute Saliency Prior of each edge group
saliency = dist.*emag;
saliency = saliency/max(saliency(:));

%% Likelihood Computation
threshMag  = 0.8*max(emag(:));
bg_indices = find(emag<threshMag);
s_indices  = find(emag>=threshMag);
numBg  = length(bg_indices);
numSal = length(s_indices);

%% Make Salient and Background Histograms
bgPoints = [];
salPoints = [];
maxMag = max(emap(:));
for i = 1:max(numSal,numBg)
    if i<=numBg
        points = emap(cc.PixelIdxList{bg_indices(i)});
        bgPoints = [bgPoints,points(:)'];
    end
    if i<=numSal
        points = emap(cc.PixelIdxList{s_indices(i)});
        salPoints = [salPoints,points(:)'];
    end
end
histEdges = linspace(0,maxMag,11);
salHist = histcounts(salPoints,histEdges,'Normalization','probability');
bgHist  = histcounts(bgPoints,histEdges,'Normalization','probability');

%% Generate Edge Saliency Map
for i = 1:cc.NumObjects
    mag = emag(i);
    histIdx = ceil(((9/maxMag)*mag)+1); %Quantization into bins
    term1 = saliency(i)*salHist(histIdx);
    term2 = (1-saliency(i))*bgHist(histIdx);
    val = term1/(term1 + term2);
    if isnan(val), val=0; end
    salmap(cc.PixelIdxList{i}) = val;
end

