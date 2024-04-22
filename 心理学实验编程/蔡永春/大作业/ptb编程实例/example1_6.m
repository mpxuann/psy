%画一个圆形光栅
%By Cai Yongchun, 2020/10/7
ScreenNumber=0;
Background=128;
GratingDuration=2;%光栅呈现2秒钟
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%获取刷新率
framedur=1/frame_rate;%每一帧呈现的时间

%定义光栅的参数
contrastofgrating=0.8; %对比度
sizeofgrating=200; %光栅大小
GratingRect=CenterRect([0 0 sizeofgrating sizeofgrating],windowRect);%%光栅呈现于屏幕中央,光栅的位置矩阵
[x,y]=meshgrid(-sizeofgrating/2:sizeofgrating/2,-sizeofgrating/2:sizeofgrating/2);
angleofgrating=30;  %光栅的倾斜角度，单位度
gratingperiod=50;  %空间周期
sf=1/gratingperiod;  %转换成空间频率
a1=2*pi*sf*cos(angleofgrating*pi/180);
b1=2*pi*sf*sin(angleofgrating*pi/180);
maskradius=sizeofgrating/2;
Circlemask=(x.^2+y.^2 <= maskradius^2);%生成圆形mask
matrixofgrating=Background*(1+contrastofgrating*sin(a1*x+b1*y).*Circlemask);   %生成光栅矩阵

surf(x,y,matrixofgrating)

GratingTexture=Screen('MakeTexture',WindowPtr, matrixofgrating);%把矩阵变为纹理

%%呈现光栅
for ii=1:round(GratingDuration/framedur)
      Screen('DrawTexture',WindowPtr,GratingTexture,[],GratingRect);%画纹理
      Screen(WindowPtr,'Flip');%呈现光栅
end
Screen('CloseAll');%关闭窗口