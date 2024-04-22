j= 1;
for i = 1:size(findvcl)
    sumR(j) = sum(riasec(findvcl(i),1:8));
    sumI(j) = sum(riasec(findvcl(i),9:16));
    sumA(j) = sum(riasec(findvcl(i),17:24));
    sumS(j) = sum(riasec(findvcl(i),25:32));
    sumE(j) = sum(riasec(findvcl(i),33:40));
    sumC(j) = sum(riasec(findvcl(i),41:48));
    j = j+1;
end
sumR = sumR';
sumI = sumI';
sumA = sumA';
sumS = sumS';
sumE = sumE';
sumC = sumC';
    
    