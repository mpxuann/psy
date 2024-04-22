for i = 1:size(A,1)
    if A(i,3)+A(i,4)<4
        ;
    elseif A(i,2)>1000 || A(i,2)<50
        ;
    else
        S = 0;
        for j = 5:9
            S = S+A(i,j);
        end
        fprintf('%d %d\n',i,S);
    end
end
