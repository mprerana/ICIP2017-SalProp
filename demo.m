%% Demo of SalProp

%% Load demo image
demoImg = imread('demoImg.jpg');

%% Load parameters
params  = initialize;

%% Run SalProp
boxes = salprop(demoImg,params);

%% Run Evaluation
try
    gt = load('ground_truth.mat');
    % gt = gtBoxes;
    gt = gt.gtBoxes;
    [box,iou] = bestBoxes(boxes,gt);
    
    %% Visualize Evaluation
    imshow(demoImg); title('blue - SalProp Boxes | green - Ground Truth Boxes');
    numGtBoxes = size(gt,1);
    drawBoxes([gt,ones(numGtBoxes,1)],[0,1,0]);
    drawBoxes([boxes(box,1:4),ones(numGtBoxes,1)],[0,0,1]);

catch
    disp('No Ground Truth Available. Top 1000 boxes returned in variable named "boxes".')
end