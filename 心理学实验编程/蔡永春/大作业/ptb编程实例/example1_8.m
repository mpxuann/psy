%��һ�����̸�
%By Cai Yongchun, 2020/10/7
ScreenNumber=0;
Background=127.5;
%Background=128;%ԭ����contrast
GratingDuration=2;%��դ����2����
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%��ȡˢ����
framedur=1/frame_rate;%ÿһ֡���ֵ�ʱ��

%�����դ�Ĳ���
contrastofgrating=0.5; %�Աȶ�
% cguioiiuooooooooo0contrastofgrating=0.9; %ԭ���ĶԱȶ�
sizeofgrating=300; %��դ��С
GratingRect=CenterRect([0 0 sizeofgrating sizeofgrating],windowRect);%%��դ��������Ļ����,��դ��λ�þ���
[x,y]=meshgrid(-sizeofgrating/2:sizeofgrating/2,-sizeofgrating/2:sizeofgrating/2);
angleofgrating=0;  %��դ����б�Ƕȣ���λ��
gratingperiod=40;  %�ռ�����
sf=1/gratingperiod;  %ת���ɿռ�Ƶ��
a1=2*pi*sf*cos(angleofgrating*pi/180);
b1=2*pi*sf*sin(angleofgrating*pi/180);

a2=2*pi*sf*cos((angleofgrating+90)*pi/180);
b2=2*pi*sf*sin((angleofgrating+90)*pi/180);

maskradius=sizeofgrating/2;

sd=30;
%Circlemask=exp(-(x.^2+y.^2)/(2*sd^2));%������ά��˹mask
Circlemask=(x.^2+y.^2 <= maskradius^2);%����Բ��mask

matrixofgrating=round(Background*(1+contrastofgrating*(sin(a1*x+b1*y)+sin(a2*x+b2*y)).*Circlemask));   %�Ҷ����̸�
%matrixofgrating=round(Background*(1+contrastofgrating*sign(sin(a1*x+b1*y)+sin(a2*x+b2*y)).*Circlemask));   %�ڰ����̸�
surf(x,y,matrixofgrating)

GratingTexture=Screen('MakeTexture',WindowPtr, matrixofgrating);%�Ѿ����Ϊ����

%%���ֹ�դ
for ii=1:round(GratingDuration/framedur)
      Screen('DrawTexture',WindowPtr,GratingTexture,[],GratingRect);%������
      Screen(WindowPtr,'Flip');%���ֹ�դ
end
Screen('CloseAll');%�رմ���