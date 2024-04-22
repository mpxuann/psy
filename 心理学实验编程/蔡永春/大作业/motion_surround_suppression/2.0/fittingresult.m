%% 拟合曲线
function fittingresult(subject,blocks)

for n = 1:blocks
    load([subject '_paramatrix_' int2str(n)]);
    
    rawdata = []; % column 1 刺激大小; % column 2 按键反应
    resdata = [];
    
    rawdata(:,1) = paramatrix(:,3); % stimSize
    rawdata(:,2) = paramatrix(:,8); % response
    rawdata(:,3) = paramatrix(:,9); % response time

    resdata(:,1) = unique(rawdata(:,1));% 找出刺激并顺次排列
    
    for i = 1: length(resdata(:,1)) 
        resdata(i,2) = length(find(rawdata(:,1)==resdata(i,1)&rawdata(:,2)==1)); % 第二列放该行刺激强度正确的试次
        resdata(i,3) = length(find(rawdata(:,1)==resdata(i,1)));% 第三列放该行刺激强度所有的试次
        resdata(i,5) = mean(paramatrix(rawdata(:,1)==resdata(i,1)&rawdata(:,2)==1,9));%第五列放平均反应时
    end
    
    resdata(:,4) = resdata(:,2)./resdata(:,3);% 正确率
    
    StimStrength=resdata(:,1);
    RespAccuracy=resdata(:,4);
    RespTime=resdata(:,5);
    
    close all;
    linecolorr=[0 0 1];
    dotcolorr=[0.5 0.5 0.8];
    linestyle='-';
    
    hold on
    plot(StimStrength,1000*RespTime,'LineWidth',0.5,'Color',linecolorr,'LineStyle',linestyle);
    scatter(StimStrength,1000*RespTime,100*(RespAccuracy.^2),'ro','MarkerFaceColor',dotcolorr,'MarkerEdgeColor','none');
    legend('RespTime','Acurracy');
    ylabel('response time (ms)');
    xlabel('Size (SD of the Guassian Gabor)');
    
    savefig([subject '_figure_' int2str(n)]);

    close all;
end
