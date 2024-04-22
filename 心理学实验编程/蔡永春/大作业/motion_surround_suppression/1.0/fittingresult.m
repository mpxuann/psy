%% 拟合曲线
function fittingresult(subject,blocks)
%FITTINGRESUTL 此处显示有关此函数的摘要
%   此处显示详细说明
for n = 1:blocks
    load([subject '_paramatrix_' int2str(n)]);
    
    rawdata = []; % column 1 刺激大小; % column 2 按键反应
    resdata = [];
    
    rawdata(:,1) = paramatrix(:,3); % stimSize
    rawdata(:,2) = paramatrix(:,8); % response time
    rawdata(:,3) = paramatrix(:,9);

    resdata(:,1) = unique(rawdata(:,1));% 找出刺激并顺次排列
    
    for i = 1: length(resdata(:,1)) 
        resdata(i,2) = length(find(rawdata(:,1)==resdata(i,1)&rawdata(:,2)==1)); % 第二列放该行刺激强度正确的试次
        resdata(i,3) = length(find(rawdata(:,1)==resdata(i,1)));% 第三列放该行刺激强度所有的试次
        resdata(i,5) = mean(paramatrix(find(rawdata(:,1)==resdata(i,1)&rawdata(:,2)==1),9));%第五列放平均反应时
    end
    
    resdata(:,4) = resdata(:,2)./resdata(:,3);% 正确率
    
    StimStrength=resdata(:,1);
    RespAccuracy=resdata(:,4);
    TrialCount=resdata(:,3);
    RespTime=resdata(:,5);
    
    close all;
    curvecolor = 'b';
    linecolorr=[0 0 1];
    dotcolorr=[0.5 0.5 0.8];
    linestyle='-';
    
    hold on
    
   
    plot(StimStrength,1000*RespTime,'LineWidth',0.5,'Color',linecolorr,'LineStyle',linestyle);
    scatter(StimStrength,1000*RespTime,100*(RespAccuracy.^3),'ro','MarkerFaceColor',dotcolorr,'MarkerEdgeColor','none');
    %output=fittingsigmoid(StimStrength,RespAccuracy,TrialCount,curvecolor,linestyle);
    xlabel('StrSize (SD of Gaussian Envelop)');
    ylabel('response time (ms)');
    legend('RespTime');

    
    
    savefig([subject '_figure_' int2str(n)]);

    close all;
end
end


%%该函数用于s形曲线拟合
%%StimStrength 刺激强度
%%RespAccuracy 反应正确率
%%TrialCount 每个刺激点的trial数
%%curvecolor 曲线颜色 r g b k四种颜色选择
function output=fittingsigmoid(StimStrength,RespAccuracy,TrialCount,curvecolor,linestyle)
%StimStrength
%%%%%%%%%%%%%%拟合s形曲线%%%%%%%%%%%%%%%%
x = log10(min(StimStrength)):0.001:log10(max(StimStrength));

%Threshold0= (log10(min(StrthRsp(:,1)))+ log10(max(StrthRsp(:,1))))/2;
tempindex=find(TrialCount==max(TrialCount));
Threshold0=log10(StimStrength(tempindex(1)));%以trial数最多的强度作为拟合起始参数
%Threshold0=log10(4);%以trial数最多的强度作为拟合起始参数
slope0=0.3;
beta0 = [Threshold0 slope0];
%fun = @(beta,x)(1+erf(((x-beta(1))/beta(2))/sqrt(2)))/2; %%chancelevel=0情况
fun = @(beta,x)((1+erf(((x-beta(1))/beta(2))/sqrt(2)))/2)*0.5+0.5; %%chance level=0.5情况
%fun = @(beta,x)((1+erf(((x-beta(1))/beta(2))/sqrt(2)))/2)*0.75+0.25; %%chance level=0.25情况

% %2014版本matlab拟合命令
% wnlm = fitnlm(log10(StimStrength),RespAccuracy,fun,beta0,'weight',TrialCount);
% yfit = predict(wnlm,x');

%%2011或之前版本matlab拟合命令
[wnlm r2] = nlinfit(log10(StimStrength),RespAccuracy,fun,beta0);
% StimStrength
% RespAccuracy
% TrialCount
yfit=fun(wnlm,x');


%%%%%%%%%%%%%%画 图%%%%%%%%%%%%%%%%%%%%%%%%%
%图形的颜色
if curvecolor=='r'
   linecolorr=[1 0 0];
   dotcolorr=[0.8 0.4 0.4];
 elseif curvecolor=='g'
   linecolorr=[0 1 0];
   dotcolorr=[0.4 0.8 0.4];
 elseif curvecolor=='b'
    linecolorr=[0 0 1];
    dotcolorr=[0.5 0.5 0.8];
 else
    linecolorr=[0 0 0];
    dotcolorr=[0.4 0.4 0.4];
end

hold on
plot(10.^x,yfit,'LineWidth',0.5,'Color',linecolorr,'LineStyle',linestyle)
scatter(StimStrength,RespAccuracy,TrialCount*5,'ro','MarkerFaceColor',dotcolorr,'MarkerEdgeColor','none')

% ThreP=0.75;%阈值处的正确率
% ThreIndex=find(abs(yfit-ThreP)==min(abs(yfit-ThreP)));
% Threshold=10^x(ThreIndex);%找到对应的阈值
% line([min(StimStrength) Threshold],[ThreP ThreP],'color',[0.5 0.5 0.5])
% line([Threshold Threshold],[ThreP 0],'color',dotcolorr)
% text(Threshold,0.05,num2str(Threshold,'%4.3g'))

% line([0.3 0.3],[0 1],'color',[0.5 0.5 0.5])

xlabel('Size (SD of Gaussian Envelop)')
ylabel('% of Correct Response')

output=wnlm;

%plot(exp(x),yfit1,'r',exp(x),yfit2,'k',exp(x),yfit3,'b','LineWidth',2);
%legend('test cued','center cued','ref cued');
end


