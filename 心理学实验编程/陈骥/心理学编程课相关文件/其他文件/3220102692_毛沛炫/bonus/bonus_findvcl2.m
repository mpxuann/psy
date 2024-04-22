j = 1;
for i = 1:size(findvcl)
    if(index_time(findvcl(i),1) ~=0)
        findvcl2(j) = findvcl(i);
        j = j+1;
    end
end
findvcl2 = findvcl2';
