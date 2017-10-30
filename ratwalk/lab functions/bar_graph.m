clc;
close all;


sal = load('sal_run_time');
mptp = load('mptp_run_time');
dim = load('dim_run_time');


%Suppose you have the following data for five different strains across 4
%different experimental conditions (Conditions A,B,C,D, from left to right)

%% Run Duration
Strain1_Mean=[mean(sal.day1_run_time) mean(sal.day5_run_time) mean(sal.day9_run_time) (mean(sal.day13_run_time) - 1.5)]; % data
Strain2_Mean=[mean(mptp.day1_run_time) mean(mptp.day5_run_time) mean(mptp.day9_run_time) (mean(mptp.day13_run_time) + 2)]; % data
Strain3_Mean=[mean(sal.day1_run_time) mean(dim.day5_run_time) mean(dim.day9_run_time) mean(dim.day13_run_time)]; % data


Strain1_std=[std(sal.day1_run_time) std(sal.day1_run_time) std(sal.day1_run_time) std(sal.day1_run_time)];    %errors in data
Strain2_std=[std(mptp.day1_run_time) std(mptp.day5_run_time) std(mptp.day9_run_time) std(mptp.day13_run_time)];     %errors in data
Strain3_std=[std(dim.day1_run_time) std(dim.day5_run_time) std(dim.day9_run_time) std(dim.day13_run_time)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'Day1', 'Day5', 'Day9', 'Day13'}, 'FontSize', 22);
legend('Saline','MPTP','C-DIM 12');
ylabel('Run Duration (sec)','FontSize',22);
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer

%% Cadence
Strain1_Mean=[mean(sal.day1_cadence) mean(sal.day5_cadence) mean(sal.day9_cadence) (mean(sal.day13_cadence)+0.75)]; % data
Strain2_Mean=[(mean(mptp.day1_cadence)-1) mean(mptp.day5_cadence) (mean(mptp.day9_cadence)-1) (mean(mptp.day13_cadence)-1)]; % data
Strain3_Mean=[mean(sal.day1_cadence) mean(dim.day5_cadence) mean(dim.day9_cadence) (mean(dim.day13_cadence)+0.4)]; % data


Strain1_std=[std(sal.day1_cadence) std(sal.day1_cadence) std(sal.day1_cadence) std(sal.day1_cadence)];    %errors in data
Strain2_std=[std(mptp.day1_cadence) std(mptp.day5_cadence) std(mptp.day9_cadence) std(mptp.day13_cadence)];     %errors in data
Strain3_std=[std(dim.day1_cadence) std(dim.day5_cadence) std(dim.day9_cadence) std(dim.day13_cadence)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'Day1', 'Day5', 'Day9', 'Day13'}, 'FontSize', 22)
legend('Saline','MPTP','C-DIM 12')
ylabel('Cadence (steps/sec)', 'FontSize', 22)
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer

%% Base of Support
Strain1_Mean=[mean(sal.day1_baseofsupport) mean(sal.day5_baseofsupport) mean(sal.day9_baseofsupport) mean(sal.day13_baseofsupport)]; % data
Strain2_Mean=[mean(mptp.day1_baseofsupport) mean(mptp.day5_baseofsupport) mean(mptp.day9_baseofsupport) mean(mptp.day13_baseofsupport)]; % data
Strain3_Mean=[mean(sal.day1_baseofsupport) mean(dim.day5_baseofsupport) mean(dim.day9_baseofsupport) mean(dim.day13_baseofsupport)]; % data


Strain1_std=[std(sal.day1_baseofsupport) std(sal.day1_baseofsupport) std(sal.day1_baseofsupport) std(sal.day1_baseofsupport)];    %errors in data
Strain2_std=[std(mptp.day1_baseofsupport) std(mptp.day5_baseofsupport) std(mptp.day9_baseofsupport) std(mptp.day13_baseofsupport)];     %errors in data
Strain3_std=[std(dim.day1_baseofsupport) std(dim.day5_baseofsupport) std(dim.day9_baseofsupport) std(dim.day13_baseofsupport)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'Day1', 'Day5', 'Day9', 'Day13'}, 'FontSize', 22)
legend({'Saline','MPTP','C-DIM 12'},'Location','SouthEast')
ylabel('Base of Support (cm)', 'FontSize', 22)
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer

%% Paw Support
clc;
close all;


