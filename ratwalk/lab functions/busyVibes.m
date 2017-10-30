function [figHandle, msgHandle] = busyVibes(title,msg,busyGraphic,tPeriod)
%BUSYVIBES  Vibrating L-shaped membrane busy waitbar.
%   BUSYVIBES provides a modal figure with an animated graphic of the
%   MathWorks logo: the L-shaped membrane. 
%
%   The graphic is not a jpeg, but is the continual replotting of the 
%   time dependent solutions of the wave equation for the vibrations
%   of an L-shaped membrane.  The solution is expressed as a linear
%   combination, with time-dependent coefficients, of two-dimensional
%   spatial eigenfunctions.  The eigenfunctions are computed during
%   initialization by the function MEMBRANE.  The first of these
%   eigenfunctions, the fundamental mode, is the MathWorks logo.
%
%   The L-shaped geometry is of particular interest mathematically because
%   the stresses approach infinity near the reentrant corner.  Conventional
%   finite difference and finite element methods require considerable
%   time and storage to achieve reasonable accuracy.  The approach used
%   here employs functions that comes from the VIBES and BENCH functions.
%
%   There are 4 animations available:
%      1:  This uses a looping incrementing and decrementing time and the
%          first eigenfunction.  This is the MathWorks Logo.
%      2:  This uses incrementing time and the first
%          eigenfunction.  This is the MathWorks Logo.
%      3:  This uses incrementing time and only 3 eigenfunctions.
%      4:  This uses incrementing time and 12 eigenfunctions.
%
%   BUSYVIBES(TITLE,MSG,BUSYGRAPHIC,TPERIOD) returns the handle to the
%       figure.  The handle can be used to close the figure from within an
%       executing script.  TITLE is the text you wish to name the figure.
%       MSG is the text you wish to display to the user.  BUSYGRAPHIC is
%       the animation you wish to show on the figure.  The values are
%       scalar 1 through 4.  Anything else will execute the first
%       animation.  TPERIOD is the scalar time in seconds that you want the
%       animation to update between 2 and .005.  Note that the faster the 
%       animation occurs, that it could have negitive impact on the 
%       execution speed of the rest of the tasks running in MATLAB.
%
%   [FIGHANDLE, MSGHANDLE] = BUSYVIBES(TITLE,MSG,BUSYGRAPHIC,TPERIOD)
%       returns both the figure and text box handles.  This allows the
%       closing of the figure and updating the message from within an
%       executing script.
%   
%   Example:
%       % This example uses pauses to emulate tasks being executed and the
%       % need to let the end user know which tasks are happening when.
%       [busyFig msgHandle] = busyVibes('Busy'                   ,...
%                                  'I am busy working on a task.',...
%                                  2                             ,...
%                                  .1                             ...
%                                  );
%        pause(10) % Pause used to emulate a task is being executed
%        set(msgHandle,'String','I am working on task number 2 now.')
%        pause(10) % Pause used to emulate another task is being executed
%        set(msgHandle,'String','I am now starting task number 3.')
%        pause(10) % Pause used to emulate a third task is being executed
%        set(msgHandle,'String',{'            FINISHED'; 'Dialog closing in 5 secs.'})
%        pause(5)
%        close(busyFig);
%
%
%        % This example uses a TPERIOD less than .005 seconds and the
%        % script encounters an error.
%        [busyFig msgHandle] = busyVibes('Busy',...
%            'I am trying to run a bogus function.',...
%            3                      ,...
%            .001                    ...
%            );
%        try
%            pause(5)
%            eval('somebogusfunction')
%        catch
%            set(msgHandle,'String',{'            ERROR'; 'Dialog closing in 5 secs.'})
%            lasterr
%            pause(5)
%        end
%        close(busyFig);

%   Note that you cannot have two of busyVibes executing at the same time.
%   You may experience strange behaviors.  BUSYVIBES requires three files:
%   busyVibes.m, vibrationSeries.m, and getnicefigurelocation.m.


%   Copyright 1984-2013 The MathWorks, Inc.
%   Revision 1.02

%% Set graphics parameters.

%%%%%%%%%%%%%%%%%%%%%%%
%%% Create busyFig  %%%
%%%%%%%%%%%%%%%%%%%%%%%

