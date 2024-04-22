%��һ��Բ�ι�դ
%By Cai Yongchun, 2020/10/7
ScreenNumber=0;
Background=128;
GratingDuration=2;%��դ����2����
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%��ȡˢ����
framedur=1/frame_rate;%ÿһ֡���ֵ�ʱ��

%�����դ�Ĳ���
contrastofgrating=0.8; %�Աȶ�
sizeofgrating=200; %��դ��С
GratingRect=CenterRect([0 0 sizeofgrating sizeofgrating],windowRect);%%��դ��������Ļ����,��դ��λ�þ���
[x,y]=meshgrid(-sizeofgrating/2:sizeofgrating/2,-sizeofgrating/2:sizeofgrating/2);
angleofgrating=30;  %��դ����б�Ƕȣ���λ��
gratingperiod=50;  %�ռ�����
sf=1/gratingperiod;  %ת���ɿռ�Ƶ��
a1=2*pi*sf*cos(angleofgrating*pi/180);
b1=2*pi*sf*sin(angleofgrating*pi/180);
maskradius=sizeofgrating/2;
Circlemask=(x.^2+y.^2 <= maskradius^2);%����Բ��mask
matrixofgrating=Background*(1+contrastofgrating*sin(a1*x+b1*y).*Circlemask);   %���ɹ�դ����

surf(x,y,matrixofgrating)

GratingTexture=Screen('MakeTexture',WindowPtr, matrixofgrating);%�Ѿ����Ϊ����

%%���ֹ�դ
for ii=1:round(GratingDuration/framedur)
      Screen('DrawTexture',WindowPtr,GratingTexture,[],GratingRect);%������
      Screen(WindowPtr,'Flip');%���ֹ�դ
end
Screen('CloseAll');%�رմ���