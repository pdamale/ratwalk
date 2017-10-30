function varargout = busyWindow(varargin)
% busyWindow: Show a 'busy-window' while you do some calculations
%   hBusy = createWindow(figureTitle, outputMessage, mode) shows a busy
%   window while you do some calculations. With the option 'mode', you can
%   choose between 'normal' (default), 'progressA' or 'progressM' mode. 
%   If you choose one of the progress modes, then a progress bar is shown.
%   If the mode is 'progressA', the progress bar is increasing
%   automatically every second by 10 percent. If 100 percent is reached,
%   the progress bar restarts with zero. If you choose the mode
%   'progressB', you can increase the progress bar manually.   
%   After the calculation, the window manually needs to be
%   closed. To also remove the functions timer in progress mode, close the
%   figure with the command busyWindow('figure_closeRequestFcn')
%   
% Examples:
%
%   % Mode: 'progressA'
%   mSize = 1000;
%   busyText = 'please hold on, calculation is running...';
%   busyWindow('createWindow','busy',busyText,'progressA')
%   tic
%   for x = 1:mSize
%       M = magic(400);
%   end
%   toc
%   busyWindow('figure_closeRequestFcn')
%
%   % Mode: 'progressM'
%   mSize = 1000;
%   busyText = 'please hold on, calculation is running...';
%   hBusy = busyWindow('createWindow','busy',busyText,'progressM');
%   tic
%   for x = 1:mSize
%       M = magic(400);
%       busyWindow('updateProgress',hBusy,x/mSize)
%   end
%   toc
%   busyWindow('figure_closeRequestFcn')
%
%   % Mode: 'progressM', update text
%   mSize = 10;
%   hBusy = busyWindow('createWindow','busy','','progressM');
%   tic
%   for x = 1:mSize
%       busyText = ['calculating part ',num2str(x),' of ',num2str(mSize)];
%       busyWindow('updateProgress',hBusy,x/mSize,busyText)
%       for j = 1:100
%           M = magic(400);
%       end
%   end
%   toc
%   busyWindow('figure_closeRequestFcn')
%   
% =========================================================================
% busyWindow
% =========================================================================
% 
% Author:   Stephan Schmutz
% E-Mail:   stiphu@gmail.com
% Company:  University of Bern
% Date:     24.08.2010
% Version:  V 1.1
% -------------------------------------------------------------------------

if nargin == 1
    command = varargin{1};
else
    command = [varargin{1},'('];
    for i = 2:length(varargin)
        eval(['var',num2str(i-1),' = varargin{',num2str(i),'};']);
        command = [command,'var',num2str(i-1),','];
    end
    command = [command(1:end-1),');'];
end

if nargout
    leftHandSide = '[';
    for i = 1:nargout
        leftHandSide = [leftHandSide,'varargout{',num2str(i),'} '];
    end
    leftHandSide = [leftHandSide,']'];
    command = [leftHandSide,' = ',command];
end
eval(command)

%==========================================================================
% General functions
%==========================================================================

function hBusy = createWindow(figureTitle, outputMessage, mode)
% Create progress window

% Control input arguments
if nargin < 2 || nargin > 3
    error('MATLAB:busyWindow:InvalidArguments','check input arguments');
elseif nargout > 1
    error('MATLAB:busyWindow:InvalidArguments','too many output arguments');
elseif ~ischar(figureTitle) || ~ischar(outputMessage)
    error('MATLAB:busyWindow:InvalidInputs','first two input arguments must be character arrays')
end
progrMode = 0;
if nargin == 3
    modeCmp = {'normal' 'progressM' 'progressA'};
    index = find(strcmp(mode,modeCmp));
    if isempty(index)
        error('MATLAB:busyWindow:InvalidInputs','unknown output mode. check second input argument')
    elseif index == 2
        progrMode = 1;
    elseif index == 3
        progrMode = 2;
    end
end

% Initialization
stn.figSiz = [450 170];
stn.elDist = 10;
stn.prgHgt = 20;
% Background color
stn.bgCol = [255 255 255]/255;

% Create figure
scrSize = get(0,'ScreenSize');
figurePos = [(scrSize(3:4)-stn.figSiz)/2 stn.figSiz];
hBusy = figure('Position',figurePos,'Tag','figure_busyWindow',...
    'Units','Pixels','NumberTitle','off','Name',figureTitle,...
    'DockControls','off','MenuBar','none','Resize','off','Color',...
    stn.bgCol,'CloseRequestFcn',...
    'busyWindow(''figure_closeRequestFcn'')');
% 'WindowStyle','Modal'
% Display progress picture
myIm = imread('progress.jpg');
axesPos = [stn.elDist 0 0 0];
if progrMode
    picSide = stn.figSiz(2)-3*stn.elDist-stn.prgHgt;        
