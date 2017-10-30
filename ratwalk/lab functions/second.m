function y=second(handles)

clc;

global filename_load pathname_load
flag_IsCell = iscell(filename_load);
if flag_IsCell == 1
    for i = 1:size(filename_load,2)
        vidDevice1(i,:) = char(strcat(pathname_load, filename_load(i)));
    end;
else
    vidDevice1 = strcat(pathname_load, filename_load);
end;
assignin('base','vidDevice1',vidDevice1);
set(handles.table,'Data',[]);
[busyFig msgHandle] = busyVibes('Busy','I am working on a task', 1, 0.5);
for i = 1 : size(vidDevice1,1)
    try
flag_filetype = 0;
vidDevice2 = vidDevice1(i,:);
set(handles.path,'String',vidDevice2);
if vidDevice2(length(vidDevice2)-3:length(vidDevice2)) == '.MP4'
    flag_filetype = 1;
end;

if vidDevice2(length(vidDevice2)-3:length(vidDevice2)) == '.mp4'  
    flag_filetype = 1;
end;

if vidDevice2(length(vidDevice2)-3:length(vidDevice2)) == '.mat'
    flag_filetype = 2;
end;
assignin('base','flag_filetype',flag_filetype);
flag=get(handles.flag,'String');
flag=str2double(flag);
flag_rf=get(handles.paw_rf,'Value');
flag_lf=get(handles.paw_lf,'Value');
flag_rr=get(handles.paw_rr,'Value');
flag_lr=get(handles.paw_lr,'Value');
flag_save=get(handles.Save,'Value');
intensity_frame_no = get(handles.frame_no,'String');
flag_intensity_images = get(handles.intensity_images, 'Value');

if flag>1

    if flag == 2 && flag_filetype == 1 
        [EnhancedChange, e, y1, y2, track_factor] = ratwalk(vidDevice2);
        save_path = strcat(vidDevice2(1:length(vidDevice2)-3),'mat');
        save(strcat(save_path),'e','EnhancedChange','y1','y2','track_factor');
       
        set(handles.axes1);
        implay(EnhancedChange);
    
    end;
    
    if flag == 2 && flag_filetype == 2
        temp = load(vidDevice2);
        
        set(handles.axes1);
        implay(temp.EnhancedChange);
    end;
    
   
