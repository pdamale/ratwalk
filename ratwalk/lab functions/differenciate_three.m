function [lf, rf, lr, rr] = differenciate_three(paw_cords, lf, rf, lr, rr, thresh)
% This function differenciates paws in frames having only three 
% paws using 'Y' co-ordinate.
%   paw_cords = co-ordinates found after original detection
%   thresh is optional arguments
%   thresh = value of 'Y' co-ordinate for differeciating between left and 
%              right paw (default value for thresh is 35)
    desired_3 = desired_frames(paw_cords, 3);
    tf = strcmp(num2str(desired_3(1)), 'NaN');
    if tf == 1
        lf = lf;
        rf = rf;
        lr = lr;
        rr = rr;
    else
        [row, col, frame] = size(paw_cords);
        [row_1, col_1] = size(desired_3);
    temp = zeros(3, 2, frame);
    
    for i = 1 : col_1
        temp(1:3,:,desired_3(i)) = paw_cords(1:3,:,desired_3(i));
    end;
    
    temp1 = zeros(3,2);
    
    if (nargin < 6) || isempty(thresh)
        thresh = 35;
        for i = 1 : col_1
            j = desired_3(i);
            temp1(:,:) = temp(:,:,j);
            if temp1(1,2) > thresh
                lr(j,:) = temp1(1,:);
            else
                rr(j,:) = temp1(1,:);
            end;
            if temp1(3,2) > thresh
                lf(j,:) = temp1(3,:);
            else
                rf(j,:) = temp1(3,:);
            end;
        end;
    else
        for i = 1 : col_1
            j = desired_3(i);
            temp1(:,:) = temp(:,:,j);
            if temp1(1,2) > thresh_1
               lr(j,:) = temp1(1,:);
            else
               rr(j,:) = temp1(1,:);
            end;
            if temp1(3,2) > thresh
               lf(j,:) = temp1(3,:);
            else
               rf(j,:) = temp1(3,:);
            end;
        end;
    end;
    end;
end