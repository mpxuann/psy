j = 1;
for i=1:size(age)
    if age(i)>=25 && age(i)<=65
        findage(j) = i;
        j = j+1;
    end
end
