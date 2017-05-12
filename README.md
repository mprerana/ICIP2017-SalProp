# ICIP2017-SalProp

# SalProp : Object Detection Framework

This repository contains the source code for the method described in

<CITE PAPER>

The system is implemented in MATLAB and Python.

## Installation
To use this software, you need to have the following in the salprop-v1.0 directory:

1) Piotr Dollar's very useful [Image & Video Matlab Toolbox]
   https://pdollar.github.io/toolbox/
2) Oriented Edge Forests [oef-master]
   https://github.com/samhallman/oef

## Running Demo
1) Add the directory "salprop-v1.0" to path

2) Run the demo file

## Running the Demo file for any image
1) Place the required image file in the "salprop-v1.0/Evaluation Tools" folder by the name "demoImg.jpg"

2) Place a .mat file containing the ground truth object proposals for the image in the same folder by the name "ground_truth.mat"
    - Store it in a variable named "gtBoxes" in the .mat file
    - Format of ground truth boxes : [cmin,rmin,cmax,rmax]
    NOTE: If a ground truth file is not provided, top 1000 proposals are returned in a variable named "boxes"

3) Add the directory "salprop-v1.0" to path

4) Run the demo file

## Usage of Salprop
1) Add the directory salprop-v1.0 to path

2) Change the paths in the following files to the path of the salprop-v1.0 directory
   for eg. /home/username/Desktop/salprop-v1.0/
    - File 1: loadparams - line 5

3) Change the paths in the following files to the path of the matpy directory
   for eg. /home/username/Desktop/salprop-v1.0/matpy/
    - File 1: Python Scripts/computeTextureMap.py - line 7
    - File 2: Pyhton Scripts/genWindows.py        - line 9
    - File 3: Python Scripts/predict.py           - line 8
    - File 4: Pyhton Scripts/score.py             - line 151

4) Load parameters by running the initialize script as follows
    params = initialize;

5) Run SalProp on an image (img) using the following syntax:
    boxes = salprop(img,params)

NOTE:
Top 1000 boxes are returned
Tune the tightness parameter in loadparams (params.boxes.tightness) to tune
the quality of the boxes. Value remains between 0 and 1. Higher the value,
tighter would be the box. As value increases, chances of finding the object
reduces. For best results, keep the value as 0.5, 0.6 or 0.7.
