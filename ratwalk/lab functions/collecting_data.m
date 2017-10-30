dataset = load('dataset.mat');
q1=dataset.dataset_dim;
q1=q1';
day1_Dual = [];
day1_Three = [];
day1_Four = [];
for q = 308 : 335
    try    
        clc;
        clearvars -except keepVariables q q1 day1_Dual day1_Three day1_Four;
        close all;
        path1='E:\ratwalk\Study\day1\dim\';
        path2='GOPR0';
        path3=num2str((q));
        path4='.mat';
        filepath=strcat(path1,path2,path3,path4);
        temp = load(filepath);
        [~, dual, three, four, ~] = paw_support(temp.e);
        day1_Dual = [day1_Dual; dual];
        day1_Three = [day1_Three; three];
        day1_Four = [day1_Four; four];
        q = q + 1;
    catch exception
        continue;
    end;
end;
save('dim_paw_support.mat', 'day1_Dual', 'day1_Three', 'day1_Four');

day5_Dual = [];
day5_Three = [];
day5_Four = [];
for q = 389 : 414
    try    
        clc;
        clearvars -except keepVariables q q1 day5_Dual day5_Three day5_Four;
        close all;
        path1='E:\ratwalk\Study\day5\dim\';
        path2='GOPR0';
        path3=num2str((q));
        path4='.mat';
        filepath=strcat(path1,path2,path3,path4);
        temp = load(filepath);
        [~, dual, three, four, ~] = paw_support(temp.e);
        day5_Dual = [day5_Dual; dual];
        day5_Three = [day5_Three; three];
        day5_Four = [day5_Four; four];
        q = q + 1;
    catch exception
        continue;
    end;
end;
save('dim_paw_support.mat', 'day5_Dual', 'day5_Three', 'day5_Four', '-append');


day9_Dual = [];
day9_Three = [];
day9_Four = [];
for q = 467 : 491
    try    
        clc;
        clearvars -except keepVariables q q1 day9_Dual day9_Three day9_Four;
        close all;
        path1='E:\ratwalk\Study\day9\dim\';
        path2='GOPR0';
        path3=num2str((q));
        path4='.mat';
        filepath=strcat(path1,path2,path3,path4);
        temp = load(filepath);
        [~, dual, three, four, ~] = paw_support(temp.e);
        day9_Dual = [day9_Dual; dual];
        day9_Three = [day9_Three; three];
        day9_Four = [day9_Four; four];
        q = q + 1;
    catch exception
        continue;
    end;
end;
save('dim_paw_support.mat', 'day9_Dual', 'day9_Three', 'day9_Four', '-append');


day13_Dual = [];
day13_Three = [];
day13_Four = [];
for q = 540 : 564
    try    
        clc;
        clearvars -except keepVariables q q1 day13_Dual day13_Three day13_Four;
        close all;
        path1='E:\ratwalk\Study\day13\dim\';
        path2='GOPR0';
        path3=num2str((q));
        path4='.mat';
        filepath=strcat(path1,path2,path3,path4);
        temp = load(filepath);
        [~, dual, three, four, ~] = paw_support(temp.e);
        day13_Dual = [day13_Dual; dual];
        day13_Three = [day13_Three; three];
        day13_Four = [day13_Four; four];
        q = q + 1;
    catch exception
        continue;
    end;
end;
save('dim_paw_support.mat', 'day13_Dual', 'day13_Three', 'day13_Four', '-append');