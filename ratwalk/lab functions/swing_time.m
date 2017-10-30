function [lf_swing, lr_swing, rf_swing, rr_swing, lf_stop, lr_stop, rf_stop, rr_stop] = swing_time(lf, lr, rf, rr)
    [lf_swing, lf_stop] = nested_swing(lf);
    [rf_swing, rf_stop] = nested_swing(rf);
    [lr_swing, lr_stop] = nested_swing(lr);
    [rr_swing, rr_stop] = nested_swing(rr);
    
    function [swing_timing, stop_timing] = nested_swing(working_paw)
        frame = size(working_paw, 1);
        j = 0;
        k = 1;
        l = 0;
        m = 1;
        for i = 1 : frame - 1
            if working_paw(i, :) == [0, 0]
                j = j + 1;
            else
                l = l + 1;
                if  working_paw(i + 1, :) == [0, 0]
                    swing_timing(k, 1) = j;
                    stop_timing(m, 1) = l;
                    k = k + 1;
                    m = m + 1;
                    j = 0;
                    l = 0;
                else
                    continue;
                end;
            end;
        end;
        swing_timing = swing_timing(2:end);
        stop_timing = stop_timing(2:end);
        swing_timing = swing_timing.*(1/60);
        stop_timing = stop_timing.*(1/60);
    end;




end