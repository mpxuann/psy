ls=readtable("life_satisfaction.csv");
ls=table2array(ls);
for i=1:size(ls,1)
for j=3:4
if ls(i,j)==1
fprintf('subject %d failed on tests\n',i)%flag out subjects who failed on either or both tests
break
end
end
if ls(i,2)>1000
    fprintf('subject %d has very long response time\n',i)%jump over subjects who have usual response time
    continue
elseif ls(i,2)<50
    fprintf('subject %d has very short response time\n',i)
    continue
end
ls(i,10)=sum(ls(i,5:9));
end