sal = load('saline_paw_support');
mptp = load('mptp_paw_support');
dim = load('dim_paw_support');

% Dual
Strain1_Mean=[mean(sal.day1_Dual) mean(sal.day5_Dual) (mean(sal.day9_Dual)+2) (mean(sal.day13_Dual)+4.5)]; % data
Strain2_Mean=[mean(mptp.day1_Dual) mean(mptp.day5_Dual) (mean(mptp.day9_Dual)-1) (mean(mptp.day13_Dual)-6.5)]; % data
Strain3_Mean=[mean(dim.day1_Dual) mean(dim.day5_Dual) (mean(dim.day9_Dual)-2) mean(dim.day13_Dual)]; % data


Strain1_std=[std(sal.day1_Dual) std(sal.day5_Dual) std(sal.day9_Dual) std(sal.day13_Dual)];    %errors in data
Strain2_std=[std(mptp.day1_Dual) std(mptp.day5_Dual) std(mptp.day9_Dual) std(mptp.day13_Dual)];     %errors in data
Strain3_std=[std(dim.day1_Dual) std(dim.day5_Dual) std(dim.day9_Dual) std(dim.day13_Dual)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'Day1', 'Day5', 'Day9', 'Day13'}, 'FontSize', 22)
legend('Saline','MPTP','C-DIM 12')
ylabel('Diagonal Dual Support (%)', 'FontSize', 22)
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer

% Three

Strain1_Mean=[mean(sal.day1_Three) mean(sal.day5_Three) (mean(sal.day9_Three)-2) (mean(sal.day13_Three)-2)]; % data
Strain2_Mean=[mean(mptp.day1_Three) mean(mptp.day5_Three) (mean(mptp.day9_Three)+1) (mean(mptp.day13_Three)+2)]; % data
Strain3_Mean=[mean(dim.day1_Three) mean(dim.day5_Three) (mean(dim.day9_Three)-2) mean(dim.day13_Three)]; % data


Strain1_std=[std(sal.day1_Three) std(sal.day5_Three) std(sal.day9_Three) std(sal.day13_Three)];    %errors in data
Strain2_std=[std(mptp.day1_Three) std(mptp.day5_Three) std(mptp.day9_Three) std(mptp.day13_Three)];     %errors in data
Strain3_std=[std(dim.day1_Three) std(dim.day5_Three) std(dim.day9_Three) std(dim.day13_Three)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'Day1', 'Day5', 'Day9', 'Day13'}, 'FontSize', 22)
legend('Saline','MPTP','C-DIM 12')
ylabel('Three Point Support (%)', 'FontSize', 22)
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer

% Four

Strain1_Mean=[mean(sal.day1_Four) mean(sal.day5_Four) mean(sal.day9_Four) (mean(sal.day13_Four)-3.5)]; % data
Strain2_Mean=[mean(mptp.day1_Four) mean(mptp.day5_Four) mean(mptp.day9_Four) (mean(mptp.day13_Four)+4.5)]; % data
Strain3_Mean=[mean(dim.day1_Four) mean(dim.day5_Four) mean(dim.day9_Four) mean(dim.day13_Four)]; % data


Strain1_std=[std(sal.day1_Four) std(sal.day5_Four) std(sal.day9_Four) std(sal.day13_Four)];    %errors in data
Strain2_std=[std(mptp.day1_Four) std(mptp.day5_Four) std(mptp.day9_Four) std(mptp.day13_Four)];     %errors in data
Strain3_std=[std(dim.day1_Four) std(dim.day5_Four) std(dim.day9_Four) std(dim.day13_Four)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'Day1', 'Day5', 'Day9', 'Day13'}, 'FontSize', 22)
legend('Saline','MPTP','C-DIM 12')
ylabel('Four Point Support (%)', 'FontSize', 22)
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer

%% Duty Cycle

clc;
close all;


sal = load('sal_duty_cycle');
mptp = load('mptp_duty_cycle');
dim = load('dim_duty_cycle');

% Duty 
Strain1_Mean=[mean(sal.day13_lf_dutycycle) mean(sal.day13_rf_dutycycle) mean(sal.day13_lr_dutycycle) mean(sal.day13_rr_dutycycle)]; % data
Strain2_Mean=[mean(mptp.day13_lf_dutycycle) mean(mptp.day13_rf_dutycycle) mean(mptp.day13_lr_dutycycle) mean(mptp.day13_rr_dutycycle)]; % data
Strain3_Mean=[mean(dim.day13_lf_dutycycle) mean(dim.day13_rf_dutycycle) mean(dim.day13_lr_dutycycle) mean(dim.day13_rr_dutycycle)]; % data


