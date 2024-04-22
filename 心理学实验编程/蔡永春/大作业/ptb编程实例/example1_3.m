%呈现一幅照片2秒钟。
%By Cai Yongchun, 2020/10/7
ScreenNumber=0;
Background=128;
PicDuration=2;%图片2秒钟
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%获取刷新率
framedur=1/frame_rate;%每一帧呈现的时间

%ImgMatrix=imread('mypictures\fish.png'); %读取fish.png图片

% %%%%从1-18号图片中随机抽取一张呈现
 ImgIndex=randsample(1:18,1);
 ImgName=[num2str(ImgIndex) '.bmp'];
 ImgMatrix=imread(['mypictures\' ImgName]);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ImgSize=size(ImgMatrix);
% ImgMatrix(:,:,1)=0;
% ImgMatrix(:,:,3)=0;
ImgMatrix(:,200:500,:)=0;
PicRect=CenterRect([0 0 ImgSize(2) ImgSize(1)],windowRect);%%图片呈现于屏幕中央,图片的位置矩阵
%PicRect=[0 0 ImgSize(2) ImgSize(1)];%%图片呈现于屏幕中央,图片的位置矩阵


% %%不精确的写法
% PicTexture=Screen('MakeTexture',WindowPtr, ImgMatrix);%把矩阵变为纹理
% Screen('DrawTexture',WindowPtr,PicTexture,[],PicRect);%画纹理
% Screen(WindowPtr,'Flip');%呈现图片（切换纹理）
% WaitSecs(2);%等待2秒，不精确的写法

%%精确的写法,精确到帧
for ii=1:round(PicDuration/framedur)
    PicTexture=Screen('MakeTexture',WindowPtr, ImgMatrix);%把矩阵变为纹理
    Screen('DrawTexture',WindowPtr,PicTexture,[],PicRect);%画纹理
    Screen(WindowPtr,'Flip');%呈现图片（切换纹理）
end

Screen('CloseAll');%关闭窗口