function[lf_step, rf_step, lr_step, rr_step] = step_size(lf, rf, lr, rr);
    lf_step = step_size_nested(lf);
    rf_step = step_size_nested(rf);
    lr_step = step_size_nested(lr);
    rr_step = step_size_nested(rr);

    function [step] = step_size_nested(working_paw, thresh)
        frame = size(working_paw, 1);
        i = 1;
        j = 1;
        k = 1;
        if (nargin < 2) || isempty(thresh)
            thresh = 15;
            while i < frame && j <= frame
                temp(1, :) = working_paw(i, :);
                if temp(1, :) == [0, 0]
                    i = i + 1;
                    j = j + 1;
                    continue;
                end;
                temp(2, :) = working_paw(j, :);
                if temp(2, :) == [0,0]
                    j = j + 1;
                    continue;
                end;
                distance = (temp(1, 1) - temp(2, 1)) ^ 2 + (temp(1, 2) - temp(2, 2)) ^ 2;
                distance = sqrt(distance);
                if distance < thresh
                    j = j + 1;
                else
                    step(k, 1) = distance;
                    k = k + 1;
                    i = j;
                    j = j + 1;
                end;
            end;
        else
            while i < frame && j <= frame
                temp(1, :) = working_paw(i, :);
                if temp(1, :) == [0, 0]
                    i = i + 1;
                    j = j + 1;
                    continue;
                end;
                temp(2, :) = working_paw(j, :);
                if temp(2, :) == [0,0]
                    j = j + 1;
                    continue;
                end;
                distance = pdist(temp, 'Euclidean');
                if distance < thresh
                    j = j + 1;
                else
                    step(k, 1) = distance;
                    k = k + 1;
                    i = j;
                    j = j + 1;
                end;
            end;
        end;
    
    end;
 
end   