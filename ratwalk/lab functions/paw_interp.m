function [lf, rf, lr, rr] = paw_interp(lf, rf, lr, rr)
% This function interpolates the co-ordinates for the frames where the paws
% are missing.
    lf = paw_interp_nest(lf);
    rf = paw_interp_nest(rf);
    lr = paw_interp_nest(lr);
    rr = paw_interp_nest(rr);
    
    function [working_paw] = paw_interp_nest(working_paw)
        frame = size(working_paw, 1);
        temp_1 = zeros(frame, 1);
        temp_2 = zeros(frame, 1);
        range = 1: 1: frame;
        temp_1 = working_paw(:, 1);
        temp_2 = working_paw(:, 2);
        present_cords = find(temp_1);
        for i = 1 : length(present_cords)
            values_1(i) = temp_1(present_cords(i));
            values_2(i) = temp_2(present_cords(i));
        end;
        temp_3 = interp1(present_cords, values_1, range, 'linear');
        temp_4 = interp1(present_cords, values_2, range, 'linear');
        working_paw(:, 1) = temp_3;
        working_paw(:, 2) = temp_4;
    end


end