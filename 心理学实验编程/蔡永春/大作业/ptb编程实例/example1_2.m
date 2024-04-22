%%example2-2 画一个圆
%By Cai Yongchun, 2020/10/7
WindowNumber=0;
WinColor=[100 100 100];
[WindowPtr,Rect]=Screen('OpenWindow',WindowNumber,WinColor);
Screen('FillRect', WindowPtr,[0,255,0],[100,100,200,200]);%窗口序号，颜色，位置坐标
Screen('FrameOval',WindowPtr,[0,0,255],[300 200 500 700],5);%窗口序号，颜色，位置坐标，画笔粗细
Screen('flip',WindowPtr);%呈现，屏幕序号
WaitSecs(2);%等待5秒
Screen('CloseAll');%关闭所有窗口