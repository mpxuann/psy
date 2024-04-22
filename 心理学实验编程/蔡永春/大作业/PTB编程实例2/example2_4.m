%画一个转动的风车，风车位置由鼠标确定，速度可通过
%By Cai Yongchun, 2020/10/8
ScreenNumber=0;
Background=128;
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%获取刷新率
framedur=1/frame_rate;%每一帧呈现的时间

%刺激的参数
StimContrast=0.45; %对比度
StimSize=300;%刺激大小
[x,y]=meshgrid(-StimSize/2:StimSize/2,-StimSize/2:StimSize/2);
maskradius=StimSize/2;
sd=50;
Circlemask=exp(-(x.^2+y.^2)/(2*sd^2));%生成三维高斯mask
Circlemask=(x.^2+y.^2 <= maskradius^2);%生成圆形mask
cycles=6;
RotationSpeed=0;%初始转动角速度，单位度/秒
RStep=20;%每按一次上下方向键速度改变的值
increasing=0;
buttoms=[];
upkey=KbName('up');
downkey=KbName('down');
rotatingangle=0;
%%呈现光栅
while ~sum(buttoms) %按鼠标任意键退出
    [xx yy buttoms]=GetMouse;
    [keyisdown, secs, keycode] = KbCheck;
    StimRect=[0 0 StimSize StimSize]+[xx yy xx yy];%刺激的位置每帧都更新
    
    rotatingangleperframe=RotationSpeed/frame_rate;%每帧角度的变化量
    rotatingangle=rotatingangle+rotatingangleperframe;%每帧的角度
    
    StimMatrix=Background*(1+StimContrast*sign(cos(cycles*atan(y./x)-rotatingangle*pi/180)).*Circlemask); %风车的矩阵
    StimTexture=Screen('MakeTexture',WindowPtr, StimMatrix);%把矩阵变为纹理
    Screen('DrawTexture',WindowPtr,StimTexture,[],StimRect);%画纹理
    Screen(WindowPtr,'Flip');%呈现刺激
    
    if keycode(upkey)==1 %确定角速度的变化方向
       increasing=1;
     elseif keycode(downkey)==1
       increasing=-1;
    end
    if sum(keycode)==0 && increasing~=0 %每次按键松开时才改变速度
        RotationSpeed=RotationSpeed+increasing*RStep;
        increasing=0;
    end
end
Screen('CloseAll');%关闭窗口