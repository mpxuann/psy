for i = 1:size(a,1)
    if a(i)<=30
        b(i) = "young";
    elseif a(i)>30 && a(i)<=60
        b(i) = "not old";
    else
        b(i) = "old";
    end
end