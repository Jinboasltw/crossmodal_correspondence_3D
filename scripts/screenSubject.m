%% load
accData = readtable('/Volumes/Data/Project/motion_analysis/scripts/stat/data_acc_beh.csv')
meanData = readtable('/Volumes/Data/Project/motion_analysis/scripts/stat/data_rt_mean_beh.csv')
%% get limit
uplim = mean(table2array(accData))+2.5*std(table2array(accData));
downlim = mean(table2array(accData))-2.5*std(table2array(accData));
%% generate mask
mask = (table2array(accData)<repmat(uplim,size(accData,1),1)).*(table2array(accData)>repmat(downlim,size(accData,1),1));
%% overlap it
checkACC = array2table(table2array(accData).*mask);
checkACC.Properties.VariableNames=accData.Properties.VariableNames;
checkRT = array2table(table2array(meanData).*mask);
checkRT.Properties.VariableNames=meanData.Properties.VariableNames;
%% output
writetable(checkACC,['data_acc_check' '_beh.csv'],'WriteVariableNames', 1,'WriteRowNames',1)
writetable(checkRT,['data_rt_mean_check' '_beh.csv'],'WriteVariableNames', 1,'WriteRowNames',1)