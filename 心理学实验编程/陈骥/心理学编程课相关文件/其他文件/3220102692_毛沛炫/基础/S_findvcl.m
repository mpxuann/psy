j = 1;
for i = 1:size(findage)
    if vcl(findage(i),6) == 1
        continue;
    
    elseif vcl(findage(i),9) == 1
        continue;

    elseif vcl(findage(i),11) == 1
        continue;
    elseif vcl(findage(i),1) == 0
        continue;
    elseif vcl(findage(i),4) == 0
        continue;
    elseif vcl(findage(i),10) == 0
        continue;
    else
        findvcl(j) = findage(i);
        j= j+1;
    end
end