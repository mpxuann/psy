time = table2array(T(:,50:51));
index = [1:5000]';
index_time = cat(2,index,time);
sortA = sort(index_time(:,2));
sortB = sort(index_time(:,3));
for i =1:size(index_time)
    if index_time(i,2)<=119 || index_time(i,2)>=837
        index_time(i,1) = 0;
    elseif index_time(i,3)<=100 || index_time(i,3)>=540
        index_time(i,1) = 0;
    end
end
