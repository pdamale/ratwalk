function varargout = itrack(varargin)
% ITRACK MATLAB code for itrack.fig
%      ITRACK, by itself, creates a new ITRACK or raises the existing
%      singleton*.
%
%      H = ITRACK returns the handle to a new ITRACK or the handle to
%      the existing singleton*.
%
%      ITRACK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ITRACK.M with the given input arguments.
%
%      ITRACK('Property','Value',...) creates a new ITRACK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before itrack_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to itrack_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help itrack

% Last Modified by GUIDE v2.5 15-Sep-2016 17:43:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @itrack_OpeningFcn, ...
                   'gui_OutputFcn',  @itrack_OutputFcn, ...
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


% --- Executes just before itrack is made visible.
function itrack_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to itrack (see VARARGIN)

% Choose default command line output for itrack
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes itrack wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = itrack_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function path_Callback(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path as text
%        str2double(get(hObject,'String')) returns contents of path as a double


% --- Executes during object creation, after setting all properties.
function path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in paw.
function paw_Callback(hObject, eventdata, handles)
% hObject    handle to paw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns paw contents as cell array
%        contents{get(hObject,'Value')} returns selected item from paw
% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
switch str{val};
case 'RF' % User selects right front.
set(handles.flag1,'String',1);
    %    handles.current_data = handles.peaks;
case 'LF' % User selects left front.
set(handles.flag1,'String',2);
    %    handles.current_data = handles.membrane;
case 'RR' % User selects right rear.
set(handles.flag1,'String',3);
    %    handles.current_data = handles.sinc;
case 'LR' % User selects left rear.
set(handles.flag1,'String',4);
end
% Save the handles structure.
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function paw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to paw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function flag_Callback(hObject, eventdata, handles)
% hObject    handle to flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flag as text
%        str2double(get(hObject,'String')) returns contents of flag as a double


% --- Executes during object creation, after setting all properties.
function flag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function flag1_Callback(hObject, eventdata, handles)
% hObject    handle to flag1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flag1 as text
%        str2double(get(hObject,'String')) returns contents of flag1 as a double


% --- Executes during object creation, after setting all properties.
function flag1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flag1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in track.
function track_Callback(hObject, eventdata, handles)
% hObject    handle to track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',2);
second(handles);


% --- Executes on button press in step_size.
function step_size_Callback(hObject, eventdata, handles)
% hObject    handle to step_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',4);
guidata(hObject,handles);
second(handles);


% --- Executes on button press in intensity.
function intensity_Callback(hObject, eventdata, handles)
% hObject    handle to intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',3);
second(handles);


% --- Executes on button press in composite.
function composite_Callback(hObject, eventdata, handles)
% hObject    handle to composite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',5);
second(handles);


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename_load pathname_load  
clc;
% [path, user_cance]=imgetfile();
[filename_load, pathname_load]=uigetfile({'*.mp4';'*.mat';'*.*';},'Select Video File','MultiSelect','on');
assignin('base','filename_load',filename_load);
% vidDevice1=strcat(pathname,filename);
% % if user_cance
% %     msgbox(sprintf('Error'),'Error','Error');
% %     return;
% % end;
% % vidDevice=VideoReader(vidDevice1);
% set(handles.path,'String',vidDevice1);
% set(handles.flag,'String',1);


% --- Executes on button press in paw_rf.
function paw_rf_Callback(hObject, eventdata, handles)
% hObject    handle to paw_rf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paw_rf
set(handles.flag,'String',0);
second(handles);

% --- Executes on button press in paw_lf.
function paw_lf_Callback(hObject, eventdata, handles)
% hObject    handle to paw_lf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paw_lf
set(handles.flag,'String',0);
second(handles);

% --- Executes on button press in paw_rr.
function paw_rr_Callback(hObject, eventdata, handles)
% hObject    handle to paw_rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paw_rr
set(handles.flag,'String',0);
second(handles);

% --- Executes on button press in paw_lr.
function paw_lr_Callback(hObject, eventdata, handles)
% hObject    handle to paw_lr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paw_lr
set(handles.flag,'String',0);
second(handles);


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
second(handles);


% --- Executes on button press in swing_time.
function swing_time_Callback(hObject, eventdata, handles)
% hObject    handle to swing_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',6);
second(handles);


% --- Executes on button press in dist_time.
function dist_time_Callback(hObject, eventdata, handles)
% hObject    handle to dist_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',7);
second(handles);



function frame_no_Callback(hObject, eventdata, handles)
% hObject    handle to frame_no (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_no as text
%        str2double(get(hObject,'String')) returns contents of frame_no as a double
set(handles.flag,'String',0);

% --- Executes during object creation, after setting all properties.
function frame_no_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_no (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in intensity_images.
function intensity_images_Callback(hObject, eventdata, handles)
% hObject    handle to intensity_images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of intensity_images
set(handles.flag,'String',0);
second(handles);


% --- Executes on button press in swing_speed.
function swing_speed_Callback(hObject, eventdata, handles)
% hObject    handle to swing_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',8);
second(handles);

% --- Executes on button press in duty_cycle.
function duty_cycle_Callback(hObject, eventdata, handles)
% hObject    handle to duty_cycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',9);
second(handles);

% --- Executes on button press in run_duration.
function run_duration_Callback(hObject, eventdata, handles)
% hObject    handle to run_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',10);
second(handles);


% --- Executes on button press in paw_support.
function paw_support_Callback(hObject, eventdata, handles)
% hObject    handle to paw_support (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',11);
second(handles);


% --- Executes on button press in manual_setup.
function manual_setup_Callback(hObject, eventdata, handles)
% hObject    handle to manual_setup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test(handles);