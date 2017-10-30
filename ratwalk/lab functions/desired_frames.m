function [ desired ] = desired_frames( paw_cords, no_of_paws, great_eq)
% Get the frames numbers with desired numbers of paws present.
%   Obtaining the frames numbers with desired numbers of paws present in
%   it. Useful for partially differentiating the 4, 3, 2 paws.
    count  = 1; % beginning the frame count from 1 for desired
    [row, col, frame]  = size(paw_cords);
    desired(count) = [NaN];
    if (nargin < 3) || isempty(great_eq) || (great_eq == 0)
        for i  = 1:frame
            current_frame = paw_cords(:,:,i);
            current_frame_col = current_frame(:,1); % Getting first column for finding non-zero elements
            no_of_paw_in_frame = find(current_frame_col); % Obtaining the number of paws present (non-zero elements) in the frames
            rows = size(no_of_paw_in_frame,1); 
            if rows == no_of_paws
                desired(count) = i; % Putting the frame number with desired paws
                count = count + 1;
            end;
        end;
    else
        for i  = 1:frame
            current_frame = paw_cords(:,:,i);
            current_frame_col = current_frame(:,1); % Getting first column for finding non-zero elements
            no_of_paw_in_frame = find(current_frame_col); % Obtaining the number of paws present (non-zero elements) in the frames
            rows = size(no_of_paw_in_frame,1); 
            if rows >= no_of_paws
                desired(count) = i; % Putting the frame number with desired paws
                count = count + 1;
            end;
        end;
    
    
end

