function [lf, rf, lr, rr] = differenciate_four(paw_cords)
% This function differenciates the four paws from the frames where four
% paws are detected.
    desired_4 = desired_frames(paw_cords, 4);    
    tf = strcmp(num2str(desired_4(1)), 'NaN');
    if tf == 1
        
        [row, col, frame] = size(paw_cords);
        [lf, rf, lr, rr] = deal(zeros(frame,col));
    else
        [row, col, frame] = size(paw_cords);
        [lf, rf, lr, rr] = deal(zeros(frame,col));
        [row_1, col_1] = size(desired_4);
        temp = zeros(4, 2, frame);

        for i = 1 : col_1
            temp(1:4,:,desired_4(i)) = paw_cords(1:4,:,desired_4(i));
        end;

        temp1 = zeros(4,2);

        for i = 1 : col_1
            j = desired_4(i);
            temp1(:,:) = temp(:,:,j);
            if temp1(1,2) > temp1(2,2)
                lr(j,:) = temp1(1,:);
                rr(j,:) = temp1(2,:);
            else
                lr(j,:) = temp1(2,:);
                rr(j,:) = temp1(1,:);
            end;
            if temp1(3,2) > temp1(4,2)
                lf(j,:) = temp1(3,:);
                rf(j,:) = temp1(4,:);
            else
                lf(j,:) = temp1(4,:);
                rf(j,:) = temp1(3,:);
            end;
        end;
    end;
end    