figPos    = get(0,'DefaultFigurePosition');
figPos(3) = 267;
figPos(4) =  70;
figPos    = getnicefigurelocation(figPos, get(0,'DefaultFigureUnits'));
figHandle=dialog(                                     ...
    'Visible'         ,'on'                       , ...
    'Name'            ,title                      , ...
    'Pointer'         ,'arrow'                    , ...
    'Position'        ,figPos                     , ...
    'IntegerHandle'   ,'off'                      , ...
    'WindowStyle'     ,'modal'                    , ...
    'CloseRequestFcn' , @doDelete                 , ...
    'HandleVisibility','on'                       , ...
    'Color'           ,[0 0 0]                    , ...
    'Tag'             ,title                        ...
    );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Create MathWorks Logo Axes %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
logoAxes = axes;
set(logoAxes,'Position',[.7 .05 .25 .9])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Create MathWorks Logo Surface %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = (-15:15)/15;
% Eigenfunctions
for k = 1:12
    L{k} = 1.2*membrane(k); %#ok<*AGROW>
end
logoSurf = surf(logoAxes,x,x,L{1});
set(logoSurf, ...
    'EdgeColor'               ,'none'            , ...
    'FaceColor'               ,[0.9 0.2 0.2]     , ...
    'FaceLighting'            ,'phong'           , ... % 'phong' or 'gouraud'
    'AmbientStrength'         ,0.3               , ...
    'DiffuseStrength'         ,0.6               , ...
    'Clipping'                ,'off'             , ...
    'BackFaceLighting'        ,'lit'             , ...
    'SpecularStrength'        ,0.5               , ...
    'SpecularColorReflectance',1                 , ...
    'SpecularExponent'        ,7                 , ...
    'Tag'                     ,'TheMathWorksLogo', ...
    'parent'                  ,logoAxes            ...
    );

light('Position',[40 100 20], ...
    'Style','local', ...
    'Color',[0 0.8 1], ...
    'parent',logoAxes);

light('Position',[.5 -1 .4], ...
    'Color',[0.8 .8 0], ...
    'parent',logoAxes);

axis([-1 1 -1 1 -1 1]);
caxis(26.9*[-1.5 1]);
axis off

%%%%%%%%%%%%%%%%%%%%%%
%%% Create Message %%%
%%%%%%%%%%%%%%%%%%%%%%
MsgTxtForeClr=[1 1 1];
MsgTxtBackClr=get(figHandle,'Color');
msgHandle=uicontrol(figHandle              , ...
    'Style'              ,'text'         , ...
    'Position'           ,[17 20 161 33 ], ...
    'String'             ,{msg}          , ...
    'HorizontalAlignment','left'         , ...
    'FontSize'           ,10             , ...
    'FontWeight'         ,'bold'         , ...
    'BackgroundColor'    ,MsgTxtBackClr  , ...
    'ForegroundColor'    ,MsgTxtForeClr    ...
    );


%% Run

%%%%%%%%%%%%%%%%%%%%%
%%% Create timer  %%%
%%%%%%%%%%%%%%%%%%%%%
busy_timer = timer;

timerTag = sprintf('busyTimer%d',round(cputime*1000));
set(figHandle,'Userdata',timerTag);

busy_timer.tag            = timerTag;
if tPeriod <= .005
    busy_timer.Period    =  .005;
    warning('busyVibes:TimerPeriod',...
        'Period for timer animation was too fast to allow\n   for MATLAB to execute any other tasks.\n      tPeriod changed to .005 seconds.'); 
elseif tPeriod >= 2
    busy_timer.Period     = 2;
    warning('busyVibes:TimerPeriod',...
        'Period for timer animation is way too slow.\n      tPeriod changed to 2 seconds.');
else
    busy_timer.Period     = tPeriod;
end
busy_timer.ExecutionMode  = 'fixedRate';
busy_timer.BusyMode       = 'drop';

switch busyGraphic
    case {1 2 3 4}
        busy_timer.TimerFcn = {@vibrationSeries, busyGraphic, logoSurf, L};
    otherwise
        busy_timer.TimerFcn = {@vibrationSeries, 2, logoSurf, L};
end

start(busy_timer)

try
    set(figHandle,'HandleVisibility','Callback')
    drawnow
    return
catch
end
end

function doDelete(object,event) %#ok<*INUSD>
%% Figure Close Request Function
% 
global busyinit
busyinit = '';

try % Stop and Delete Timer Object
    timerTag = get(gcf,'Userdata');
    stop(timerfind('tag',timerTag))
    delete(timerfind('tag',timerTag))
catch
end
try
   delete(gcf)
catch 
end
end