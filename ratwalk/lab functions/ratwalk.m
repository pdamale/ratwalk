function [EnhancedChange, e, y1, y2, track_factor] = ratwalk (filepath_vid)

    redThresh = 0.08; % Threshold for red detection
    vidDevice=VideoReader(filepath_vid); 
    
    numframes=get(vidDevice,'numberOfFrames');
    hblob = vision.BlobAnalysis('AreaOutputPort', false,'CentroidOutputPort', true,'BoundingBoxOutputPort', true','MinimumBlobArea', 130,'MaximumBlobArea', 3000,'MaximumCount', 30);
    hshapeinsRedBox = vision.ShapeInserter('BorderColor', 'White');
%     htextins = vision.TextInserter('Text', 'Number of Red Object: %2d','Location', [7 2],'Color', [255 255 255],'FontSize', 12);
    htextinsCent = vision.TextInserter('Text', '      X:%4d, Y:%4d', 'LocationSource', 'Input port','Color', [250 250 250],'FontSize', 14);
    
    load('track_parameters.mat');
    
    temp_frame = read(vidDevice, 1);
    if toggle_l2r == 0
        temp_frame = flip(temp_frame, 2);
    end;
    if toggle_u2d == 0
        temp_frame = flip(temp_frame,1);
    end;
    [y1, y2, track_factor] = detect_track(temp_frame, distortion, y);
    
     e=zeros(4,2,(numframes - 1));

    for k=1:numframes
      rgbFrame = read(vidDevice,k); % Acquire single frame
      if toggle_l2r == 0
         rgbFrame = flip(rgbFrame, 2);
      end;
      if toggle_u2d == 0
         rgbFrame = flip(rgbFrame,1);
      end;
      rgbFrame = lensdistort(rgbFrame, distortion);
%       rgbFrame = imrotate(rgbFrame, -0.4, 'bilinear', 'crop');
      rgbFrame=rgbFrame(y1:y2,:,:); 
      rgbFrame(1:3,:,:) = 0;
      rgbFrame((y2-y1-3):(y2-y1),:,:) = 0;
      rgbFrame(:,1:50,:) = 0;
      rgbFrame(:,1870:1920,:) = 0;
      for i = 1 : (y2-y1)
          for j=1:1920
              if rgbFrame(i,j,2) < greenThresh
                  rgbFrame(i,j,2) = 0;
              end;
          end;
      end;

      diffFrame = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame)); % Get red component of the image
    %   diffFrame = medfilt2(diffFrame, [3 3]); % Filter out the noise by using median filter
      binFrame = im2bw(diffFrame, redThresh); % Convert the image into binary image with the red objects as white
                 Nhood=[1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1];
                 se=strel(Nhood);
                 binFrame=imdilate(binFrame,se);
                 binFrame=imdilate(binFrame,se);
                 binFrame=imdilate(binFrame,se);
                 binFrame=imdilate(binFrame,se);
      [centroid, bbox] = step(hblob, binFrame); % Get the centroids and bounding boxes of the blobs
     centroid = uint16(centroid); % Convert the centroids into Integer for further steps

     vidIn = step(hshapeinsRedBox, rgbFrame, bbox); % Insert the red box
     [a, b]=size(centroid); % determining number of paws detected
     for i=1:a  % writing co-ordinates of paws in different variable
         for j=1:b
             e(i,j,k)=centroid(i,j);
         end;
     end;
     for object = 1:1:length(bbox(:,1))
           centX = centroid(object,1); centY = centroid(object,2);
           vidIn = step(htextinsCent, vidIn, [centX centY], [centX-6 centY-9]);    
     end;
    %    vidIn = step(htextins, vidIn, uint8(length(bbox(:,1)))); 
       EnhancedChange(:,:,:,k) = vidIn;
    end;
end