
A = zeros(20:20);
tic
for i = 1:20
    for j = 1:20
        A(i,j) = i+j;
    end
end
toc
