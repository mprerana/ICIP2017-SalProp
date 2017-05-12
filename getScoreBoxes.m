function boxes = getScoreBoxes(emap,windows,salmap,params) %#ok<*INUSL>

%% Extract paths to python interface
windowsFile  = params.matpyfiles.windowsFile;
emapClusFile = params.matpyfiles.emapClusFile;
scoreFile    = params.matpyfiles.scoreFile;
connCompFile = params.matpyfiles.connCompFile;
salmapFile   = params.matpyfiles.salmapFile;

%% Assign labels to each edgelet
emapClus = bwlabel(emap,8);
connComp = bwconncomp(emapClus,8); %#ok<NASGU>

%% Send files to python interface
save(salmapFile,'salmap');
save(connCompFile,'connComp');
save(emapClusFile,'emapClus');
save(windowsFile,'windows');

%% Run python script to score windows
[~,~] = system(['python ',params.python.scoreFile]);
boxes = load(scoreFile);
boxes = boxes.scores;

%% Apply NMS if required
count = params.boxes.count;
if params.boxes.NMSapply
    nmsThresh = params.boxes.NMSthreshold;
    boxes = nms_pascal(boxes,nmsThresh,count);
end

%% Extract top boxes
numBoxes = size(boxes,1);
idx = min(numBoxes,count);
boxes = boxes(1:idx,:);