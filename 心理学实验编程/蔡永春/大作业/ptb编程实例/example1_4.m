%�������һһϵ��ͼƬ��ÿ��ͼƬ����2���ӡ�
%By Cai Yongchun, 2020/10/7
ScreenNumber=0;
Background=128;
PicDuration=2;%ͼƬ2����
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%��ȡˢ����
framedur=1/frame_rate;%ÿһ֡���ֵ�ʱ��


for kk=1:10
   %%%%��1-18��ͼƬ�������ȡһ�ų���
   ImgIndex=randsample(1:18,1);
   ImgName=[num2str(ImgIndex) '.bmp'];
   ImgMatrix=imread(['mypictures\' ImgName]);
   ImgSize=size(ImgMatrix);
   PicRect=CenterRect([0 0 ImgSize(2) ImgSize(1)],windowRect);%%ͼƬ��������Ļ����,ͼƬ��λ�þ���
  
   %%����ͼƬ
   for ii=1:round(PicDuration/framedur)
      PicTexture=Screen('MakeTexture',WindowPtr, ImgMatrix);%�Ѿ����Ϊ����
      Screen('DrawTexture',WindowPtr,PicTexture,[],PicRect);%������
      Screen(WindowPtr,'Flip');%����ͼƬ���л���������
   end
   
end

Screen('CloseAll');%�رմ���