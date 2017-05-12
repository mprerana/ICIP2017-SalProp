function edgeMap = edgeDetection(img,params)

%% Run Oriented Edge Forests
edgeMap = detect(img,params.modelOEF);
emapBin = edgeMap>params.edgeThreshold;
emapBin = bwareaopen(emapBin,params.minEdgeLength);
edgeMap = double(emapBin).*edgeMap;