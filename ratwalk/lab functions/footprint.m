function[fp_lf, fp_rf, fp_lr, fp_rr] = footprint(paw_cords)

    [lf, rf, lr, rr, ~, ~, ~, ~] = recog_four_paw(paw_cords);

    fp_lf = foot_loop(lf, 0.5);
    fp_rf = foot_loop(rf, 1);
    fp_lr = foot_loop(lr, 1.5);
    fp_rr = foot_loop(rr, 2);

    
    function[fp] = foot_loop(working_paw, value)
        x = find(working_paw(:,1));
        fp = zeros(size(working_paw,1),1);
        for i = 1 : length(x)
            fp(x(i)) = value;
        end;
        fp(fp == 0) = NaN;
    end;

    figure;
    hold on; plot((1:length(fp_lf))./60,fp_lf(1:end), 'blue');
    hold on; plot((1:length(fp_rf))./60,fp_rf(1:end), 'green');
    hold on; plot((1:length(fp_lr))./60,fp_lr(1:end), 'red');
    hold on; plot((1:length(fp_rr))./60,fp_rr(1:end), 'yellow');
    
    h1 = plot((1:length(fp_lf))./60,fp_lf(1:end), 'blue');    set(h1, 'LineWidth', 30);
    h2 = plot((1:length(fp_rf))./60,fp_rf(1:end), 'green');   set(h2, 'LineWidth', 30);
    h3 = plot((1:length(fp_lr))./60,fp_lr(1:end), 'red');     set(h3, 'LineWidth', 30);
    h4 = plot((1:length(fp_rr))./60,fp_rr(1:end), 'yellow');  set(h4, 'LineWidth', 30);
    
    axis([0, (length(fp_lf)/60)+2, -1, 3.5]);
    legend({'LF', 'RF', 'LR', 'RR'},'FontSize',22);
    xlabel('Time (seconds)','FontSize',22);
end