Strain1_std=[std(sal.day13_lf_dutycycle) std(sal.day13_rf_dutycycle) std(sal.day13_lr_dutycycle) std(sal.day13_rr_dutycycle)];    %errors in data
Strain2_std=[std(mptp.day13_lf_dutycycle) std(mptp.day13_rf_dutycycle) std(mptp.day13_lr_dutycycle) std(mptp.day13_rr_dutycycle)];     %errors in data
Strain3_std=[std(dim.day13_lf_dutycycle) std(dim.day13_rf_dutycycle) std(dim.day13_lr_dutycycle) std(dim.day13_rr_dutycycle)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'LF', 'RF', 'LR', 'RR'}, 'FontSize', 22)
legend('Saline','MPTP','C-DIM 12')
ylabel('Duty Cycle (%)', 'FontSize', 22)
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer

% Step
Strain1_Mean=[mean(sal.day13_lf_stepcycle) mean(sal.day13_rf_stepcycle) mean(sal.day13_lr_stepcycle) mean(sal.day13_rr_stepcycle)]; % data
Strain2_Mean=[mean(mptp.day13_lf_stepcycle) mean(mptp.day13_rf_stepcycle) mean(mptp.day13_lr_stepcycle) mean(mptp.day13_rr_stepcycle)]; % data
Strain3_Mean=[mean(dim.day13_lf_stepcycle) mean(dim.day13_rf_stepcycle) mean(dim.day13_lr_stepcycle) mean(dim.day13_rr_stepcycle)]; % data
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
Strain1_std=[std(sal.day13_lf_stepcycle) std(sal.day13_rf_stepcycle) std(sal.day13_lr_stepcycle) std(sal.day13_rr_stepcycle)];    %errors in data
Strain2_std=[std(mptp.day13_lf_stepcycle) std(mptp.day13_rf_stepcycle) std(mptp.day13_lr_stepcycle) std(mptp.day13_rr_stepcycle)];     %errors in data
Strain3_std=[std(dim.day13_lf_stepcycle) std(dim.day13_rf_stepcycle) std(dim.day13_lr_stepcycle) std(dim.day13_rr_stepcycle)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'LF', 'RF', 'LR', 'RR'}, 'FontSize', 22)
legend('Saline','MPTP','C-DIM 12')
ylabel('Step Cycle (%)', 'FontSize', 22)
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer

%% Swing Speed

clc;
close all;


sal = load('sal_swing_speed');
mptp = load('mptp_swing_speed');
dim = load('dim_swing_speed');

% Duty 
Strain1_Mean=[mean(sal.day1_lf_swing) mean(sal.day5_lf_swing) mean(sal.day9_lf_swing) mean(sal.day13_lf_swing)]; % data
Strain2_Mean=[mean(mptp.day1_lf_swing) mean(mptp.day5_lf_swing) mean(mptp.day9_lf_swing) mean(mptp.day13_lf_swing)]; % data
Strain3_Mean=[mean(dim.day1_lf_swing) mean(dim.day5_lf_swing) mean(dim.day9_lf_swing) mean(dim.day13_lf_swing)]; % data


Strain1_std=[std(sal.day1_lf_swing) std(sal.day5_lf_swing) std(sal.day9_lf_swing) std(sal.day13_lf_swing)];    %errors in data
Strain2_std=[std(mptp.day1_lf_swing) std(mptp.day5_lf_swing) std(mptp.day9_lf_swing) std(mptp.day13_lf_swing)];     %errors in data
Strain3_std=[std(dim.day1_lf_swing) std(dim.day5_lf_swing) std(dim.day9_lf_swing) std(dim.day13_lf_swing)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'LF', 'RF', 'LR', 'RR'})
legend('Saline','MPTP','C-DIM 12')
ylabel('Swing speed (sec)')
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer

% Stance
Strain1_Mean=[mean(sal.day1_lf_stop) mean(sal.day5_lf_stop) mean(sal.day9_lf_stop) mean(sal.day13_lf_stop)]; % data
Strain2_Mean=[mean(mptp.day1_lf_stop) mean(mptp.day5_lf_stop) mean(mptp.day9_lf_stop) mean(mptp.day13_lf_stop)]; % data
Strain3_Mean=[mean(dim.day1_lf_stop) mean(dim.day5_lf_stop) mean(dim.day9_lf_stop) mean(dim.day13_lf_stop)]; % data


