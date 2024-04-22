%新建一个空白窗口，等待若干秒之后关闭它。
%By Cai Yongchun, 2020/10/7
ScreenNumber=0;%定义屏幕编号0（也可以是1）
wincolor=[100,100,0];
%rect=[200,200,500,800];%前面两个是左上角的屏幕坐标值，后面两个是右下角的屏幕坐标值
rect=[];
[ScreenNumber,rect]=Screen('openwindow',ScreenNumber,wincolor,rect);
WaitSecs(5);%等待5秒
Screen('CloseAll');%关闭所有窗口