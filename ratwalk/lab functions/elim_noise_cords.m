function [paw_cords] = elim_noise_cords( all_cords, thresh )
%Eliminate the randomely detected noise co-ordinates
%   Trying to eliminate the wrongly detected co-ordinates by comparing
%   frames with the next two frames and eliminating the co-ordinates which
%   are not present in all three
    [row, col ,frame] = size(all_cords);
    paw_cords = all_cords; 
    distance = zeros(row,row);
    
    if (nargin < 2) || isempty(thresh)
        thresh = 5000; 
        for i = 1:(frame-1)
            for j = 1:row
                for k = 1:row
                    distance(j,k) = (all_cords(j,1,i) - all_cords(k,1,i+1))^2 + (all_cords(j,2,i) - all_cords(k,2,i+1))^2;  
                    if distance(j,:) > thresh
                        paw_cords(j,:,i) = 0;
                    end;
                end;
            end;
        end;
    else
        for i = 1:(frame-1)
            for j = 1:row
                for k = 1:row
                    distance(j,k) = (all_cords(j,1,i) - all_cords(k,1,i+1))^2 + (all_cords(j,2,i) - all_cords(k,2,i+1))^2;  
                    if distance(j,:) > thresh
                        paw_cords(j,:,i) = 0;
                    end;
                end;
            end;
        end;
    end;
  end

