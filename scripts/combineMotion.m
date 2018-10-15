function cond = combineMotion( temp )

cond(:,1) = mean([temp(:,1),temp(:,5)],2);
cond(:,2) = mean([temp(:,2),temp(:,4)],2);
cond(:,3) = mean([temp(:,3),temp(:,6)],2);
cond(:,4) = mean([temp(:,7),temp(:,11)],2);
cond(:,5) = mean([temp(:,8),temp(:,10)],2);
cond(:,6) = mean([temp(:,9),temp(:,12)],2);

end

