function [lf, rf, lr, rr] = elim_same_cords(lf, rf, lr, rr)
% This function checks for same co-ordinats in different paws and if found
% any assign it as zero.
    lf = check_same(lf, rf);
    lf = check_same(lf ,lr);
    lf = check_same(lf, rr);
    rf = check_same(rf, lf);
    rf = check_same(rf, lr);
    rf = check_same(rf, rr);
    lr = check_same(lr, lf);
    lr = check_same(lr, rf);
    lr = check_same(lr, rr);
    rr = check_same(rr, lf);
    rr = check_same(rr, rf);
    rr = check_same(rr, lr);
    lf = check_big_diff(lf);
    rf = check_big_diff(rf);
    lr = check_big_diff(lr);
    rr = check_big_diff(rr);
        
    function [working_paw] = check_same(working_paw, other_paw)
        frame = size(working_paw, 1);
        for i = 1 : frame - 2
            if (working_paw(i, :) == other_paw(i, :) )| (working_paw(i, :) == other_paw(i+1, :) )| (working_paw(i, :) == other_paw(i+2, :) )
                working_paw(i, :) = [0, 0];
            end;
        end;
    
    end    
    

    function [working_paw] = check_big_diff(working_paw)
        frame = size(working_paw, 1);
        for i = 1 : frame - 2
            if working_paw(i, :) ~= [0, 0]
                if working_paw(i+1, :) ~= [0, 0] & working_paw(i+2) ~= [0, 0]
                    temp(1, :) = working_paw(i, :);
                    temp(2, :) = working_paw(i+1, :);
                    distance1 = (temp(1, 1) - temp(2, 1)) ^ 2 + (temp(1, 2) - temp(2, 2)) ^ 2;
                    distance1 = sqrt(distance1);
                    distance1 = distance1*(10/182);

                    temp1(1, :) = working_paw(i+1, :);
                    temp1(2, :) = working_paw(i+2, :);
                    distance2 = (temp1(1, 1) - temp1(2, 1)) ^ 2 + (temp1(1, 2) - temp1(2, 2)) ^ 2;
                    distance2 = sqrt(distance2);
                    distance2 = distance2*(10/182);
                    if distance1 > 1 & distance2 <= 1
                        working_paw(i, :) = [0, 0];
                    elseif distance1 <= 1 & distance2 > 1
                        working_paw(i+2, :) = [0, 0];
                    end;
                end;
            end;
        end;
        
    end
end