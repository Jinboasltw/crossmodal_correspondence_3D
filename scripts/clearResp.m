function clearRT = clearResp(data_single,limitRange,id)
clearRT = data_single.RT(data_single.RT >= limitRange(id,1) & data_single.RT <= limitRange(id,2));
disp('done')
end

