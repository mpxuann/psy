
j = 1;
for i = 1:size(findvcl)
    T2(j,1) = findvcl(i);
    T2(j,2) = age(findvcl(i));
    T2(j,3) = sumR(j);
    T2(j,4) = sumI(j);
    T2(j,5) = sumA(j);
    T2(j,6) = sumS(j);
    T2(j,7) = sumE(j);
    T2(j,8) = sumC(j);
    j = j+1;
end
