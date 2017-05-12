function params = loadparams()

params = struct;

params.rootDir           = '/home/dell/Desktop/sarvaswa/objectness-release-v2.2/Trial_Pascal/testSet/exp1/salprop-v1.0/';
params.modelFileCRF      = [params.rootDir,'Model Files/edgeDescText7D_GCRF'];  % Set Directory for CRF Model
params.modelFileOEF      = [params.rootDir,'Model Files/modelCvpr.mat'];
params.edgeThreshold     = 40;  % Set value to threshold over edge magnitudes (0-255)
params.minEdgeLength     = 15;  % Set minimum edge length
params.sigma             = 0.5; % Set base scale for Texture filter
params.strelRadius       = 5;   % Set radius for structuring element
params.graphDistOffset   = 10;  % Set maximum edge distance for graph generation

% Set directories for matpy files
params.matpyfiles.rootDir           = [params.rootDir,'matpy/'];
params.matpyfiles.imgFile           = [params.matpyfiles.rootDir,'imgFile.png'];
params.matpyfiles.colorTextureFile  = [params.matpyfiles.rootDir,'colorTextureFile.mat'];
params.matpyfiles.emapClusFile      = [params.matpyfiles.rootDir,'emapClusFile.mat'];
params.matpyfiles.featureFile       = [params.matpyfiles.rootDir,'featureFile.mat'];
params.matpyfiles.edgesFile         = [params.matpyfiles.rootDir,'edgesFile.mat'];
params.matpyfiles.predictFile       = [params.matpyfiles.rootDir,'predictFile.mat'];
params.matpyfiles.scoreFile         = [params.matpyfiles.rootDir,'scoreFile.mat'];
params.matpyfiles.windowsFile       = [params.matpyfiles.rootDir,'windowsFile.mat'];
params.matpyfiles.connCompFile      = [params.matpyfiles.rootDir,'connCompFile.mat'];
params.matpyfiles.salmapFile        = [params.matpyfiles.rootDir,'salmapFile.mat'];

% Set parameters for window generation
params.windows.iou      = 0.65; % iou E [0,1)
params.windows.scale    = (0.5:1:95)/100;
params.windows.aspRatio = [1/3,1/2,1,2,3];

% Set paths for python scripts
params.python.root          = [params.rootDir,'Python\ Scripts/'];
params.python.clrTxtMapFile = [params.python.root,'computeTextureMap.py'];
params.python.predictFile   = [params.python.root,'predict.py'];
params.python.scoreFile     = [params.python.root,'score.py'];
params.python.genWindows    = [params.python.root,'genWindows.py'];

% Set Box Parameters
params.boxes.NMSapply     = 1;
params.boxes.tightness    = 0.7;
params.boxes.NMSthreshold = params.boxes.tightness;
params.boxes.count        = 1000;