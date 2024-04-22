%画一个转动的风车
%By Cai Yongchun, 2020/10/8
ScreenNumber=0;
Background=128;
StimDuration=5;%呈现5秒钟
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%获取刷新率
framedur=1/frame_rate;%每一帧呈现的时间

%刺激的参数
StimContrast=0.45; %对比度
StimSize=300;%刺激大小
StimRect=CenterRect([0 0 StimSize StimSize],windowRect);%%刺激呈现于屏幕中央,刺激的位置矩阵
[x,y]=meshgrid(-StimSize/2:StimSize/2,-StimSize/2:StimSize/2);
maskradius=StimSize/2;
sd=50;
Circlemask=exp(-(x.^2+y.^2)/(2*sd^2));%生成三维高斯mask
Circlemask=(x.^2+y.^2 <= maskradius^2);%生成圆形mask
cycles=6;
RotationSpeed=180;%转动速度，单位度/秒

%%呈现光栅
for ii=1:round(StimDuration/framedur)
   % StimMatrix=Background*(1+StimContrast*sign(cos(cycles*atan(y./x)-(RotationSpeed*pi/180)*ii/frame_rate)).*Circlemask); %风车的矩阵
    StimMatrix=Background*(1+StimContrast*(cos(cycles*atan(y./x)-(RotationSpeed*pi/180)*ii/frame_rate)).*Circlemask); %风车的矩阵
    StimTexture=Screen('MakeTexture',WindowPtr, StimMatrix);%把矩阵变为纹理
    Screen('DrawTexture',WindowPtr,StimTexture,[],StimRect);%画纹理
    Screen(WindowPtr,'Flip');%呈现刺激
end
Screen('CloseAll');%关闭窗口