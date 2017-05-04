% Cell Protrusions Analyser
% 
% Description: Developed for the detection and analysis of cell protrusions.
%   
% 
% Requires:
%   Matlab Image Processing Toolbox
%   Matlab Statistics Toolbox
%   Skeleton package
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