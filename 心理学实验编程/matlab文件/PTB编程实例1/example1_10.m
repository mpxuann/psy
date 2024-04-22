%��һ�������ͼ
%By Cai Yongchun, 2020/10/7
ScreenNumber=0;
Background=128;
StimDuration=5;%����5����
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%��ȡˢ����
framedur=1/frame_rate;%ÿһ֡���ֵ�ʱ��
%�̼��Ĳ���
StimContrast=0.45; %�Աȶ�
StimSize=300;%�̼���С

NoisePix=10;%ÿ�����������������
NoiseNum=round(StimSize/NoisePix);%ˮƽ����ֱ�����ϵ����������
StimuSize=NoisePix*NoiseNum;%���¼���̼���С

StimRect=CenterRect([0 0 StimSize StimSize],windowRect);%%�̼���������Ļ����,�̼���λ�þ���
[x,y]=meshgrid(round(-StimSize/2):round(StimSize/2)-1,round(-StimSize/2):round(StimSize/2)-1);

maskradius=StimSize/2;

sd=50;
%Circlemask=exp(-(x.^2+y.^2)/(2*sd^2));%������ά��˹mask
Circlemask=(x.^2+y.^2 <= maskradius^2);%����Բ��mask

NoiseMatrix=rand(NoiseNum,NoiseNum)*2-1;
temp0=ones(NoisePix);
StimMatrix0=kron(NoiseMatrix,temp0);%�������������㣬ֵ��Χ-1~1; kron����������ÿ��noiseԪ�ص�ֵΪ�趨���������ش�С

StimMatrix=Background*(1+StimContrast*StimMatrix0.*Circlemask); %�̼�����

surf(x,y,StimMatrix)

StimTexture=Screen('MakeTexture',WindowPtr, StimMatrix);%�Ѿ����Ϊ����

%%���ֹ�դ
for ii=1:round(StimDuration/framedur)
      Screen('DrawTexture',WindowPtr,StimTexture,[],StimRect);%������
      Screen(WindowPtr,'Flip');%���ִ̼�
end
Screen('CloseAll');%�رմ���