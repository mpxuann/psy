%% PART 1
% Q1
data = readtable('datatest.csv'); 
age = table2array(data(:,82));
valid_age = (age>=16 & age <=70); 
%%%%%%%%%%%%周三班：valid_age = (age>=25 & age <=65); 

% Q2
VCL = table2array(data(:,62:77));
valid_VCL = (VCL(:,6)==0 & VCL(:,9)==0 & VCL(:,12)==0 & VCL(:,1)==1 & VCL(:,4)==1 & VCL(:,10)==1);
%%%%%%%%%%%%周三班：valid_VCL = (VCL(:,6)==0 & VCL(:,9)==0 & VCL(:,11)==0 & VCL(:,1)==1 & VCL(:,4)==1 & VCL(:,10)==1);

% Q3 (可选)
Testelapse = table2array(data(:,50));
surveyelapse = table2array(data(:,51));

[~,idx_test] = sort(Testelapse);
valid_Teste = ones(length(Testelapse),1);
valid_Teste(idx_test(1:250))=0;
valid_Teste(idx_test(4750:5000))=0;

[~,idx_survey] = sort(surveyelapse);
valid_survey = ones(length(surveyelapse),1);
valid_survey(idx_survey(1:250))=0;
valid_survey(idx_survey(4750:5000))=0;

% 标记：valid值计算方法
valid_all = valid_age + valid_VCL + valid_Teste + valid_survey;
valid = valid_all == 4;  % 为三小题全部完成的valid值

% 删除
data(valid==0,:) = [];

%% PART 2
%Q1
RIASEC = table2array(data(:,1:48));
for i = 1:6
    a = (i-1)*8+1;
    b = i*8;
    dim(:,i) = sum(RIASEC(:,a:b),2);
end



% Q2
age = table2array(data(:,82));
age_group = fix((age-16)/5)+1;
%%%%%%%%%%%%周三班：age_group = fix((age-26)/5)+1;

for i = unique(age_group)'
    average_group(i,:) = mean(dim(age_group==i,:));
    %行:组别，列:RIASEC维度
end
save('xxx.mat','average_group');



% Q3 (可选)
country = table2cell(data(:,91));

idx_US = [];
for i = 1:size(data,1)
    if strcmp(country{i},'US') == 1
        idx_US = [idx_US;i];
    end
end

TIPI_US = sum(table2array(data(idx_US,52:61)),2);
gender_US = table2array(data(idx_US,80));

average_male = mean(TIPI_US(gender_US == 1));
average_female = mean(TIPI_US(gender_US == 2));


%% PART 3
% Q1
youngest = average_group(1,:);
figure(1);
plot(youngest);
set(gca,'XTick',1:1:6);
set(gca,'XTickLabel',{'R','I','A','S','E','C'});




