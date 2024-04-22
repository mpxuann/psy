% 一个圆在屏幕上水平运动，按q键退出
%By Cai Yongchun, 2020/10/7
Background=0;
StimColour=255;
StimSize=100;
DriftRange=[-400 400];%运动的范围，相对屏幕中央点
PixelsPerFrame=4;%每一帧运动的象素数
%horizontaloffset=DriftRange(1):PixelsPerFrame:DriftRange(2);%可能的水平位置
horizontaloffset=[DriftRange(1):PixelsPerFrame:DriftRange(2) DriftRange(2):-PixelsPerFrame:DriftRange(1)];%可能的水平位置
verticaloffset=100*sin(horizontaloffset*2*pi/200);
[WindowPtr,windowRect] =Screen('OpenWindow',0,Background);
TargetRect0=CenterRect([0 0 StimSize StimSize],windowRect);

quitekey=KbName('q');%q键退出
keycode=zeros(1,256);
n=0;
while ~keycode(quitekey)
   n=mod(n,length(horizontaloffset))+1;%水平位置编号
   %TargetRect=TargetRect0+[horizontaloffset(n) 0 horizontaloffset(n) 0]; %每一帧都要计算新的刺激位置
   TargetRect=TargetRect0+[horizontaloffset(n) verticaloffset(n) horizontaloffset(n) verticaloffset(n)]; %每一帧都要计算新的刺激位置
   Screen('FillOval',WindowPtr,StimColour,TargetRect);
   Screen('Flip',WindowPtr);
   [keyisdown, secs, keycode]=KbCheck;%读取键盘值
end
Screen('CloseAll');