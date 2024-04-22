ave = zeros(6,8);
for k = 3:8
sum26 = 0;
sum31 = 0;
sum36 = 0;
sum41 = 0;
sum46 = 0;
sum51 = 0;
sum56 = 0;
sum61 = 0;
cnt26 = 0;
cnt31 = 0;
cnt36 = 0;
cnt41 = 0;
cnt46 = 0;
cnt51 = 0;
cnt56 = 0;
cnt61 = 0;
for i = 1:size(Arr,1)
    if Arr(i,2)>=26 && Arr(i,2)<=30
        sum26 = sum26+Arr(i,k);
        cnt26 = cnt26+1;
    elseif Arr(i,2)>=31 && Arr(i,2)<=35
        sum31 = sum31+Arr(i,k);
        cnt31 = cnt31+1;
    elseif Arr(i,2)>=36 && Arr(i,2)<=40
        sum36 = sum36+Arr(i,k);
        cnt36 = cnt36+1;
    elseif Arr(i,2)>=41 && Arr(i,2)<=45
        sum41 = sum41+Arr(i,k);
        cnt41 = cnt41+1;
    elseif Arr(i,2)>=46 && Arr(i,2)<=50
        sum46 = sum46+Arr(i,k);
        cnt46 = cnt46+1;
    elseif Arr(i,2)>=51 && Arr(i,2)<=55
        sum51 = sum51+Arr(i,k);
        cnt51 = cnt51+1;
    elseif Arr(i,2)>=56 && Arr(i,2)<=60
        sum56 = sum56+Arr(i,k);
        cnt56 = cnt56+1;
    elseif Arr(i,2)>=61 && Arr(i,2)<=65
        sum61 = sum61+Arr(i,k);
        cnt61 = cnt61+1;
    end
end
    ave(k-2,1) = sum26/cnt26;
    ave(k-2,2) = sum31/cnt31;
    ave(k-2,3) = sum36/cnt36;
    ave(k-2,4) = sum41/cnt41;
    ave(k-2,5) = sum46/cnt46;
    ave(k-2,6) = sum51/cnt51;
    ave(k-2,7) = sum56/cnt56;
    ave(k-2,8) = sum61/cnt61;
end
    
    