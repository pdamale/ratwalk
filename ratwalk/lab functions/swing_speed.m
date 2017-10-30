function [swing_speed_lf, swing_speed_rf, swing_speed_lr, swing_speed_rr] = swing_speed(paw_cords)

    [lf, rf, lr, rr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(paw_cords);
    [lf_swing,lr_swing,rf_swing,rr_swing,~,~,~,~] = swing_time(lf, lr, rf, rr);
    
    swing_speed_lf = mean(lf_step) .* (10 / (182 * mean(lf_swing)));
    swing_speed_rf = mean(rf_step) .* (10 / (182 * mean(rf_swing)));
    swing_speed_lr = mean(lr_step) .* (10 / (182 * mean(lr_swing)));
    swing_speed_rr = mean(rr_step) .* (10 / (182 * mean(rr_swing)));

end