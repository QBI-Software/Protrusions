% Cell Protrusions Analyser
% 
% Description: Developed for the detection and analysis of cell protrusions.
%   
% 
% Requires:
%   Matlab Image Processing Toolbox
%   Matlab Statistics Toolbox
%   Skeleton package from https://au.mathworks.com/matlabcentral/fileexchange/11123-better-skeletonization
%   - to install type: mex Skeleton/skeleton.cpp
% you may need to initialize the mex compiler in Matlab first with "mex -setup"
% 
% Code and further information is available at : 
%       https://github.com/QBI-Software
% Please see Instructions for Usage at :
%       https://github.com/QBI-Software
% 
% Developed by Liz Cooper-Williams, QBI (e.cooperwilliams@uq.edu.au)
% April 2017
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ProtrusionApp()

  clear
  close all
  format compact
  feature('jit',0)
  feature('accel',0)
  %add paths
  addpath(pwd)
  subd = fullfile(pwd, 'methods');
  addpath(subd)
  subd = fullfile(pwd, 'Skeleton');
  addpath(subd)
  %Run APP
  protrusion()
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end