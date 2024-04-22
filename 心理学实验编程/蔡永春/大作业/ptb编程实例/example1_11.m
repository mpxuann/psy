% һ��Բ����Ļ��ˮƽ�˶�����q���˳�
%By Cai Yongchun, 2020/10/7
Background=0;
StimColour=255;
StimSize=100;
DriftRange=[-400 400];%�˶��ķ�Χ�������Ļ�����
PixelsPerFrame=4;%ÿһ֡�˶���������
%horizontaloffset=DriftRange(1):PixelsPerFrame:DriftRange(2);%���ܵ�ˮƽλ��
horizontaloffset=[DriftRange(1):PixelsPerFrame:DriftRange(2) DriftRange(2):-PixelsPerFrame:DriftRange(1)];%���ܵ�ˮƽλ��
verticaloffset=100*sin(horizontaloffset*2*pi/200);
[WindowPtr,windowRect] =Screen('OpenWindow',0,Background);
TargetRect0=CenterRect([0 0 StimSize StimSize],windowRect);

quitekey=KbName('q');%q���˳�
keycode=zeros(1,256);
n=0;
while ~keycode(quitekey)
   n=mod(n,length(horizontaloffset))+1;%ˮƽλ�ñ��
   %TargetRect=TargetRect0+[horizontaloffset(n) 0 horizontaloffset(n) 0]; %ÿһ֡��Ҫ�����µĴ̼�λ��
   TargetRect=TargetRect0+[horizontaloffset(n) verticaloffset(n) horizontaloffset(n) verticaloffset(n)]; %ÿһ֡��Ҫ�����µĴ̼�λ��
   Screen('FillOval',WindowPtr,StimColour,TargetRect);
   Screen('Flip',WindowPtr);
   [keyisdown, secs, keycode]=KbCheck;%��ȡ����ֵ
end
Screen('CloseAll');