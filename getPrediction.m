function predEmap = getPrediction(feat,edges,emap,params) %#ok<*INUSL>

%% Extract paths and image size
[rows,cols] = size(emap);
featFilePath     = params.matpyfiles.featureFile;
edgesFilePath    = params.matpyfiles.edgesFile;

%% Save files to send to python interface
save(featFilePath, 'feat');
save(edgesFilePath, 'edges');

%% Run Prediction script
[~,~] = system(['python ', params.python.predictFile]);

%% Retrieve prediction from python interface
prediction = load(params.matpyfiles.predictFile);
prediction = prediction.prediction;

%% Generate predicted edge map
predEmap = zeros([rows,cols]);
emapClus = bwlabel(emap);
for i = 1:max(emapClus(:))
   predEmap(emapClus==i) = prediction(i);
end

predEmap = predEmap.*emap;