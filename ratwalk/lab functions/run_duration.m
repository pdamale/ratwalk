function [run_time, cadence, base_of_support] = run_duration(paw_cords)
    
    [lf, rf, lr, rr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(paw_cords);
    
    run_length_lf = find(lf(:,1)); run_length_lf = run_length_lf(length(run_length_lf));
    run_length_rf = find(rf(:,1)); run_length_rf = run_length_rf(length(run_length_rf));
    run_length_lr = find(lr(:,1)); run_length_lr = run_length_lr(length(run_length_lr));
    run_length_rr = find(rr(:,1)); run_length_rr = run_length_rr(length(run_length_rr));
    
    run_time = (run_length_lf + run_length_rf + run_length_lr + run_length_rr) / (60 * 4);
    
    cadence = (length(lf_step) + length(rf_step) + length(lr_step) + length(rr_step)) / run_time;

    lf1 = lf; rf1= rf; lr1= lr; rr1 = rr;
    lf1(lf1==0) = []; rf1(rf1==0) = []; lr1(lr1==0) = []; rr1(rr1==0) = [];
    base_left_mean = (mean(lf1((length(lf1)/2)+1 : end)) + mean(lr1((length(lr1)/2)+1 : end))) / 2;
    base_right_mean = (mean(rf1((length(rf1)/2)+1 : end)) + mean(rr1((length(rr1)/2)+1 : end))) / 2;
   
    base_of_support = (base_right_mean - base_left_mean)*(10/182);
end