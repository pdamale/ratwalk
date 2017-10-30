
%% Input - read in the videofile and define the first frame

clc;
clear all;
close all;

MovieObj = VideoReader('C:\Users\pixel\Downloads\Video\catwalk.avi'); %Read in the videofile
nframes = get(MovieObj, 'NumberOfFrames'); %Compute the number of frames in the video
FirstFrame=read(MovieObj,1); %Define the first frame in the video as the FirstFrame
% FirstFrame=rgb2gray(FirstFrame); %Change the frame into grayscale

%% Create an array "Original" from the original movie


for k = 1 : 325
    OriginalFrame = read(MovieObj, k); %Read in the k:th frame
%     OriginalFrame=rgb2gray(OriginalFrame); %Change the frame into grayscale
    Original(:,:,:,k) = OriginalFrame; %Write the results into 
...the array "Original"
end

%% Compute the difference between the first and k:th frame and create an array "EnhancedChange"
...(the k:th frame defined as NextFrame)


for k = 1:325
    NextFrame = read(MovieObj, k); %Read in the k:th frame
%     NextFrame=rgb2gray(NextFrame); %Change the frame into grayscale
    NextFrame=FirstFrame-NextFrame; %Compute the difference between 
    ...the first and k:th frame
%       NextFrame=255-NextFrame;  
             NextFrame=rgb2gray(NextFrame);
             Nhood=[1 1 1;1 1 1;1 1 1];
             se=strel(Nhood);
             NextFrame=imerode(NextFrame,se);
             [B,map]=gray2ind(NextFrame,256); 
             map(1:20,1)=0;
             map(1:20,2)=0;
             map(1:20,3)=1;
             map(26:70,1)=0;
             map(26:70,2)=1;
             map(26:70,3)=0;
             map(71:256,1)=0;
             map(71:256,2)=0;
             map(71:256,3)=1;
             NextFrame=ind2rgb(B,map);
%              Nhood=[1 1 1;0 0 0;1 1 1];
%              se=strel(Nhood);
       EnhancedChange(:,:,:,k) = NextFrame; %Write the results into 
...the array "EnhancedChange"
end



%% Play the results with implay with the original video on top and changes below

% Mov=vertcat(Original,EnhancedChange);
% implay(Mov)

%% Write the resulting file into avi - uncomment if you want to take this in use 

% writerObj = VideoWriter('movie.avi');
% open(writerObj);
% writeVideo(writerObj,Mov);
% close(writerObj);