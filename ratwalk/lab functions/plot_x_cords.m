q = 493;
 figure;
while q < 494 
     try   
        clc;
        clearvars -except q;
    %     close all;
        path1='E:\ratwalk\Study\day13\sal\';
        path2='GOPR0';
        path3=num2str(q);
        path4='.mat';
        filepath=strcat(path1,path2,path3,path4);
        temp = load(filepath);
        [lf, rf, lr, rr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(temp.e);
        [lf, rf, lr, rr] = paw_interp(lf, rf, lr, rr);
        hold on; plot((1:length(lf(:,1)))./60,lf(:,1).*(10/182),'green');
        hold on; plot((1:length(rf(:,1)))./60,rf(:,1).*(10/182),'yellow');
        hold on; plot((1:length(lr(:,1)))./60,lr(:,1).*(10/182),'blue');
        hold on; plot((1:length(rr(:,1)))./60,rr(:,1).*(10/182),'red');
        q = q + 1;
     catch exception
         continue;
     end;
end;
 xlabel('Time (seconds)');
 ylabel('Distance (cm)');
 legend('Day 1','Day 5','Day 9','Day 13');   