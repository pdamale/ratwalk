function [ diag_step_l2r, diag_step_r2l ] = diag_stride(paw_cords, lr, rr, track_factor)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    
    desired_2 = desired_frames(paw_cords, 2);
    tf = strcmp(num2str(desired_2(1)), 'NaN');
    mult_fact = track_factor;
    m = 1;
    n = 1;
    if tf == 1
        diag_step_l2r = 0;
        diag_step_r2l = 0;
    else
        for i = 1 : length(desired_2)
            if paw_cords(1, :, desired_2(i)) == lr(desired_2(i), :)
                temp(1, :) = paw_cords(1, :, desired_2(i));
                temp(2, :) = paw_cords(2, :, desired_2(i));
                distance = (temp(1, 1) - temp(2, 1)) ^ 2 + (temp(1, 2) - temp(2, 2)) ^ 2;
                distance = sqrt(distance);
                distance = distance*mult_fact;
                if distance >= 3.2
                    diag_step_l2r(m, 1) = distance;
                    m = m + 1;
                end;
            end;
            if paw_cords(1, :, desired_2(i)) == rr(desired_2(i), :)
                temp(1, :) = paw_cords(1, :, desired_2(i));
                temp(2, :) = paw_cords(2, :, desired_2(i));
                distance = (temp(1, 1) - temp(2, 1)) ^ 2 + (temp(1, 2) - temp(2, 2)) ^ 2;
                distance = sqrt(distance);
                distance = distance*mult_fact;
                if distance >= 3.2
                    diag_step_r2l(n, 1) = distance;
                    n = n + 1;
                end;
            end;
            
        end;
    end;

end

