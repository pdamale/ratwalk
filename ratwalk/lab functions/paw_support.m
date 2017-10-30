function [support, diagonal_dual_support, three_point_support, four_point_support, initial_dual_support] = paw_support(paw_cords)

    [lf, rf, lr, rr, ~, ~, ~, ~] = recog_four_paw(paw_cords);

    support = zeros(size(lf,1),4);
    
    x = find(lf(:,1));
    for i = 1 : length(x)
        support(x(i),1) = 1;
    end;
    x = find(rf(:,1));
    for i = 1 : length(x)
        support(x(i),2) = 1;
    end;
    x = find(lr(:,1));
    for i = 1 : length(x)
        support(x(i),3) = 1;
    end;
    x = find(rr(:,1));
    for i = 1 : length(x)
        support(x(i),4) = 1;
    end;

    diagonal_dual_support = 0;
    three_point_support = 0;
    four_point_support = 0;
    
    for i = 1 : size(support,1)
        x = find(support(i,:));
        y = size(x,2);
        if y == 2
            diagonal_dual_support = diagonal_dual_support + 1;
        elseif y == 3
            three_point_support = three_point_support + 1;
        elseif y == 4
            four_point_support = four_point_support + 1;
        else
            continue;
        end;
    end;
    
    total_support = diagonal_dual_support + three_point_support + four_point_support;
    diagonal_dual_support = diagonal_dual_support * (100 / total_support);
    three_point_support = three_point_support * (100 / total_support);
    four_point_support = four_point_support * (100 / total_support);

    k1 = find(support(:,3), 1);
    k2 = find(support(:,4), 1);
    initial_dual_support = abs(k1 - k2) / 60;

end