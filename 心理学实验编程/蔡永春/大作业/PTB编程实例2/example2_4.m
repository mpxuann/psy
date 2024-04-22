%��һ��ת���ķ糵���糵λ�������ȷ�����ٶȿ�ͨ��
%By Cai Yongchun, 2020/10/8
ScreenNumber=0;
Background=128;
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%��ȡˢ����
framedur=1/frame_rate;%ÿһ֡���ֵ�ʱ��

%�̼��Ĳ���
StimContrast=0.45; %�Աȶ�
StimSize=300;%�̼���С
[x,y]=meshgrid(-StimSize/2:StimSize/2,-StimSize/2:StimSize/2);
maskradius=StimSize/2;
sd=50;
Circlemask=exp(-(x.^2+y.^2)/(2*sd^2));%������ά��˹mask
Circlemask=(x.^2+y.^2 <= maskradius^2);%����Բ��mask
cycles=6;
RotationSpeed=0;%��ʼת�����ٶȣ���λ��/��
RStep=20;%ÿ��һ�����·�����ٶȸı��ֵ
increasing=0;
buttoms=[];
upkey=KbName('up');
downkey=KbName('down');
rotatingangle=0;
%%���ֹ�դ
while ~sum(buttoms) %�����������˳�
    [xx yy buttoms]=GetMouse;
    [keyisdown, secs, keycode] = KbCheck;
    StimRect=[0 0 StimSize StimSize]+[xx yy xx yy];%�̼���λ��ÿ֡������
    
    rotatingangleperframe=RotationSpeed/frame_rate;%ÿ֡�Ƕȵı仯��
    rotatingangle=rotatingangle+rotatingangleperframe;%ÿ֡�ĽǶ�
    
    StimMatrix=Background*(1+StimContrast*sign(cos(cycles*atan(y./x)-rotatingangle*pi/180)).*Circlemask); %�糵�ľ���
    StimTexture=Screen('MakeTexture',WindowPtr, StimMatrix);%�Ѿ����Ϊ����
    Screen('DrawTexture',WindowPtr,StimTexture,[],StimRect);%������
    Screen(WindowPtr,'Flip');%���ִ̼�
    
    if keycode(upkey)==1 %ȷ�����ٶȵı仯����
       increasing=1;
     elseif keycode(downkey)==1
       increasing=-1;
    end
    if sum(keycode)==0 && increasing~=0 %ÿ�ΰ����ɿ�ʱ�Ÿı��ٶ�
        RotationSpeed=RotationSpeed+increasing*RStep;
        increasing=0;
    end
end
Screen('CloseAll');%�رմ���