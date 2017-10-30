function [y1, y2, track_factor] = detect_track(image, distortion, y)
    image = lensdistort(image, distortion);
%     image = imrotate(image, -0.4, 'bilinear', 'crop');
%     for i = 1 : 1070
%         if image(i, 1000, 2) > 150 && image(i+5, 1000, 2) > 80
%             y2 = i + 3;
%             y2 = y2 - 35;
%         end;
%     end;
%     y1 = y2 - 70;
%     y3 = y1 - 175;
   y3 = y(1);
   y1 = y(2);
   y2 = y(3);

    j = 1;
    x(1, 1) = 0;
    for i = 2 : 1910
        if image(y3, i, 2) >= 240 && image(y3, i-1, 2) >= 200 && image(y3, i+1, 2) >= 200 && image(y3, i+10, 2) < 150
            if j == 1 
                x(j, 1) = i;
                j = j + 1;
            else
                if i - x(j - 1) > 100
                    x(j, 1) = i;
                    j = j + 1;
                end;
            end;
        end;
        
    end
    
    for i = 1 : length(x) - 1
        j (i) = x(i + 1) - x(i);
    end;
    
    track_factor = 10 / mean(j);
end