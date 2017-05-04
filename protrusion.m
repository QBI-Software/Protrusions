function varargout = protrusion(varargin)
% PROTRUSION MATLAB code for protrusion.fig
%      PROTRUSION, by itself, creates a new PROTRUSION or raises the existing
%      singleton*.
%
%      H = PROTRUSION returns the handle to a new PROTRUSION or the handle to
%      the existing singleton*.
%
%      PROTRUSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROTRUSION.M with the given input arguments.
%
%      PROTRUSION('Property','Value',...) creates a new PROTRUSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before protrusion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to protrusion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help protrusion

% Last Modified by GUIDE v2.5 04-May-2017 09:41:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @protrusion_OpeningFcn, ...
                   'gui_OutputFcn',  @protrusion_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before protrusion is made visible.
function protrusion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to protrusion (see VARARGIN)

% Choose default command line output for protrusion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using protrusion.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% UIWAIT makes protrusion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = protrusion_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on button press in checkboxParallel.
function checkboxParallel_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxParallel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxParallel


% --- Executes on button press in btnRun.
function btnRun_Callback(hObject, eventdata, handles)
% hObject    handle to btnRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hB = findobj('Tag', 'menu_loadImage');
hData = hB.UserData;
I = hData.img;
if (isempty(I))
    updateStatus(handles,'Error: Image not loaded');
    return
end
updateStatus(handles, "Enhancing image ...");
drawnow
%axes(handles.axes1);

%Enhance Image
disk_diam = 30; %could configure this
[ J,level ] = enhanceImage( I, disk_diam );
imshow(J)
BW = extractBinary( J, level );
%imshow(BW)
updateStatus(handles, "Skeletonizing - may take a few minutes ...");
drawnow
%Skeletonize - requires package compilation
BW = bwmorph(skeleton(BW)>30,'skel',Inf);
imshow(BW)

%Get perimeter of cell body
seE = strel('disk',15); %erode
seD = strel('disk',5); %dilate
[BWp, maxperim,cellperim ] = perimeterCell(J,level, seE,seD );
%imshow(BW - BWp)

%Calculate statistics
stats = regionprops('table',BW,'Centroid','Area',...
    'Perimeter','MajorAxisLength','MinorAxisLength')
[maxaxis,i] = max(stats.MajorAxisLength); %assume longest is the main cell
cxy = stats.Centroid(i,:);
minaxis = stats.MinorAxisLength(i);
area = stats.Area(i);
perim = stats.Perimeter(i);

% Count Endpoints and overlay on original Image
BW6 = bwmorph(BW,'endpoints');
figure
imshow(J); hold on;
[j,k] = find(BW6 == 1);

%Plot centroid
plot(cxy(1),cxy(2),...
          'color','b','marker','X','linestyle','none','LineWidth',2); 
count_endpoints = 0;
%cellskeleton = 0;
for i=1:length(k)
    r = j(i);
    c = k(i);
    
    contour = bwtraceboundary(BW,[r c],'NE',8,Inf,'counterclockwise');
    if (length(contour) >= maxperim)
        plot(contour(:,2),contour(:,1),'g','LineWidth',2);
        %cellskeleton = contour;
        %plot perimeter
        plot(cellperim(:,2), cellperim(:,1), ':y', 'LineWidth', 2)
    else
        plot(contour(:,2),contour(:,1),'r','LineWidth',2);
    end
    [inp,onp] = inpolygon(r,c,cellperim(:,1),cellperim(:,2));
    if (~inp)
        plot(k(i),j(i),...
         'color','r','marker','O','linestyle','none','LineWidth',2);
        count_endpoints = count_endpoints +1;
    end
    
end
%legend('o - Endpoints')
hold off

%create output table
cols={'Area', 'Perimeter','MajorAxisLength','MinorAxisLength','Endpoints'};
T1 = table(area,perim,maxaxis,minaxis,count_endpoints, 'VariableNames',cols)
%save to file
[pathstr,fname,ext] = fileparts(hData.imageFile);
csvname = strcat(fname, '_stats.csv');
outputfile = fullfile(hData.imagePath, csvname);
writetable(T1,outputfile);
%saveDataFile(outputfile, cols, T1);
updateStatus(handles,"Analysis Complete. Data saved to " + outputfile);
drawnow


% --------------------------------------------------------------------
function menu_File_Callback(hObject, eventdata, handles)
% hObject    handle to menu_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to menu_loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    fileTypes = {  '*.tif;*.tiff;*.jpg;*.jpeg', 'Tiff/JPG images' };
    updateStatus(handles,'Loading image, please wait ...');
    [imageFile, imagePath, ~] = ...
      uigetfile(fileTypes, ...
		'Select neuron image', ...
		'MultiSelect', 'off');
    inputPath = fullfile(imagePath,imageFile);
    
    I = imread(inputPath);
    %load image in panel
    axes(handles.axes1);
    hFig = figure(get(handles.axes1,'parent'));%handles.axes1.Parent;
    imshow(inputPath);
    
    %save image data
    data = struct('img',I, 'Pimg', hFig,'imagePath',imagePath,'imageFile', imageFile);
    set(hObject,'UserData',data);  
    %Notification
    updateStatus(handles,'Image loaded.');
    msgbox('Image loaded. Now click Run.')


% --- Executes on button press in btnView.
function btnView_Callback(hObject, eventdata, handles)
% hObject    handle to btnView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hB = findobj('Tag', 'menu_loadImage');
hData = hB.UserData;
P = hData.Pimg;
if (~isempty(P))
    imtool(P)
else
    updateStatus(handles,'Error: Unable to load Image')
end


% --------------------------------------------------------------------
function menu_loaddir_Callback(hObject, eventdata, handles)
% hObject    handle to menu_loaddir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkboxBatch.
function checkboxBatch_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxBatch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxBatch


% --------------------------------------------------------------------
function menu_save_Callback(hObject, eventdata, handles)
% hObject    handle to menu_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hB = findobj('Tag', 'menu_loadImage');
if (isempty(hB.UserData))
    updateStatus(handles, 'Error: Unable to show image as not yet loaded');
    return
end
pathname = hB.UserData.imagePath;
[pathstr,fname,ext] = fileparts(hB.UserData.imageFile);
imgfilename = strcat(fname, '_processed.png');
Fig1 = figure;
copyobj(handles.axes1, Fig1);
saveas(Fig1, fullfile(pathname, imgfilename)); 
updateStatus(handles, strcat('Image saved as : ', fullfile(pathname, imgfilename)));


% --------------------------------------------------------------------
function menu_Help_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_userguide_Callback(hObject, eventdata, handles)
% hObject    handle to menu_userguide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Message = {'Instructions for use' ...
    '1. Load image(tif or jpg) from File->Load Image' ...
    '2. Click on Run' ...
    '3. Review results in popup window - can save this figure' ...
    '4. View output data in csv file noted in status output window'};
h = msgbox(Message,'Instructions','Help');

% --------------------------------------------------------------------
function menu_about_Callback(hObject, eventdata, handles)
% hObject    handle to menu_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Message = {'QBI Cell Protrusion Analyser' ...
    'Description: Developed for Laura (Richards lab) '...
    'for the detection and analysis of protrusions from cells.' ...
    'Developed by Liz Cooper-Williams (e.cooperwilliams@uq.edu.au)'...
    '(c) Copyright QBI 2017' ...
    'Source: https://github.com/QBI-Software/Protrusions'};
msgbox(Message,'About')

% --------------------------------------------------------------------
function menu_exit_Callback(hObject, eventdata, handles)
% hObject    handle to menu_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)