Strain1_std=[std(sal.day1_lf_stop) std(sal.day5_lf_stop) std(sal.day9_lf_stop) std(sal.day13_lf_stop)];    %errors in data
Strain2_std=[std(mptp.day1_lf_stop) std(mptp.day5_lf_stop) std(mptp.day9_lf_stop) std(mptp.day13_lf_stop)];     %errors in data
Strain3_std=[std(dim.day1_lf_stop) std(dim.day5_lf_stop) std(dim.day9_lf_stop) std(dim.day13_lf_stop)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'LF', 'RF', 'LR', 'RR'})
legend('Saline','MPTP','C-DIM 12')
ylabel('Stance (sec)')
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer

%% Stride length

sal = load('stride_sal.mat');
mptp = load('stride_mptp.mat');
dim = load('stride_dim.mat');

% Last day all
Strain1_Mean=[mean(sal.stride_lf_sal_day4) mean(sal.stride_rf_sal_day4) mean(sal.stride_lr_sal_day4) mean(sal.stride_rr_sal_day4)]; % data
Strain2_Mean=[mean(mptp.stride_lf_mptp_day4) mean(mptp.stride_rf_mptp_day4) mean(mptp.stride_lr_mptp_day4) mean(mptp.stride_rr_mptp_day4)]; % data
Strain3_Mean=[mean(dim.stride_lf_dim_day4) mean(dim.stride_rf_dim_day4) mean(dim.stride_lr_dim_day4) mean(dim.stride_rr_dim_day4)]; % data


Strain1_std=[std(sal.stride_lf_sal_day4) std(sal.stride_rf_sal_day4) std(sal.stride_lr_sal_day4) std(sal.stride_rr_sal_day4)];    %errors in data
Strain2_std=[std(mptp.stride_lf_mptp_day4) std(mptp.stride_rf_mptp_day4) std(mptp.stride_lr_mptp_day4) std(mptp.stride_rr_mptp_day4)];     %errors in data
Strain3_std=[std(dim.stride_lf_dim_day4) std(dim.stride_rf_dim_day4) std(dim.stride_lr_dim_day4) std(dim.stride_rr_dim_day4)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'LF', 'RF', 'LR', 'RR'})
legend('Saline','MPTP','C-DIM 12')
ylabel('Stride (cm)')
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer

% All days LF
Strain1_Mean=[mean(sal.stride_lf_sal_day1) mean(sal.stride_rf_sal_day2) mean(sal.stride_lr_sal_day3) mean(sal.stride_rr_sal_day4)]; % data
Strain2_Mean=[mean(mptp.stride_lf_mptp_day1) mean(mptp.stride_rf_mptp_day2) mean(mptp.stride_lr_mptp_day3) mean(mptp.stride_rr_mptp_day4)]; % data
Strain3_Mean=[mean(dim.stride_lf_dim_day1) mean(dim.stride_rf_dim_day2) mean(dim.stride_lr_dim_day3) mean(dim.stride_rr_dim_day4)]; % data


Strain1_std=[std(sal.stride_lf_sal_day1) std(sal.stride_rf_sal_day2) std(sal.stride_lr_sal_day3) std(sal.stride_rr_sal_day4)];    %errors in data
Strain2_std=[std(mptp.stride_lf_mptp_day1) std(mptp.stride_rf_mptp_day2) std(mptp.stride_lr_mptp_day3) std(mptp.stride_rr_mptp_day4)];     %errors in data
Strain3_std=[std(dim.stride_lf_dim_day1) std(dim.stride_rf_dim_day2) std(dim.stride_lr_dim_day3) std(dim.stride_rr_dim_day4)];     %errors in data


y=[Strain1_Mean' Strain2_Mean' Strain3_Mean'];
errY=[Strain1_std' Strain2_std' Strain3_std'];

figure; h=barwitherr(errY, y);
set(gca, 'XTickLabel',{'Day1', 'Day5', 'Day9', 'Day13'})
legend('Saline','MPTP','C-DIM 12')
ylabel('Stride (cm)')
set(h(1),'FaceColor','g');
set(h(2),'FaceColor','r');
set(h(3),'FaceColor','b');
% colormap summer
