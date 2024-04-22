function RT_fittingresult(subject,num)

load([subject '_paramatrix_' int2str(num)]);

for i = 1:length(paramatrix)
    if paramatrix(i,2)==-1 && paramatrix(i,6)==1 
        paramatrix(i,7) = 1;
    else 
        paramatrix(i,7) = 0;
    end
end
csvwrite([subject '_paramatrix_' int2str(num) '.csv'],paramatrix);
data = paramatrix(paramatrix(:,7)==1,5);
histogram(data);
fprintf('mean = %.4f\n',mean(data));
fprintf('var = %.4f\n',var(data));

end