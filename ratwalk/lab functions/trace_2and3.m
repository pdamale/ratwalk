function [lf, rf, lr, rr] = trace_2and3(paw_cords, lf, rf, lr, rr) 
lf = trace_2and3_nested(paw_cords, lf);
rf = trace_2and3_nested(paw_cords, rf);
lr = trace_2and3_nested(paw_cords, lr);
rr = trace_2and3_nested(paw_cords, rr);


    function [working_paw] = trace_2and3_nested(paw_cords, working_paw, thresh)
    % This function traces back from already found paw co-ordinates to nearby
    % frames to find the nearest paws and assign them correctly
    %   paw_cords = co-ordinates found after original detection
    %   thresh is optional arguments
    %   thresh = value of 'Y' co-ordinate for differeciating between left and 
    %              right paw (default value for thresh is 35)

        desired = desired_frames(paw_cords, 2, 1);
        [row, col, frame] = size(paw_cords);
        count = 1;
        if (nargin < 3) || isempty(thresh)
            thresh = 1;
            while count <= 15
                for i = 1 : length(desired) - 1
                    current_frame = desired(i);
                    next_frame = current_frame + 1;
                    if working_paw(next_frame, :) == [0, 0]
                        temp_1 = working_paw(current_frame, :);
                        temp_2 = paw_cords(:, :, next_frame);
                        for j = 1 : row
                            distance(j) = sqrt((temp_2(j, 1) - temp_1(1,1)) ^ 2 + (temp_2(j, 2) - temp_1(1, 2)) ^ 2);
                            if distance(j) < thresh
                                working_paw(next_frame, :) = temp_2(j, :);
                            end;
                        end;
                    end;
                end;
                count = count + 1;
            end;

            desired_new = find(working_paw(:,1));
            count = 1;
            while count <= 3
                for i = 2 : length(desired_new) 
                    current_frame = desired_new(i);
                    prev_frame = current_frame - 1;
                    if working_paw(prev_frame, :) == [0, 0]
                        temp_1 = working_paw(current_frame, :);
                        temp_2 = paw_cords(:, :, prev_frame);
                        for j = 1 : row
                            distance(j) = sqrt((temp_2(j, 1) - temp_1(1,1)) ^ 2 + (temp_2(j, 2) - temp_1(1, 2)) ^ 2);
                            if distance(j) < thresh
                                working_paw(prev_frame, :) = temp_2(j, :);
                            end;
                        end;
                    end;
                end;
                count = count + 1;
            end;
        else
            while count <= 15
                for i = 1 : length(desired) - 1
                    current_frame = desired(i);
                    next_frame = current_frame + 1;
                    if working_paw(next_frame, :) == [0, 0]
                        temp_1 = working_paw(current_frame, :);
                        temp_2 = paw_cords(:, :, next_frame);
                        for j = 1 : row
                            distance(j) = sqrt((temp_2(j, 1) - temp_1(1,1)) ^ 2 + (temp_2(j, 2) - temp_1(1, 2)) ^ 2);
                            if distance(j) < thresh
                                working_paw(next_frame, :) = temp_2(j, :);
                            end;
                        end;
                    end;
                end;
                count = count + 1;
            end;

            desired_new = find(working_paw(:,1));
            count = 1;
            while count <= 3
                for i = 2 : length(desired_new) 
                    current_frame = desired_new(i);
                    prev_frame = current_frame - 1;
                    if working_paw(prev_frame, :) == [0, 0]
                        temp_1 = working_paw(current_frame, :);
                        temp_2 = paw_cords(:, :, prev_frame);
                        for j = 1 : row
                            distance(j) = sqrt((temp_2(j, 1) - temp_1(1,1)) ^ 2 + (temp_2(j, 2) - temp_1(1, 2)) ^ 2);
                            if distance(j) < thresh
                                working_paw(prev_frame, :) = temp_2(j, :);
                            end;
                        end;
                    end;
                end;
                count = count + 1;
            end;
        end;
    end
    
 end