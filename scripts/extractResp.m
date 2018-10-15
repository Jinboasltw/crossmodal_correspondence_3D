function dataSingle = extractResp(data,index)
dataSingle = data(data.task_type == index(1) & data.main_stimulus == index(2) & data.irrelevant_stimulus == index(3),:)
disp('done')
end

