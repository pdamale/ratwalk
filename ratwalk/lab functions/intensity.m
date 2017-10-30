function [ lf_intens, lf_intens_total, lf_intens_mean, lf_intens_area, rf_intens, rf_intens_total, rf_intens_mean, rf_intens_area, lr_intens, lr_intens_total, lr_intens_mean, lr_intens_area, rr_intens, rr_intens_total, rr_intens_mean, rr_intens_area ] = intensity( lf, rf, lr, rr, vid )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [lf_intens, lf_intens_total, lf_intens_mean, lf_intens_area] = intensity_nested(lf, vid);
    [rf_intens, rf_intens_total, rf_intens_mean, rf_intens_area] = intensity_nested(rf, vid);
    [lr_intens, lr_intens_total, lr_intens_mean, lr_intens_area] = intensity_nested(lr, vid);
    [rr_intens, rr_intens_total, rr_intens_mean, rr_intens_area] = intensity_nested(rr, vid);
    
    function [paw_intensity, paw_intens_total, paw_intens_mean, paw_intens_area] = intensity_nested(working_paw, vid1)
        x = find(working_paw(:, 1));
        k = length(x);
        paw_intensity = zeros(21, 21, length(working_paw));
        rect_intensity = zeros(21, 21);
        for i = 1 : length(x)
            i1 = x(i);
            k1 = vid1(:, :, :, i1);
            for a = 1:size(k1,1)
                for b = 1:size(k1,2)
                    if k1(a,b,3) == 255
                        k1(a,b,2) = 0;
                    end;
                end;
            end;
                
            k1 = [zeros(3, 1920, 3); k1; zeros(3, 1920, 3)];
            x1 = working_paw(i1, 2);
            y1 = working_paw(i1, 1);
            for i2 = x1-7 : x1+7
                for j2 = y1-7 : y1+7
                    rect_intensity(i2+11-x1, j2+11-y1) = k1(i2+3, j2, 2);
                    paw_intensity(:, :, i1) = rect_intensity(:, :);
                end;
            end;
            rect_intensity = double(rect_intensity);
            paw_intens_area(i,1) = length(find(rect_intensity));
            paw_intens_total(i,1) = sum(sum(rect_intensity, 2));
            paw_intens_mean(i,1) = mean(mean(rect_intensity));
        end; 
    end
end


%         x=find(lf(:,1));
%         rect=double(lf_intens);  
%         rand5 = randi([1, length(x)], 5);
%         for i=1:5
%           rect_ins(:,:)=rect(:,:,x(rand5(i)));
%           [x3, y3]=meshgrid(1:1:21);
%           [x2, y2]=meshgrid(1:.1:21);
%           rect_int=interp2(x3,y3,rect_ins,x2,y2,'spline');
%           figure,surf(rect_int);
%         end;