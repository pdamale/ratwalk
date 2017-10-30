function varargout = simple_gui(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simple_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @simple_gui_OutputFcn, ...
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


% --- Executes just before simple_gui is made visible.
function simple_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% % varargin   command line arguments to simple_gui (see VARARGIN)

% Choose default command line output for simple_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simple_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = simple_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% 
% [filename pathname]=uigetfile('*.wmv');
% vidDevice1=strcat(pathname,filename);
% vidDevice=VideoReader(vidDevice1);


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vidDevice vidDevice1  
clc;
% [path, user_cance]=imgetfile();
[filename, pathname]=uigetfile('*.wmv');
vidDevice1=strcat(pathname,filename);
% if user_cance
%     msgbox(sprintf('Error'),'Error','Error');
%     return;
% end;
vidDevice=VideoReader(vidDevice1);
set(handles.path,'String',vidDevice1);
set(handles.flag,'String',1);
% axes(handles.axes1);
% x=read(vidDevice,30);
% imshow(x);

% --- Executes on button press in track.
function track_Callback(hObject, eventdata, handles)
% hObject    handle to track (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',2);
second(handles);




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


% --- Executes on button press in intensity.
function intensity_Callback(hObject, eventdata, handles)
% hObject    handle to intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',3);
second(handles);



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


% --- Executes on button press in step_size.
function step_size_Callback(hObject, eventdata, handles)
% hObject    handle to step_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',4);
second(handles);

% --- Executes on button press in composite.
function composite_Callback(hObject, eventdata, handles)
% hObject    handle to composite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.flag,'String',5);
second(handles);



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


% --- Executes on button press in paw_rf.
function paw_rf_Callback(hObject, eventdata, handles)
% hObject    handle to paw_rf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paw_rf


% --- Executes on button press in paw_lf.
function paw_lf_Callback(hObject, eventdata, handles)
% hObject    handle to paw_lf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paw_lf


% --- Executes on button press in paw_rr.
function paw_rr_Callback(hObject, eventdata, handles)
% hObject    handle to paw_rr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paw_rr


% --- Executes on button press in paw_lr.
function paw_lr_Callback(hObject, eventdata, handles)
% hObject    handle to paw_lr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paw_lr


% --- Executes on button press in rf_paw.
function rf_paw_Callback(hObject, eventdata, handles)
% hObject    handle to rf_paw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rf_paw


% --- Executes on button press in lf_paw.
function lf_paw_Callback(hObject, eventdata, handles)
% hObject    handle to lf_paw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lf_paw


% --- Executes on button press in paw_rf1.
function paw_rf1_Callback(hObject, eventdata, handles)
% hObject    handle to paw_rf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paw_rf1


% --- Executes on button press in paw_lf1.
function paw_lf1_Callback(hObject, eventdata, handles)
% hObject    handle to paw_lf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paw_lf1


% --- Executes on button press in paw_rr1.
function paw_rr1_Callback(hObject, eventdata, handles)
% hObject    handle to paw_rr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of paw_rr1


% --- Executes on button press in law_lr1.
function law_lr1_Callback(hObject, eventdata, handles)
% hObject    handle to law_lr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of law_lr1
