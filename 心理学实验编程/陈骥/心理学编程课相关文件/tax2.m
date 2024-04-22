n = input('input your income:');
if n<2000
    b = 0;
elseif n>=2000 && n<=5000
    b = 1;
else
    b = 2;
end

switch b

case 0
    disp('免税')
case 1
    m = 0.02 * (n-2000);
    disp('税收为')
    disp(m)
otherwise
    m = 0.05 * (n-5000);
    disp('税收为')
    disp(m+60+60)
end



