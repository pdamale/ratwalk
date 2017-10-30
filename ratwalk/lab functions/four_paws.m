q = 556;
while q < 565
clc;
clearvars -except q;
close all;
path1='/Users/TjalkensLab/Desktop/ratwalk/Capture/study (6.13.14-6.25.14)/6.27.14/';
path2='GOPR0';
path3=num2str(q);
path4='.mp4';
path5='.mat';
filepath=strcat(path1,path2,path3,path4);
redThresh = 0.08; % Threshold for red detection
vidDevice=VideoReader(filepath); 
% % [filename pathname]=uigetfile('*.wmv');
% % vidDevice1=strcat(pathname,filename);
% % vidDevice=VideoReader(vidDevice1);
numframes=get(vidDevice,'numberOfFrames');
hblob = vision.BlobAnalysis('AreaOutputPort', false,'CentroidOutputPort', true,'BoundingBoxOutputPort', true','MinimumBlobArea', 130,'MaximumBlobArea', 3000,'MaximumCount', 30);
hshapeinsRedBox = vision.ShapeInserter('BorderColor', 'White');
htextins = vision.TextInserter('Text', 'Number of Red Object: %2d','Location', [7 2],'Color', [255 255 255],'FontSize', 12);
htextinsCent = vision.TextInserter('Text', '+ X:%4d, Y:%4d', 'LocationSource', 'Input port','Color', [255 255 255],'FontSize', 14);


temp_frame = read(vidDevice, 1);
[y1, y2, track_factor] = detect_track(temp_frame);
% % This example uses pauses to emulate tasks being executed and the
% %       % need to let the end user know which tasks are happening when.
% %       [busyFig msgHandle] = busyVibes('Busy'                   ,...
% %                                  'I am busy working on a task.',...
% %                                  2                             ,...
% %                                  .1                             ...
% %                                  );
% 
% % hVideoIn = vision.VideoPlayer('Name', 'Final V  ideo','Position', [100 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);
 nFrame = 0; % Frame number initialization
 e=zeros(4,2,(numframes - 1));
for k=1:(numframes - 1)
  rgbFrame = read(vidDevice,k); % Acquire single frame
  rgbFrame = lensdistort(rgbFrame,-0.18);
  %rgbFrame(1:530,:,:) = 0; % put a black region on the output stream
  %rgbFrame(700:1080,:,:)=0;
  %rgbFrame1=rgbFrame(1:609,:,:);
  %rgbFrame2=rgbFrame(680:1080,:,:);
  rgbFrame = imrotate(rgbFrame, -0.4, 'bilinear', 'crop');
  rgbFrame=rgbFrame(y1:y2,:,:); 
  rgbFrame(1:3,:,:) = 0;
  rgbFrame(68:70,:,:) = 0;
  rgbFrame(:,1:230,:) = 0;
  rgbFrame(:,1600:1920,:) = 0;
  for i=1:71
      for j=1:1920
          if rgbFrame(i,j,2)<180
              rgbFrame(i,j,2)=0;
          end;
      end;
  end;
 
%   rgbFrame(:,:,2)=2*rgbFrame(:,:,2);
  diffFrame = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame)); % Get red component of the image
%   diffFrame = medfilt2(diffFrame, [3 3]); % Filter out the noise by using median filter
  binFrame = im2bw(diffFrame, redThresh); % Convert the image into binary image with the red objects as white
%   binFrame(:,1:230) = 0;
%   binFrame(:,1600:1920) = 0;
%   binFrame(1:3,:) = 0;
%   binFrame(68:70,:) = 0;
             Nhood=[1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1];
             se=strel(Nhood);
             binFrame=imdilate(binFrame,se);
%              binFrame=imdilate(binFrame,se);
%              binFrame=imdilate(binFrame,se);
%              binFrame=imdilate(binFrame,se);
  [centroid, bbox] = step(hblob, binFrame); % Get the centroids and bounding boxes of the blobs
 centroid = uint16(centroid); % Convert the centroids into Integer for further steps
 
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
end;
savepath = strcat(path2,path3, path5);
save(savepath,'e','EnhancedChange','y1','y2','track_factor');
q = q + 1;
end;
% [lr_step rr_step rf_step lf_step]=step_size(lr,rr,rf,lf);
% [rf, lf, rr, lr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(q.e);
% [ lf_step, rf_step, lr_step, rr_step ] = relevant_strides( lf_step, rf_step, lr_step, rr_step );
% [ lf_intens, lf_intens_total, lf_intens_mean, rf_intens, rf_intens_total, rf_intens_mean, lr_intens, lr_intens_total, lr_intens_mean, rr_intens, rr_intens_total, rr_intens_mean ] = intensity( lf, rf, lr, rr, q.EnhancedChange );
% [ lf_intens, lf_intens_total, lf_intens_mean, lf_intens_area, rf_intens, rf_intens_total, rf_intens_mean, rf_intens_area, lr_intens, lr_intens_total, lr_intens_mean, lr_intens_area, rr_intens, rr_intens_total, rr_intens_mean, rr_intens_area ] = intensity( lf, rf, lr, rr, q.EnhancedChange );
% [lf_swing,lr_swing,rf_swing,rr_swing,lf_stop,lr_stop,rf_stop,rr_stop] = swing_time(lf, lr, rf, rr);
% csvwrite('rf_step.csv',rf_step);
% 
% % Plotting same paw on a strip
% x=find(rf(:,1));
% clear k2;
% k2=EnhancedChange(:,:,:,1);
% k2(230:350,:,:)=0;
% % htextinsCent3 = vision.TextInserter('Text', '+LF X:%4d, Y:%4d', 'LocationSource', 'Input port','Color', [0 255 0],'FontSize', 14);
% for i=1:length(x)
% i1=x(i);
% k1=read(vidDevice,i1);
% x1=rf(i1,2);
% y1=rf(i1,1);
% for i2=x1-7:x1+10
%     for j2=y1-8:y1+5
%         k2(i2,j2,2)=k1(i2,j2,2);
%     end;
% end;
% % x1=uint8(x1);
% % y1=uint8(y1);
% % k2=step(htextinsCent3,k2,[y1 x1],[y1-6 x1-9]);
% end;
% imshow(k2);
