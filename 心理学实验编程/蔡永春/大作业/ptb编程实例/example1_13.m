%��һ��ת���ķ糵
%By Cai Yongchun, 2020/10/8
ScreenNumber=0;
Background=128;
StimDuration=5;%����5����
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%��ȡˢ����
framedur=1/frame_rate;%ÿһ֡���ֵ�ʱ��

%�̼��Ĳ���
StimContrast=0.45; %�Աȶ�
StimSize=300;%�̼���С
StimRect=CenterRect([0 0 StimSize StimSize],windowRect);%%�̼���������Ļ����,�̼���λ�þ���
[x,y]=meshgrid(-StimSize/2:StimSize/2,-StimSize/2:StimSize/2);
maskradius=StimSize/2;
sd=50;
Circlemask=exp(-(x.^2+y.^2)/(2*sd^2));%������ά��˹mask
Circlemask=(x.^2+y.^2 <= maskradius^2);%����Բ��mask
cycles=6;
RotationSpeed=180;%ת���ٶȣ���λ��/��

%%���ֹ�դ
for ii=1:round(StimDuration/framedur)
   % StimMatrix=Background*(1+StimContrast*sign(cos(cycles*atan(y./x)-(RotationSpeed*pi/180)*ii/frame_rate)).*Circlemask); %�糵�ľ���
    StimMatrix=Background*(1+StimContrast*(cos(cycles*atan(y./x)-(RotationSpeed*pi/180)*ii/frame_rate)).*Circlemask); %�糵�ľ���
    StimTexture=Screen('MakeTexture',WindowPtr, StimMatrix);%�Ѿ����Ϊ����
    Screen('DrawTexture',WindowPtr,StimTexture,[],StimRect);%������
    Screen(WindowPtr,'Flip');%���ִ̼�
end
Screen('CloseAll');%�رմ���