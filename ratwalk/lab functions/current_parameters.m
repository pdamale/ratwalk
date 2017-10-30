function [new_y1, new_y2, new_distortion, new_toggle_l2r, new_toggle_u2d] = current_parameters(y1, y2, distortion, toggle_l2r, toggle_u2d)

    default_y1 = 430;
    default_y2 = 500;
    default_distortion = -0.18;
    default_toggle_l2r = 1;
    default_toggle_u2d = 1;
    
    new_y1 = default_y1;
    new_y2 = default_y2;
    new_distortion = default_distortion;
    new_toggle_l2r = default_toggle_l2r;
    new_toggle_u2d = default_toggle_u2d;
    
    
    
    if nargin == 5
        new_y1 = y1;
        new_y2 = y2;
        new_distortion = distortion;
        new_toggle_l2r = toggle_l2r;
        new_toggle_u2d = toggle_u2d;
    end;
    
    if nargin < 5 || isempty(y1) || isempty(y2) || isempty(distortion) || isempty(toggle_l2r) || isempty(toggle_u2d) 
        if (exist ('y1')) == 1
            new_y1 = y1;
        end;
        if (exist ('y2')) == 1
            new_y2 = y2;
        end;    
        if (exist ('distortion')) == 1
            new_distortion = distortion;
        end;        
        if (exist ('toggle_l2r')) == 1
            new_toggle_l2r = toggle_l2r;
        end;
        if (exist ('toggle_u2d')) == 1
            new_toggle_u2d = toggle_u2d;
        end;
    end;
    
    
%     
%     new_y1 = new_y1;
%     new_y2 = new_y2;
%     new_distortion = new_distortion;
%     new_toggle_l2r = new_toggle_l2r;
%     new_toggle_u2d = new_toggle_u2d;
    
end