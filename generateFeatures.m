%% Function to generate Features for CRF
function [features,emap] = generateFeatures(img,emap,params)

%% Get MatPy file paths
matpy = params.matpyfiles;

%% Extract Connected Components
cc = bwconncomp(emap);

%% Compute DoG-LoG Texture Features
imwrite(img,matpy.imgFile);
[~,~] = system(['python ', params.python.clrTxtMapFile]);
clrTextMap = load(matpy.colorTextureFile);
clrTextMap = clrTextMap.feat;
[textFeat, emap] = computeFeatures(emap,cc,clrTextMap,params);
textFeat = [textFeat(:,1),textFeat(:,3),textFeat(:,2),textFeat(:,4)];
cc = bwconncomp(emap);

%% Get Gradient Descriptors
gradDesc = getGradientDesc(img,cc);
gradDesc = sqrt(sum(gradDesc.^2,2));

%% Compute Local Ternary Pattern Features
ltp = computeLTP(rgb2gray(img),cc,5);

%% Compute Maximum Magnitude of each edgelet
emag = getMaxMagnitude(emap,cc);

%% Create Feature Matrix
features = [gradDesc,textFeat,ltp,emag];