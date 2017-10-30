dataset = load('dataset.mat');
q1=dataset.dataset_sal;
path1='/Users/TjalkensLab/Desktop/ratwalk/';
path2='GOPR0';
path3=num2str(q1(1));
path4='.mat';
filepath=strcat(path1,path2,path3,path4);
temp = load(filepath);
[lf, rf, lr, rr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(temp.e);
[lf, rf, lr, rr] = paw_interp(lf, rf, lr, rr);


for q = 74 : length(q1)
    try
        clc;
        clearvars -except KeepVariables q q1 lf rf lr rr lcs1 lcs2 lcs3 lcs4;
        path1='/Users/TjalkensLab/Desktop/ratwalk/';
        path2='GOPR0';
        path3=num2str(q1(q));
        path4='.mat';
        filepath=strcat(path1,path2,path3,path4);
        temp = load(filepath);
        [lf1, rf1, lr1, rr1, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(temp.e);
        [lf1, rf1, lr1, rr1] = paw_interp(lf1, rf1, lr1, rr1);
        [c1, b1] = LCS_length(lf(:,1), lf1(:,1), 10, 40, 0.4 );
        [c2, b2] = LCS_length(rf(:,1), rf1(:,1), 10, 40, 0.4 );
        [c3, b3] = LCS_length(lr(:,1), lr1(:,1), 10, 40, 0.4 );
        [c4, b4] = LCS_length(rr(:,1), rr1(:,1), 10, 40, 0.4 );
        lcs1(q-1,1) = max(c1(:)) / min(length(lf(:,1)),length(lf1(:,1)));
        lcs2(q-1,1) = max(c2(:)) / min(length(rf(:,1)),length(rf1(:,1)));
        lcs3(q-1,1) = max(c3(:)) / min(length(lr(:,1)),length(lr1(:,1)));
        lcs4(q-1,1) = max(c4(:)) / min(length(rr(:,1)),length(rr1(:,1)));
        lcs1(q-1,1) = 1 / lcs1(q-1,1);
        lcs2(q-1,1) = 1 / lcs2(q-1,1);
        lcs3(q-1,1) = 1 / lcs3(q-1,1);
        lcs4(q-1,1) = 1 / lcs4(q-1,1);
    catch exception
        continue;
    end;
end;