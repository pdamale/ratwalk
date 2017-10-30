clc;
clear all;
close all;

redThresh = 0.05; % Threshold for red detection
% vidDevice = imaq.VideoDevice('winvideo', 1, 'YUY2_640x480','ROI', [1 1 640 480],'ReturnedColorSpace', 'rgb');
vidDevice=VideoReader('C:\Users\pixel\Downloads\Video\ArcSoft_Video2.wmv'); 

hblob = vision.BlobAnalysis('AreaOutputPort', false,'CentroidOutputPort', true,'BoundingBoxOutputPort', true','MinimumBlobArea', 10,'MaximumBlobArea', 3000,'MaximumCount', 10);
hshapeinsRedBox = vision.ShapeInserter('BorderColor', 'White');
htextins = vision.TextInserter('Text', 'Number of Red Object: %2d','Location', [7 2],'Color', [255 255 255],'FontSize', 12);
htextinsCent = vision.TextInserter('Text', '+ X:%4d, Y:%4d', 'LocationSource', 'Input port','Color', [255 255 255],'FontSize', 14);
 
% hVideoIn = vision.VideoPlayer('Name', 'Final Video','Position', [100 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);
 nFrame = 0; % Frame number initialization
 e=zeros(4,2,300);
for k=1:300
  rgbFrame = read(vidDevice,k); % Acquire single frame
%   rgbFrame = flipdim(rgbFrame,2); % obtain the mirror image for displaying
  diffFrame = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame)); % Get red component of the image
  diffFrame = medfilt2(diffFrame, [3 3]); % Filter out the noise by using median filter
  binFrame = im2bw(diffFrame, redThresh); % Convert the image into binary image with the red objects as white
  [centroid, bbox] = step(hblob, binFrame); % Get the centroids and bounding boxes of the blobs
 centroid = uint16(centroid); % Convert the centroids into Integer for further steps
 rgbFrame(1:20,1:165,:) = 0; % put a black region on the output stream
 vidIn = step(hshapeinsRedBox, rgbFrame, bbox); % Insert the red box
 [a b]=size(centroid); % determining number of paws detected
 for i=1:a  % writing co-ordinates of paws in different variable
     for j=1:b
         e(i,j,k)=centroid(i,j);
     end;
 end;
 for object = 1:1:length(bbox(:,1))
       centX = centroid(object,1); centY = centroid(object,2);
       vidIn = step(htextinsCent, vidIn, [centX centY], [centX-6 centY-9]);    
 end;
  vidIn = step(htextins, vidIn, uint8(length(bbox(:,1))));
%    step(hVideoIn, vidIn); 
   EnhancedChange(:,:,:,k) = vidIn;
%    nFrame = nFrame+1;
 end

 m=zeros(5,2,300);
 c=zeros(5,2,300);
 for n=1:300
     for b=1:5
         y1=e(1,2,n)-e(b,2,n);
         x1=e(1,1,n)-e(b,1,n);
         m1=y1/x1;
         m(b,1,n)=m1;
         y2=e(2,2,n)-e(b,2,n);
         x2=e(2,1,n)-e(b,1,n);
         m2=y2/x2;
         m(b,2,n)=m2;
     end;
 end;

 v=zeros(5,2,300);
for n=1:300
    for a=1:5
        for b=1:2
            if m(a,b,n)<0.75
               m(a,b,n)=m(a,b,n);
            else m(a,b,n)=0;
            end;          
        end;
    end;   
end;
for n=1:300
    for a=1:5
        for b=1:2
            if m(a,b,n)>(-0.15)
               m(a,b,n)=m(a,b,n);
            else m(a,b,n)=0;
            end;          
        end;
    end;   
end;    
for n=1:300 
    for a=1:5   
        for b=1:2
            if ((m(a,b,n)>0.65)||(m(a,b,n)<(-0.07)))
                m(a,b,n)=m(a,b,n);
            else m(a,b,n)=0;
            end;
        end;
    end;
end;
% git test

