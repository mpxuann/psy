%����һ����Ƭ2���ӡ�
%By Cai Yongchun, 2020/10/7
ScreenNumber=0;
Background=128;
PicDuration=2;%ͼƬ2����
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%��ȡˢ����
framedur=1/frame_rate;%ÿһ֡���ֵ�ʱ��

%ImgMatrix=imread('mypictures\fish.png'); %��ȡfish.pngͼƬ

% %%%%��1-18��ͼƬ�������ȡһ�ų���
 ImgIndex=randsample(1:18,1);
 ImgName=[num2str(ImgIndex) '.bmp'];
 ImgMatrix=imread(['mypictures\' ImgName]);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ImgSize=size(ImgMatrix);
% ImgMatrix(:,:,1)=0;
% ImgMatrix(:,:,3)=0;
ImgMatrix(:,200:500,:)=0;
PicRect=CenterRect([0 0 ImgSize(2) ImgSize(1)],windowRect);%%ͼƬ��������Ļ����,ͼƬ��λ�þ���
%PicRect=[0 0 ImgSize(2) ImgSize(1)];%%ͼƬ��������Ļ����,ͼƬ��λ�þ���


% %%����ȷ��д��
% PicTexture=Screen('MakeTexture',WindowPtr, ImgMatrix);%�Ѿ����Ϊ����
% Screen('DrawTexture',WindowPtr,PicTexture,[],PicRect);%������
% Screen(WindowPtr,'Flip');%����ͼƬ���л�����
% WaitSecs(2);%�ȴ�2�룬����ȷ��д��

%%��ȷ��д��,��ȷ��֡
for ii=1:round(PicDuration/framedur)
    PicTexture=Screen('MakeTexture',WindowPtr, ImgMatrix);%�Ѿ����Ϊ����
    Screen('DrawTexture',WindowPtr,PicTexture,[],PicRect);%������
    Screen(WindowPtr,'Flip');%����ͼƬ���л�����
end

Screen('CloseAll');%�رմ���