%% tabling step data
if flag == 4 
    cnames={'LF-stride length (cm)','RF-stride length (cm)','LR-stride length (cm)','RR-stride length (cm)', 'Diag Stride L2R (cm)', 'Diag Stride R2L (cm)'};

    if flag_filetype == 1
        [rf, lf, rr, lr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(e);
        [lf_step, rf_step, lr_step, rr_step ] = relevant_strides( lf_step, rf_step, lr_step, rr_step, temp.track_factor);
        [ diag_step_l2r, diag_step_r2l ] = diag_stride(e, lr, rr, temp.track_factor);
    end;
    if flag_filetype == 2
        temp = load(vidDevice2);
        [rf, lf, rr, lr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(temp.e);
        [lf_step, rf_step, lr_step, rr_step ] = relevant_strides( lf_step, rf_step, lr_step, rr_step, temp.track_factor);
        [ diag_step_l2r, diag_step_r2l ] = diag_stride(temp.e, lr, rr, temp.track_factor);
    end;
    data2 = padconcat(padconcat(padconcat(padconcat(padconcat(lf_step,rf_step,2),lr_step,2),rr_step,2),diag_step_l2r,2),diag_step_r2l,2);
        assignin('base','data2',data2);

    data1 = get(handles.table,'Data');
    assignin('base','data1',data1);
    k = size(data1,1)+1; % Which row number does the new row get
    if k == 1 % Data is converted the first time, but only needs one
        data = data1;
    else
        data = cell2mat(data1);
    end
    data = padconcat(data, data2, 1);
    data = num2cell(data);
%     data(cellfun(@isnan,data)) = {[]};
    
    set(handles.table,'Data',data,'ColumnName',cnames);
  
end;

%% paw_intensity

if flag == 3
    if flag_filetype == 1
       [rf, lf, rr, lr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(e);
       [lf_intens, lf_intens_total, lf_intens_mean, lf_intens_area, rf_intens, rf_intens_total, rf_intens_mean, rf_intens_area, lr_intens, lr_intens_total, lr_intens_mean, lr_intens_area, rr_intens, rr_intens_total, rr_intens_mean, rr_intens_area ] = intensity( lf, rf, lr, rr, EnhancedChange );
    end;
    if flag_filetype == 2
       temp = load(vidDevice2);
       [rf, lf, rr, lr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(temp.e);
       [lf_intens, lf_intens_total, lf_intens_mean, lf_intens_area, rf_intens, rf_intens_total, rf_intens_mean, rf_intens_area, lr_intens, lr_intens_total, lr_intens_mean, lr_intens_area, rr_intens, rr_intens_total, rr_intens_mean, rr_intens_area ] = intensity( lf, rf, lr, rr, temp.EnhancedChange );
    end;
    if flag_lf == 1
       cnames={'Total Intensity','Mean Intensity','Intensity Area'};
       data2 = [lf_intens_total, lf_intens_mean, lf_intens_area];
       data1 = get(handles.table,'Data');
    assignin('base','data1',data1);
    k = size(data1,1)+1; % Which row number does the new row get
    if k == 1 % Data is converted the first time, but only needs one
        data = data1;
    else
        data = cell2mat(data1);
    end
    data = [data; data2];
    data = num2cell(data);
       set(handles.table, 'Data', data,'ColumnName',cnames);
       if flag_intensity_images == 1
       clear x;
       x=find(lf(:,1));
       rect=double(lf_intens);
       flag_intensity_frame = strcmp(intensity_frame_no, 'enter frame number');
       if flag_intensity_frame == 1
           rand5 = 1 :40: length(x);
    %        rand5 = randi([1, length(x)], 5);
            for i=1:length(rand5)
                rect_ins(:,:)=rect(:,:,x(rand5(i)));
                [x3, y3]=meshgrid(1:1:21);
                [x2, y2]=meshgrid(1:.1:21);
                rect_int=interp2(x3,y3,rect_ins,x2,y2,'spline');
                set(handles.axes1);
                figure,surf(rect_int);
            end; 
       else 
           rand5 = str2num(intensity_frame_no);
           rect_ins(:,:)=rect(:,:,x(rand5));
           [x3, y3]=meshgrid(1:1:21);
           [x2, y2]=meshgrid(1:.1:21);
           rect_int=interp2(x3,y3,rect_ins,x2,y2,'spline');
           set(handles.axes1);
           figure,surf(rect_int);
       end;
    end;
    end;
    if flag_rf == 1
       cnames={'Total Intensity','Mean Intensity','Intensity Area'};
              data2 = [rf_intens_total, rf_intens_mean, rf_intens_area];
       data1 = get(handles.table,'Data');
    assignin('base','data1',data1);
    k = size(data1,1)+1; % Which row number does the new row get
    if k == 1 % Data is converted the first time, but only needs one
        data = data1;
    else
        data = cell2mat(data1);
    end
    data = [data; data2];
       set(handles.table, 'Data', data,'ColumnName',cnames);
       if flag_intensity_images == 1
       clear x;
       x=find(rf(:,1));
       rect=double(rf_intens);
       flag_intensity_frame = strcmp(intensity_frame_no, 'enter frame number');
       if flag_intensity_frame == 1
           rand5 = 1 :40: length(x);
            for i=1:length(rand5)
                rect_ins(:,:)=rect(:,:,x(rand5(i)));
                [x3, y3]=meshgrid(1:1:21);
                [x2, y2]=meshgrid(1:.1:21);
                rect_int=interp2(x3,y3,rect_ins,x2,y2,'spline');
                set(handles.axes1);
                figure,surf(rect_int);
            end;  
       else
           rand5 = str2num(intensity_frame_no);
           rect_ins(:,:)=rect(:,:,x(rand5));
           [x3, y3]=meshgrid(1:1:21);
           [x2, y2]=meshgrid(1:.1:21);
           rect_int=interp2(x3,y3,rect_ins,x2,y2,'spline');
           set(handles.axes1);
           figure,surf(rect_int);
       end;
    end;
    end;
    if flag_lr == 1
       cnames={'Total Intensity','Mean Intensity','Intensity Area'};
              data2 = [lr_intens_total, lr_intens_mean, lr_intens_area];
       data1 = get(handles.table,'Data');
    assignin('base','data1',data1);
    k = size(data1,1)+1; % Which row number does the new row get
    if k == 1 % Data is converted the first time, but only needs one
        data = data1;
    else
        data = cell2mat(data1);
    end
    data = [data; data2];
       set(handles.table, 'Data', data,'ColumnName',cnames);
       if flag_intensity_images == 1
       clear x;
       x=find(lr(:,1));
       rect=double(lr_intens);
       flag_intensity_frame = strcmp(intensity_frame_no, 'enter frame number');
       if flag_intensity_frame == 1
           rand5 = 1 :40: length(x);
            for i=1:length(rand5)
                rect_ins(:,:)=rect(:,:,x(rand5(i)));
                [x3, y3]=meshgrid(1:1:21);
                [x2, y2]=meshgrid(1:.1:21);
                rect_int=interp2(x3,y3,rect_ins,x2,y2,'spline');
                set(handles.axes1);
                figure,surf(rect_int);
            end;
       else
           rand5 = str2num(intensity_frame_no);
           rect_ins(:,:)=rect(:,:,x(rand5));
           [x3, y3]=meshgrid(1:1:21);
           [x2, y2]=meshgrid(1:.1:21);
           rect_int=interp2(x3,y3,rect_ins,x2,y2,'spline');
           set(handles.axes1);
           figure,surf(rect_int);
       end;
    end;
    end;
    if flag_rr == 1
       cnames={'Total Intensity','Mean Intensity','Intensity Area'};
              data2 = [rr_intens_total, rr_intens_mean, rr_intens_area];
       data1 = get(handles.table,'Data');
    assignin('base','data1',data1);
    k = size(data1,1)+1; % Which row number does the new row get
    if k == 1 % Data is converted the first time, but only needs one
        data = data1;
    else
        data = cell2mat(data1);
    end
    data = [data; data2];
       set(handles.table, 'Data', data,'ColumnName',cnames);   
       if flag_intensity_images == 1
       clear x;
       x=find(rr(:,1));
       rect=double(rr_intens);
       flag_intensity_frame = strcmp(intensity_frame_no, 'enter frame number');
       if flag_intensity_frame == 1
           rand5 = 1 :40: length(x);
            for i=1:length(rand5)
                rect_ins(:,:)=rect(:,:,x(rand5(i)));
                [x3, y3]=meshgrid(1:1:21);
                [x2, y2]=meshgrid(1:.1:21);
                rect_int=interp2(x3,y3,rect_ins,x2,y2,'spline');
                set(handles.axes1);
                figure,surf(rect_int);
            end;  
       else
           rand5 = str2num(intensity_frame_no);
           rect_ins(:,:)=rect(:,:,x(rand5));
           [x3, y3]=meshgrid(1:1:21);
           [x2, y2]=meshgrid(1:.1:21);
           rect_int=interp2(x3,y3,rect_ins,x2,y2,'spline');
           set(handles.axes1);
           figure,surf(rect_int);
       end;
    end;
    end;
    
end;
%% Composite

if flag == 5  
    if flag_filetype == 1
       [rf, lf, rr, lr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(e);
       [lf_intens, lf_intens_total, lf_intens_mean, lf_intens_area, rf_intens, rf_intens_total, rf_intens_mean, rf_intens_area, lr_intens, lr_intens_total, lr_intens_mean, lr_intens_area, rr_intens, rr_intens_total, rr_intens_mean, rr_intens_area ] = intensity( lf, rf, lr, rr, EnhancedChange );
       set(handles.axes1);
       [~, ~, ~, ~] = footprint(e);
    end;
    if flag_filetype == 2
       temp = load(vidDevice2);
       [rf, lf, rr, lr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(temp.e);
       [lf_intens, lf_intens_total, lf_intens_mean, lf_intens_area, rf_intens, rf_intens_total, rf_intens_mean, rf_intens_area, lr_intens, lr_intens_total, lr_intens_mean, lr_intens_area, rr_intens, rr_intens_total, rr_intens_mean, rr_intens_area ] = intensity( lf, rf, lr, rr, temp.EnhancedChange );
       k2 = load('compo_bg.mat');
       k2 = k2.k6;
       set(handles.axes1);
       [~, ~, ~, ~] = footprint(temp.e);
    end;
 
 
    
    
    %Plotting lf on strip
    if flag_lf == 1
        clear x;
        x=find(lf(:,1));
        rect = double(lf_intens);
        for i = 1 : length(x)
            i1 = x(i);
            k1 = rect(:,:,i1);
            x1 = lf(i1,2);
            y1 = lf(i1,1);
            for i2 = x1-7 : x1+7
                for j2 = y1-7 : y1+7
                    k2(i2+503,j2,3)=k1(i2+11-x1,j2+11-y1);
                end;
            end;
        end;   
     end;
     
     %Plotting rf on strip
      if flag_rf==1
        clear x;
        x=find(rf(:,1));
        rect = double(rf_intens);
        for i = 1 : length(x)
            i1 = x(i);
            k1 = rect(:,:,i1);
            x1 = rf(i1,2);
            y1 = rf(i1,1);
            for i2 = x1-7 : x1+7
                for j2 = y1-7 : y1+7
                    k2(i2+503,j2,2)=k1(i2+11-x1,j2+11-y1);
                end;
            end;
        end;
      end;
            
   %Plotting lr on strip
      if flag_lr==1
        clear x;
        x=find(lr(:,1));
        rect = double(lr_intens);
        for i = 1 : length(x)
            i1 = x(i);
            k1 = rect(:,:,i1);
            x1 = lr(i1,2);
            y1 = lr(i1,1);
            for i2 = x1-7 : x1+7
                for j2 = y1-7 : y1+7
                    k2(i2+503,j2,1)=k1(i2+11-x1,j2+11-y1);
                end;
            end;
        end;
     end;

     %Plotting rr on strip
      if flag_rr==1
        clear x;
        x=find(rr(:,1));
        rect = double(rr_intens);
        for i = 1 : length(x)
            i1 = x(i);
            k1 = rect(:,:,i1);
            x1 = rr(i1,2);
            y1 = rr(i1,1);
            for i2 = x1-7 : x1+7
                for j2 = y1-7 : y1+7
                    k2(i2+503,j2,1)=k1(i2+11-x1,j2+11-y1); 
                    k2(i2+503,j2,2)=k1(i2+11-x1,j2+11-y1);
                end;
            end;
        end;
      end;
     
set(handles.axes1);
figure,imshow(k2);
dragzoom

end;

%% Swing and Stop Time
if flag == 6 
    cnames={'LF-Swing (sec)','RF-Swing (sec)','LR-Swing (sec)','RR-Swing (sec)','LF-Stop (sec)','RF-Stop (sec)','LR-Stop (sec)','RR-Stop (sec)'};
%     cnames={'LF_swing'};
    if flag_filetype == 1
       [rf, lf, rr, lr, ~, ~, ~, ~] = recog_four_paw(e);
       [lf_swing,lr_swing,rf_swing,rr_swing,lf_stop,lr_stop,rf_stop,rr_stop] = swing_time(lf, lr, rf, rr);
    end;
    if flag_filetype == 2
        temp = load(vidDevice2);
        [rf, lf, rr, lr, ~, ~, ~, ~] = recog_four_paw(temp.e);
        [lf_swing,lr_swing,rf_swing,rr_swing,lf_stop,lr_stop,rf_stop,rr_stop] = swing_time(lf, lr, rf, rr);
    end;
    data2 = padconcat(padconcat(padconcat(padconcat(padconcat(padconcat(padconcat(lf_swing,rr_stop,2),lr_stop,2),rf_stop,2),lf_stop,2),rr_swing,2),lr_swing,2),rf_swing,2);
    data1 = get(handles.table,'Data');
    assignin('base','data1',data1);
    k = size(data1,1)+1; % Which row number does the new row get
    if k == 1 % Data is converted the first time, but only needs one
        data = data1;
    else
        data = cell2mat(data1);
    end
    data = padconcat(data, data2, 1);
    data = num2cell(data);
%     data(cellfun(@isnan,data)) = {[]};
    
    set(handles.table,'Data',data,'ColumnName',cnames);
%   set(handles.table,'Data',lf_swing,'ColumnName',cnames);
end;
%% Distance  vs Time Plot
if flag == 7
    if flag_filetype == 1
        [rf, lf, rr, lr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(e);
    end;
    if flag_filetype == 2
       temp = load(vidDevice2);
       [rf, lf, rr, lr, lf_step, rf_step, lr_step, rr_step] = recog_four_paw(temp.e);
    end;
   
    [lf, rf, lr, rr] = paw_interp(lf, rf, lr, rr);
    
    set(handles.axes1);
    figure;
    hold on; plot((1:length(lf))./60,lf(:,1).*(10/182),'Blue');
    hold on; plot((1:length(lf))./60,rf(:,1).*(10/182),'Green');
    hold on; plot((1:length(lf))./60,lr(:,1).*(10/182),'Red');
    hold on; plot((1:length(lf))./60,rr(:,1).*(10/182),'Yellow');
    legend({'LF','RF','LR','RR'},'FontSize',22);
    xlabel('Time (seconds)','FontSize',22);
    ylabel('Distance (cm)','FontSize',22);
end;

%% Swing Speed 
if flag == 8 
    cnames={'LF-Swing Speed (cm/sec)','RF-Swing Speed (cm/sec)','LR-Swing Speed (cm/sec)','RR-Swing Speed (cm/sec)'};
    
    if flag_filetype == 1
    [swing_speed_lf, swing_speed_rf, swing_speed_lr, swing_speed_rr] = swing_speed(e);
    end;
    if flag_filetype == 2
        temp = load(vidDevice2);
        [swing_speed_lf, swing_speed_rf, swing_speed_lr, swing_speed_rr] = swing_speed(temp.e);
    end;
    data2 = padconcat(padconcat(padconcat(swing_speed_lf,swing_speed_rf,2),swing_speed_lr,2),swing_speed_rr,2);
    data1 = get(handles.table,'Data');
    assignin('base','data1',data1);
    k = size(data1,1)+1; % Which row number does the new row get
    if k == 1 % Data is converted the first time, but only needs one
        data = data1;
    else
        data = cell2mat(data1);
    end
    data = padconcat(data, data2, 1);
    data = num2cell(data);
    
%     data(cellfun(@isnan,data)) = {[]};
    set(handles.table,'Data',data,'ColumnName',cnames);
%   set(handles.table,'Data',lf_swing,'ColumnName',cnames);
end;

%% Duty Cycle and Step Cycle
if flag == 9 
    cnames={'LF-Duty Cycle (%)','RF-Duty Cycle (%)','LR-Duty Cycle (%)','RR-Duty Cycle (%)','LF-Step Cycle (sec)','RF-Step Cycle (sec)','LR-Step Cycle (sec)','RR-Step Cycle (sec)'};
%     cnames={'LF_swing'};
    if flag_filetype == 1
       [lf_duty_cycle, rf_duty_cycle, lr_duty_cycle, rr_duty_cycle, lf_step_cycle, rf_step_cycle, lr_step_cycle, rr_step_cycle ] = duty_step_cycle(e);
    end;
    if flag_filetype == 2
        temp = load(vidDevice2);
        [lf_duty_cycle, rf_duty_cycle, lr_duty_cycle, rr_duty_cycle, lf_step_cycle, rf_step_cycle, lr_step_cycle, rr_step_cycle ] = duty_step_cycle(temp.e);
    end;
    data2 = padconcat(padconcat(padconcat(padconcat(padconcat(padconcat(padconcat(lf_duty_cycle,rr_duty_cycle,2),lr_duty_cycle,2),rf_duty_cycle,2),lf_step_cycle,2),rr_step_cycle,2),lr_step_cycle,2),rf_step_cycle,2);
    data1 = get(handles.table,'Data');
    assignin('base','data1',data1);
    k = size(data1,1)+1; % Which row number does the new row get
    if k == 1 % Data is converted the first time, but only needs one
        data = data1;
    else
        data = cell2mat(data1);
    end
    data = padconcat(data, data2, 1);
    data = num2cell(data);
    
%     data(cellfun(@isnan,data)) = {[]};
    set(handles.table,'Data',data,'ColumnName',cnames);
%   set(handles.table,'Data',lf_swing,'ColumnName',cnames);
end;

%% Run Duration

if flag == 10 
    cnames={'Run Duration (sec)','Cadence (steps/sec)','Base of Support (cm)'};

    if flag_filetype == 1
       [run_time, cadence, base_of_support] = run_duration(e);
    end;
    if flag_filetype == 2
        temp = load(vidDevice2);
        [run_time, cadence, base_of_support] = run_duration(temp.e);
    end;
    data2 = padconcat(padconcat(run_time,cadence,2),base_of_support,2);
    data1 = get(handles.table,'Data');
    assignin('base','data1',data1);
    k = size(data1,1)+1; % Which row number does the new row get
    if k == 1 % Data is converted the first time, but only needs one
        data = data1;
    else
        data = cell2mat(data1);
    end
    data = padconcat(data, data2, 1);
    data = num2cell(data);
    
%     data(cellfun(@isnan,data)) = {[]};
    set(handles.table,'Data',data,'ColumnName',cnames);
%   set(handles.table,'Data',lf_swing,'ColumnName',cnames);
end;

%% Paw Support

if flag == 11 
    cnames={'Diagonal Dual Support (%)','Three Point Support (%)','Four Point Support (%)'};

    if flag_filetype == 1
       [~, diagonal_dual_support, three_point_support, four_point_support, ~] = paw_support(e);
    end;
    if flag_filetype == 2
        temp = load(vidDevice2);
        [~, diagonal_dual_support, three_point_support, four_point_support, ~] = paw_support(temp.e);
    end;
    data2 = padconcat(padconcat(diagonal_dual_support,three_point_support,2),four_point_support,2);
    assignin('base','data2',data2);
    data1 = get(handles.table,'Data');
    assignin('base','data1',data1);
    k = size(data1,1)+1; % Which row number does the new row get
    if k == 1 % Data is converted the first time, but only needs one
        data = data1;
    else
        data = cell2mat(data1);
    end
        assignin('base','data11',data1);
    data = padconcat(data, data2, 1);
        assignin('base','data',data);
    data = num2cell(data);

%     data(cellfun(@isnan,data)) = {[]};
    set(handles.table,'Data',data,'ColumnName',cnames);
%   set(handles.table,'Data',lf_swing,'ColumnName',cnames);
end;

%% Save Data
if flag_save == 1
    [save_filename, save_pathname] = uiputfile({'*.csv';'*.mat'},'Save Data');
    if save_filename(length(save_filename)-3:length(save_filename)) == '.mat'
        if flag == 2
            save(strcat(save_pathname,save_filename),'e','EnhancedChange','y1','y2','track_factor');
        elseif flag == 3
            save(strcat(save_pathname,save_filename), 'lf_intens_total', 'lf_intens_mean', 'lf_intens_area', 'rf_intens_total', 'rf_intens_mean', 'rf_intens_area', 'lr_intens_total', 'lr_intens_mean', 'lr_intens_area', 'rr_intens_total', 'rr_intens_mean', 'rr_intens_area');
        elseif flag == 4
            save(strcat(save_pathname,save_filename),'lf_step', 'rf_step', 'lr_step', 'rr_step', 'diag_step');
        elseif flag == 6
            save(strcat(save_pathname,save_filename), 'lf_swing', 'lr_swing', 'rf_swing', 'rr_swing', 'lf_stop', 'lr_stop', 'rf_stop', 'rr_stop');
        else
            ;
        end;
    end;
    
    if save_filename(length(save_filename)-3:length(save_filename)) == '.csv' 
        if flag == 3
            if flag_lf == 1
            headers = {'lf_intens_total', 'lf_intens_mean', 'lf_intens_area'};  
            csvwrite_with_headers(strcat(save_pathname,save_filename), [lf_intens_total, lf_intens_mean, lf_intens_area], headers);
            end;
            if flag_rf == 1
            headers = {'rf_intens_total', 'rf_intens_mean', 'rf_intens_area'};  
            csvwrite_with_headers(strcat(save_pathname,save_filename), [rf_intens_total, rf_intens_mean, rf_intens_area], headers);
            end;
            if flag_lr == 1
            headers = {'lr_intens_total', 'lr_intens_mean', 'lr_intens_area'};  
            csvwrite_with_headers(strcat(save_pathname,save_filename), [lr_intens_total, lr_intens_mean, lr_intens_area], headers);
            end;
            if flag_rr == 1
            headers = {'rr_intens_total', 'rr_intens_mean', 'rr_intens_area'};  
            csvwrite_with_headers(strcat(save_pathname,save_filename), [rr_intens_total, rr_intens_mean, rr_intens_area], headers);
            end;
        elseif flag == 4
            headers = {'LF step', 'RF step', 'LR step', 'RR step', 'Diag step'};
            data = padconcat(padconcat(padconcat(padconcat(lf_step,rf_step,2),lr_step,2),rr_step,2),diag_step,2);
%             data = num2cell(data);
%             data(cellfun(@isnan,data)) = {[]};
            csvwrite_with_headers(strcat(save_pathname,save_filename),data,headers);
%             cell2csv(strcat(save_pathname,save(filename)),data);
        elseif flag == 6
            headers = {'LF-Swing','RF-Swing','LR-Swing','RR-Swing','LF-Stop','RF-Stop','LR-Stop','RR-Stop'};
            data = padconcat(padconcat(padconcat(padconcat(padconcat(padconcat(padconcat(lf_swing,rr_stop,2),lr_stop,2),rf_stop,2),lf_stop,2),rr_swing,2),lr_swing,2),rf_swing,2);
%             data = num2cell(data);
%             data(cellfun(@isnan,data)) = {[]};
            csvwrite_with_headers(strcat(save_pathname,save_filename),data,headers);
%             cell2csv(strcat(save_pathname,save_filename),data);
        else
            ;
        end;
    end;
end;

else
        close(busyFig);

end;
    catch exception
        continue;
    end;
    
end;
    close(busyFig);