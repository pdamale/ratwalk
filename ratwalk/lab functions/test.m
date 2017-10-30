function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 16-Sep-2016 03:40:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


global distortion; 
global frame_no;
global toggle_l2r;
global toggle_u2d;
distortion = -0.25;
frame_no = 1;
toggle_l2r = 1;
toggle_u2d = 1;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global filename_load pathname_load  
clc;
global vidDevice1;
global distortion; 
global frame_no;
global toggle_l2r;
global toggle_u2d;

[filename_load, pathname_load]=uigetfile({'*.mp4';'*.mat';'*.*';},'Select Video File','MultiSelect','on');
assignin('base','filename_load',filename_load);
vidDevice1 = strcat(pathname_load, filename_load);
vidDevice=VideoReader(vidDevice1); 
temp_frame = read(vidDevice, frame_no);
if toggle_l2r == 0
    temp_frame = flip(temp_frame, 2);
end;
if toggle_u2d == 0
    temp_frame = flip(temp_frame,1);
end;
temp_frame = lensdistort(temp_frame, distortion);
set(handles.axes1);
imshow(temp_frame);



% --- Executes on slider movement.
function distortion_slider_Callback(hObject, eventdata, handles)
% hObject    handle to distortion_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global vidDevice1;
global distortion; 
global frame_no;
global toggle_l2r;
global toggle_u2d;

distortion = get(handles.distortion_slider, 'Value');
distortion = distortion - 0.25;
assignin('base','distortion',distortion);
vidDevice=VideoReader(vidDevice1); 
temp_frame = read(vidDevice, frame_no);
assignin('base','temp_frame',temp_frame);
if toggle_l2r == 0
    temp_frame = flip(temp_frame, 2);
end;
if toggle_u2d == 0
    temp_frame = flip(temp_frame,1);
end;
temp_frame = lensdistort(temp_frame, distortion);
% set(handles.axes1, 'XLim', [1,1080], 'YLim', [1,1920]);
set(handles.axes1);
imshow(temp_frame);



% --- Executes during object creation, after setting all properties.
function distortion_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distortion_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function frame_slider_Callback(hObject, eventdata, handles)
% hObject    handle to frame_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global vidDevice1;
global distortion; 
global frame_no;
global toggle_l2r;
global toggle_u2d;

vidDevice=VideoReader(vidDevice1); 
set(handles.frame_slider, 'min', 0);
last_frame = vidDevice.numberofframes;
set(handles.frame_slider, 'max', last_frame-1);
frame_no = floor(get(handles.frame_slider, 'Value')) + 1;
assignin('base','frame_no',frame_no);
vidDevice=VideoReader(vidDevice1); 
temp_frame = read(vidDevice, frame_no);
assignin('base','temp_frame',temp_frame);
if toggle_l2r == 0
    temp_frame = flip(temp_frame, 2);
end;
if toggle_u2d == 0
    temp_frame = flip(temp_frame,1);
end;
temp_frame = lensdistort(temp_frame, distortion);
set(handles.axes1);
imshow(temp_frame);



% --- Executes during object creation, after setting all properties.
function frame_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function colour_slider_Callback(hObject, eventdata, handles)
% hObject    handle to colour_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global y;
global vidDevice1;
global frame_no;
global distortion;
global toggle_l2r;
global toggle_u2d;
global greenThresh


vidDevice=VideoReader(vidDevice1); 
temp_frame = read(vidDevice, frame_no);
assignin('base','temp_frame',temp_frame);
if toggle_l2r == 0
    temp_frame = flip(temp_frame, 2);
end;
if toggle_u2d == 0
    temp_frame = flip(temp_frame,1);
end;
temp_frame = lensdistort(temp_frame, distortion);
y1 = y(2);
y2 = y(3);
assignin('base','y1',y1);
assignin('base','y2',y2);
greenThresh = get(handles.colour_slider, 'Value');
assignin('base','greenThresh',greenThresh);
rgbFrame = temp_frame;
rgbFrame = rgbFrame(y1:y2,:,:); 
rgbFrame(1:3,:,:) = 0;
rgbFrame((y2-y1-3):(y2-y1),:,:) = 0;
rgbFrame(:,1:50,:) = 0;
rgbFrame(:,1870:1920,:) = 0;
for i = 1 : (y2-y1)
    for j = 1 : 1920
        if rgbFrame(i,j,2) < greenThresh
            rgbFrame(i,j,2) = 0;
        end;
    end;
