function [ lf_step, rf_step, lr_step, rr_step ] = relevant_strides( lf_step, rf_step, lr_step, rr_step, track_factor )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    multiplier = track_factor;
    lf_step = nested_relevant(lf_step, multiplier);
    rf_step = nested_relevant(rf_step, multiplier);
    lr_step = nested_relevant(lr_step, multiplier);
    rr_step = nested_relevant(rr_step, multiplier);
    
    function [temp] = nested_relevant(working_paw, multiplier)
        working_paw = working_paw.*multiplier;
        j = 1;
        for i = 1 : length(working_paw)
            if working_paw(i) > 4 && working_paw(i) < 8
                temp(j,1) = working_paw(i);
                j = j + 1;
            end;
        end;
     
    end;    
    
end

