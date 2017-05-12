function windows = genWindows(salmap,params) %#ok<*INUSL>

%% Extract paths to python interface
windowsFile = params.matpyfiles.windowsFile;
salmapFile  = params.matpyfiles.salmapFile;

%% Send file to python interface
save(salmapFile,'salmap')

%% Run python script to generate windows
[~,~] = system(['python ',params.python.genWindows]);

%% Retrieve windows file from python interface
windows = load(windowsFile);
windows = windows.windows;