end;
diffFrame = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame)); % Get red component of the image
redThresh = 0.08; % Threshold for red detection
binFrame = im2bw(diffFrame, redThresh); % Convert the image into binary image with the red objects as white
Nhood=[1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1];
se=strel(Nhood);
binFrame=imdilate(binFrame,se);
binFrame=imdilate(binFrame,se);
binFrame=imdilate(binFrame,se);
binFrame=imdilate(binFrame,se);
hblob = vision.BlobAnalysis('AreaOutputPort', false,'CentroidOutputPort', true,'BoundingBoxOutputPort', true','MinimumBlobArea', 130,'MaximumBlobArea', 3000,'MaximumCount', 30);
hshapeinsRedBox = vision.ShapeInserter('BorderColor', 'White', 'Shape', 'Rectangles', 'Fill', true, 'FillColor', 'White');
[centroid, bbox] = step(hblob, binFrame); % Get the centroids and bounding boxes of the blobs
centroid = uint16(centroid); % Convert the centroids into Integer for further steps
vidIn = step(hshapeinsRedBox, rgbFrame, bbox);
[a, b]=size(centroid); % determining number of paws detected
set(handles.axes1);
imshow(vidIn);
h = msgbox(strcat('Number of objects detected:', num2str(uint8(length(bbox(:,1))))));


% --- Executes during object creation, after setting all properties.
function colour_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colour_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in markers.
function markers_Callback(hObject, eventdata, handles)
% hObject    handle to markers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global y;
[x,y] = ginput(3);
x = floor(x);
y = floor(y);
assignin('base','x',x);
assignin('base','y',y);
    


% --- Executes on button press in toggle_L2R.
function toggle_L2R_Callback(hObject, eventdata, handles)
% hObject    handle to toggle_L2R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of toggle_L2R

global vidDevice1;
global distortion; 
global frame_no;
global toggle_l2r;
global toggle_u2d;

toggle_l2r = get(hObject, 'Value');
assignin('base','toggle_l2r',toggle_l2r);

frame_no = floor(get(handles.frame_slider, 'Value')) + 1;
assignin('base','frame_no',frame_no);
vidDevice=VideoReader(vidDevice1); 
temp_frame = read(vidDevice, frame_no);
assignin('base','temp_frame',temp_frame);
if toggle_l2r == 0
    temp_frame = flip(temp_frame, 2);
end;
if toggle_u2d == 0
    temp_frame = flip(temp_frame,1);
end;
temp_frame = lensdistort(temp_frame, distortion);
set(handles.axes1);
imshow(temp_frame);


% --- Executes during object creation, after setting all properties.
function toggle_L2R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toggle_L2R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in toggle_U2D.
function toggle_U2D_Callback(hObject, eventdata, handles)
% hObject    handle to toggle_U2D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of toggle_U2D

global vidDevice1;
global distortion; 
global frame_no;
global toggle_l2r;
global toggle_u2d;

toggle_u2d = get(hObject, 'Value');
assignin('base','toggle_u2d',toggle_u2d);

frame_no = floor(get(handles.frame_slider, 'Value')) + 1;
assignin('base','frame_no',frame_no);
vidDevice=VideoReader(vidDevice1); 
temp_frame = read(vidDevice, frame_no);
assignin('base','temp_frame',temp_frame);
if toggle_l2r == 0
    temp_frame = flip(temp_frame, 2);
end;
if toggle_u2d == 0
    temp_frame = flip(temp_frame,1);
end;
temp_frame = lensdistort(temp_frame, distortion);
set(handles.axes1);
imshow(temp_frame);


% --- Executes during object creation, after setting all properties.
function toggle_U2D_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toggle_U2D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Done.
function Done_Callback(hObject, eventdata, handles)
% hObject    handle to Done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global distortion; 
global toggle_l2r;
global toggle_u2d;
global y;
global greenThresh;

save('track_parameters.mat', 'y', 'greenThresh', 'toggle_l2r', 'toggle_u2d', 'distortion');
close(test);
