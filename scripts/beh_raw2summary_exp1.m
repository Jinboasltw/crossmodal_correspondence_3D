%% zero the world
clear, clc, close all
%% work path setup
work_dir = '/Volumes/Data/Project/motion_data/';
% import
[targetData, ~] = kb_ls([work_dir 'sub*' filesep '*.csv']);

%[targetData, ~] = kb_ls([pwd filesep 'data' filesep '*.csv']);
for ii=1:numel(targetData)
    rawData = readtable(targetData{ii});
    %% ACC
    temp = rawData(rawData.RT >= 100 & rawData.RT <= 2000,:);
    [ACC, grp]= grpstats(temp.ACC, {temp.task_type,temp.main_stimulus,temp.irrelevant_stimulus},{'mean','gname'});
    reportACC = [str2num(cell2mat(grp)), ACC]';
    
    %% RT
    clear temp i j k l
    l=1; % setup for summary data
    temp = rawData(rawData.RT >= 100 & rawData.RT <= 1500 & rawData.ACC == 1, :);
    [rt_mean, rt_std, ~] = grpstats(temp.RT, {temp.task_type,temp.main_stimulus,temp.irrelevant_stimulus},{'mean','std', 'gname'});
    sd_2_5 = [rt_mean-2.5*rt_std rt_mean+2.5*rt_std];
    for i=1:2
        for j=1:2
            for k=1:3
                disp([i j k]);
                temp_single = extractResp(temp,[i j k]);
                clearTemp = clearResp(temp_single,sd_2_5,l);
                meanData(l)=mean(clearTemp);
                medianData(l)=median(clearTemp);
                l=l+1;
                clear temp_single clearTemp
            end
        end
    end
    %% report
    % checked with Exp1 Code
    
    %%
    % 
    %#------------------------- Target Button Setting -----------
    %int mn = 1;
    %int mf = 2;
    %int si = 1;
    %int sd = 2;
    % 
    %% see code first
    grp
    %% naming code
    cond_name = {...,
        'motion_motion_near_sound_increase'...,
        'motion_motion_near_sound_decrease'...,
        'motion_motion_near_no'...,
        'motion_motion_far_sound_increase'...,
        'motion_motion_far_sound_decrease'...,
        'motion_motion_far_no'...,
        'snd_snd_increase_motion_near'...,
        'snd_snd_increase_motion_far'...,
        'snd_snd_increase_no'...,
        'snd_snd_decrease_motion_near'...,
        'snd_snd_decrease_motion_far'...,
        'snd_snd_decrease_no'...,
        };
    
    %% report
    reportResults = [reportACC;meanData;medianData];
    tempReport = array2table(reportResults);
    tempReport.Properties.VariableNames = cond_name;
    tempReport.Properties.RowNames = {'code';'acc';'mean';'median'};
    writetable(tempReport,['sub_' sprintf('%02d',ii) '_beh.csv'],'WriteVariableNames', 1,'WriteRowNames',1)
end