function [lf_duty_cycle, rf_duty_cycle, lr_duty_cycle, rr_duty_cycle, lf_step_cycle, rf_step_cycle, lr_step_cycle, rr_step_cycle ] = duty_step_cycle(paw_cords)

    [lf, rf, lr, rr, ~, ~, ~, ~] = recog_four_paw(paw_cords);
    [lf_swing,lr_swing,rf_swing,rr_swing,lf_stop,lr_stop,rf_stop,rr_stop] = swing_time(lf, lr, rf, rr);
    
    lf_step_cycle = lf_swing + lf_stop;
    rf_step_cycle = rf_swing + rf_stop;
    lr_step_cycle = lr_swing + lr_stop;
    rr_step_cycle = rr_swing + rr_stop;
    

    lf_duty_cycle = lf_stop ./ lf_step_cycle .* 100;
    rf_duty_cycle = rf_stop ./ rf_step_cycle .* 100;
    lr_duty_cycle = lr_stop ./ lr_step_cycle .* 100;
    rr_duty_cycle = rr_stop ./ rr_step_cycle .* 100;
    
end