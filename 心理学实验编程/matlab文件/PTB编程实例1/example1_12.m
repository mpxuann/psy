%��һ���˶���gabor��դ
%By Cai Yongchun, 2020/10/8
ScreenNumber=0; 
Background=128;
GratingDuration=5;%��դ����5����
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%��ȡˢ����
framedur=1/frame_rate;%ÿһ֡���ֵ�ʱ��

%�����դ�Ĳ���
contrastofgrating=0.8; %�Աȶ�
sizeofgrating=300; %��դ��С
angleofgrating=0;  %��դ����б�Ƕȣ���λ��
gratingperiod=20;  %�ռ�����
DriftSpeed=-20; %��դ�˶��ٶȣ���λ����/��
GratingRect=CenterRect([0 0 sizeofgrating sizeofgrating],windowRect);%%��դ��������Ļ����,��դ��λ�þ���
[x,y]=meshgrid(-sizeofgrating/2:sizeofgrating/2,-sizeofgrating/2:sizeofgrating/2);

sf=1/gratingperiod;  %ת���ɿռ�Ƶ��
a1=2*pi*sf*cos(angleofgrating*pi/180);
b1=2*pi*sf*sin(angleofgrating*pi/180);
maskradius=sizeofgrating/2;

sd=30;
Circlemask=exp(-(x.^2+y.^2)/(2*sd^2));%������ά����mask
%Circlemask=(x.^2+y.^2 <= maskradius^2);%����Բ��mask

%%���ֹ�դ
for ii=1:round(GratingDuration/framedur)
    matrixofgrating=round(Background*(1+contrastofgrating*sin(a1*x+b1*y-DriftSpeed*ii*framedur).*Circlemask));   %���ɹ�դ����
    GratingTexture=Screen('MakeTexture',WindowPtr, matrixofgrating);%�Ѿ����Ϊ����
    Screen('DrawTexture',WindowPtr,GratingTexture,[],GratingRect);%������
    Screen(WindowPtr,'Flip');%���ֹ�դ
end
Screen('CloseAll');%�رմ���