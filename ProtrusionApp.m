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
%       https://github.com/QBI-Software/Protrusions
% Please see Instructions for Usage at :
%       https://github.com/QBI-Software/Protrusions
%
% Developer: Liz Cooper-Williams,e.cooperwilliams@uq.edu.au
% 
%    Licensed under the Apache License, Version 2.0 (the "License");
%    you may not use this file except in compliance with the License.
%    You may obtain a copy of the License at
% 
%        http://www.apache.org/licenses/LICENSE-2.0
% 
%    Unless required by applicable law or agreed to in writing, software
%    distributed under the License is distributed on an "AS IS" BASIS,
%    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%    See the License for the specific language governing permissions and
%    limitations under the License.
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