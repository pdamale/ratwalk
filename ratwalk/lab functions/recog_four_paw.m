function [rf, lf, rr, lr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(paw_cords)
    [lf, rf, lr, rr] = differenciate_four(paw_cords);
    [lf, rf, lr, rr] = differenciate_three(paw_cords, lf, rf, lr, rr);
    [lf, rf, lr, rr] = differenciate_two(paw_cords, lf, rf, lr, rr);
    [lf, rf, lr, rr] = trace_2and3(paw_cords, lf, rf, lr, rr);    
    [lf, rf, lr, rr] = elim_same_cords(lf, rf, lr, rr);
%   [lf, rf, lr, rr] = paw_interp(lf, rf, lr, rr);
    [lf_step, rf_step, lr_step, rr_step] = step_size(lf, rf, lr, rr);
    
end
