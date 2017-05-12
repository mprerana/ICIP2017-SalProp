%% Initialization for SalProp

function params = initialize()
    
    %% Loading Parameters
    params = loadparams;
    save([params.matpyfiles.rootDir,'params.mat'],'params');

    %% Loading OEF Model into Workspace
    model = load(params.modelFileOEF);
    model = model.model;
    model.opts.nms       = 1;
    model.opts.nThreads  = 8;
    model.opts.calibrate = true;
    model.opts.collapse  = true;
    params.modelOEF = model;