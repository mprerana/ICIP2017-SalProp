function boxes = salprop(img,params)

%% Generate Edge Map of Image using OEF
edgeMap = edgeDetection(img,params);

%% Generate 7D Features for Each Edgelet
[features,emap] = generateFeatures(img,edgeMap,params);

%% Generate Edge Saliency Map
salmap = getEdgeSaliency(emap,features);

%% Generate Graph
edges = makeGraphMinDist(emap,params);

%% Predict edge map using CRF
%  Classify edges into Object and Non-Object Edges
predMap = getPrediction(features,edges,emap,params);

%% Generate Windows
windows = genWindows(salmap,params);

%% Score Windows
boxes = getScoreBoxes(predMap,windows,salmap,params);