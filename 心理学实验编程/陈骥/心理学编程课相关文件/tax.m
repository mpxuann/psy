n = input('input your income:');
if n<2000
    disp('免税')
elseif n>=2000 && n<=5000
    m = 0.02 * (n-2000);
    fprintf('税收为%d\n',m);
    
else
    m = 0.05 * (n-5000);
    fprintf('税收为%d\n',m+120);
end