else
    picSide = stn.figSiz(2)-2*stn.elDist;
end
axesPos(2:4) = [figurePos(4)-stn.elDist-picSide repmat(picSide,1,2)];
hAxes = axes('Parent',hBusy,'Units','Pixels','Position',axesPos,...
    'Color',stn.bgCol);
imshow(myIm,'Parent',hAxes);
% Save settings in axes_picture UserData
set(hAxes,'Tag','axes_picture','UserData',stn)
% Display text
displayText(hBusy, outputMessage)
if progrMode
    % Display progress axes
    axesPos = [stn.elDist stn.elDist stn.figSiz(1)-2*stn.elDist stn.prgHgt];
    hAxes = axes('Parent',hBusy,'Tag','axes_progress','Units','Pixels',...
        'Position',axesPos,'Color',stn.bgCol,'YTick',[0 1],'YTickLabel','',...
        'XTick',[0 1],'XTickLabel','','Box','on');
    xlim(hAxes,[0 1]); ylim(hAxes,[0 1]);    
    hold(hAxes,'on')
    % Start timer
    if progrMode == 2
        myTimer = timer('TimerFcn',{@timerCallback,guihandles(gcf)},...
            'Period',1,'ExecutionMode','fixedDelay');
        start(myTimer)
        set(hBusy,'UserData',myTimer)
    end
end
% Force drawing
drawnow

% -------------------------------------------------------------------------

function displayText(hBusy, outputMessage)
% Create textfield and display text

% Load handles
handles = guihandles(hBusy);
% Load settings
stn = get(handles.axes_picture,'UserData');
% Load picture Size
picPos = get(handles.axes_picture,'Position');
% Erase old text
if any(strcmp(fieldnames(handles),'text_out'))
    delete(handles.text_out)
end
% Display text
txtSize = [stn.figSiz(1)-picPos(3)-3*stn.elDist picPos(4)];
txtPos = [picPos(3)+2*stn.elDist picPos(2) txtSize];
hText = uicontrol('Parent',hBusy,'Tag','text_out','Units','Pixels',...
    'Position',txtPos,'Style','Text','FontWeight','bold','FontSize',14,...
    'HorizontalAlignment','Left','BackgroundColor',stn.bgCol);
% Center vertical text, remove text longer than four lines
[outstring,position] = textwrap(hText,{outputMessage});
if length(outstring) > 4
    outstring = outstring(1:4);
    [outstring,position] = textwrap(hText,outstring);
end
txtPos(2:4) = [txtPos(2)+(txtPos(4)-position(4))/2 position(3:4)];
set(hText,'Position',txtPos,'String',outstring)

% -------------------------------------------------------------------------

function updateProgress(hBusy, progress, outputMessage)
% Update progress

% Init draw mode
drawMode = false;
% Load handles
handles = guihandles(hBusy);
% Make progress value a number between 0 and 10
progress = round(max([min([progress 1]) 0])*10)/10;
% Load the last progress value
lastProg = get(handles.axes_progress,'UserData');
if isempty(lastProg) || progress ~= lastProg
    % Clear axes
    cla(handles.axes_progress)
    if progress > 0
        % Create x-values
        xVal = 0.05:0.1:progress-0.05;
        % Set progress
        for i = 1:length(xVal)
            plot(handles.axes_progress,[xVal(i) xVal(i)],[0 1],'LineWidth',30)
        end
    end
    % Save the last progress value
    set(handles.axes_progress,'UserData',progress)
    % Set drawmode
    drawMode = true;
end
% Display outputMessage
if nargin == 3
    displayText(hBusy, outputMessage)
    % Set drawmode
    drawMode = true;
end
% Force drawing
if drawMode    
    drawnow
end

%==========================================================================
% Callback
%==========================================================================

function timerCallback(hObject, eventdata, handles)
% Callback bei Klick auf den Projektnamen

% Get the last axes value
lastProg = get(handles.axes_progress,'UserData');
if isempty(lastProg) || lastProg > 0.9
    % Clear axes and plot first event
    cla(handles.axes_progress)
    set(handles.axes_progress,'UserData',0)
else
    % Plot next progress
    lastProg = lastProg+0.1;
    plot(handles.axes_progress,[lastProg lastProg]-0.05,[0 1],'LineWidth',30)
    set(handles.axes_progress,'UserData',lastProg)
end
% Force drawing
drawnow

%==========================================================================
% CloseRequestFcn
%==========================================================================

function figure_closeRequestFcn

% Get currenct figure
curFig = gcf;
if strcmp(get(curFig,'Tag'),'figure_busyWindow')
    % Clear timer object
    myTimer = get(curFig,'UserData');
    if ~isempty(myTimer)
        stop(myTimer)
        delete(myTimer)
    end    
    % closes the figure
    delete(curFig);
end