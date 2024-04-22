%随机呈现一一系列图片，每幅图片呈现2秒钟。
%By Cai Yongchun, 2020/10/7
ScreenNumber=0;
Background=128;
PicDuration=2;%图片2秒钟
[WindowPtr,windowRect]=Screen('OpenWindow',ScreenNumber,Background);
frame_rate=Screen('FrameRate',WindowPtr);%获取刷新率
framedur=1/frame_rate;%每一帧呈现的时间


for kk=1:10
   %%%%从1-18号图片中随机抽取一张呈现
   ImgIndex=randsample(1:18,1);
   ImgName=[num2str(ImgIndex) '.bmp'];
   ImgMatrix=imread(['mypictures\' ImgName]);
   ImgSize=size(ImgMatrix);
   PicRect=CenterRect([0 0 ImgSize(2) ImgSize(1)],windowRect);%%图片呈现于屏幕中央,图片的位置矩阵
  
   %%呈现图片
   for ii=1:round(PicDuration/framedur)
      PicTexture=Screen('MakeTexture',WindowPtr, ImgMatrix);%把矩阵变为纹理
      Screen('DrawTexture',WindowPtr,PicTexture,[],PicRect);%画纹理
      Screen(WindowPtr,'Flip');%呈现图片（切换缓冲区）
   end
   
end

Screen('CloseAll');%关闭窗口