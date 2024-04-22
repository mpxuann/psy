%呈现一幅照片2秒钟。
%By Cai Yongchun, 2020/10/7

%%
%设置窗口
ScreenNumber=0;
Background=128;
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);


 
 %%
 %设置灰度图
  grey = sum(ImgMatrix,[1,2])/(size(ImgMatrix,1)*size(ImgMatrix,2));
  greyMatrix(:,:,1) = grey(:,:,1)*rand(size(ImgMatrix,1),size(ImgMatrix,2));
  greyMatrix(:,:,2) = grey(:,:,2)*rand(size(ImgMatrix,1),size(ImgMatrix,2));
  greyMatrix(:,:,3) = grey(:,:,3)*rand(size(ImgMatrix,1),size(ImgMatrix,2));
  ImgMatrix = greyMatrix;

%%
%设置图片展示时间和位置

PicDuration=2;%图片2秒钟

frame_rate=Screen('FrameRate',WindowPtr);%获取刷新率
framedur=1/frame_rate;%每一帧呈现的时间



ImgSize=size(ImgMatrix);
% ImgMatrix(:,:,1)=0;
% ImgMatrix(:,:,3)=0;
%ImgMatrix(:,200:500,:)=0;
PicRect=CenterRect([0 0 ImgSize(2) ImgSize(1)],windowRect);%%图片呈现于屏幕中央,图片的位置矩阵
%PicRect=[0 0 ImgSize(2) ImgSize(1)];%%图片呈现于屏幕中央,图片的位置矩阵

%%
%具体展示的操作

% %%不精确的写法
% PicTexture=Screen('MakeTexture',WindowPtr, ImgMatrix);%把矩阵变为纹理
% Screen('DrawTexture',WindowPtr,PicTexture,[],PicRect);%画纹理
% Screen(WindowPtr,'Flip');%呈现图片（切换纹理）
% WaitSecs(2);%等待2秒，不精确的写法
%%精确的写法,精确到帧
tic

for i = 1:18
    %%
%照片读取

%ImgMatrix=imread('mypictures\fish.png'); %读取fish.png图片

% %%%%从1-18号图片中随机抽取一张呈现
 ImgIndex=randsample(18,1);
 ImgName=[num2str(ImgIndex) '.bmp'];
 ImgMatrix=imread(['mypictures\' ImgName]);%读取照片imread
 ImgMatrix = rot90(ImgMatrix,2);%图形旋转
PicTexture=Screen('MakeTexture',WindowPtr, ImgMatrix);%把矩阵变为纹理
for ii=1:round(PicDuration/framedur)
    Screen('DrawTexture',WindowPtr,PicTexture,[],PicRect);%画纹理
    Screen(WindowPtr,'Flip');%呈现图片（切换纹理）
end
toc
end

%%

Screen('CloseAll');%关闭窗口

%%
