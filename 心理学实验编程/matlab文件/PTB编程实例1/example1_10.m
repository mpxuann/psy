%画一个随机点图
%By Cai Yongchun, 2020/10/7
ScreenNumber=0;
Background=128;
StimDuration=5;%呈现5秒钟
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%获取刷新率
framedur=1/frame_rate;%每一帧呈现的时间
%刺激的参数
StimContrast=0.45; %对比度
StimSize=300;%刺激大小

NoisePix=10;%每个噪音点的像素数；
NoiseNum=round(StimSize/NoisePix);%水平或竖直方向上的噪音点个数
StimuSize=NoisePix*NoiseNum;%重新计算刺激大小

StimRect=CenterRect([0 0 StimSize StimSize],windowRect);%%刺激呈现于屏幕中央,刺激的位置矩阵
[x,y]=meshgrid(round(-StimSize/2):round(StimSize/2)-1,round(-StimSize/2):round(StimSize/2)-1);

maskradius=StimSize/2;

sd=50;
%Circlemask=exp(-(x.^2+y.^2)/(2*sd^2));%生成三维高斯mask
Circlemask=(x.^2+y.^2 <= maskradius^2);%生成圆形mask

NoiseMatrix=rand(NoiseNum,NoiseNum)*2-1;
temp0=ones(NoisePix);
StimMatrix0=kron(NoiseMatrix,temp0);%生成像素噪音点，值范围-1~1; kron命令是扩大每个noise元素的值为设定的噪音像素大小

StimMatrix=Background*(1+StimContrast*StimMatrix0.*Circlemask); %刺激矩阵

surf(x,y,StimMatrix)

StimTexture=Screen('MakeTexture',WindowPtr, StimMatrix);%把矩阵变为纹理

%%呈现光栅
for ii=1:round(StimDuration/framedur)
      Screen('DrawTexture',WindowPtr,StimTexture,[],StimRect);%画纹理
      Screen(WindowPtr,'Flip');%呈现刺激
end
Screen('CloseAll');%关闭窗口