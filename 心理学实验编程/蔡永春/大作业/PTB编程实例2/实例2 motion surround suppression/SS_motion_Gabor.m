%%2018 9 25
%%by Cai Yongchun
%%2AFC任务 测量surround suppression of motion

function SS_motion_Gabor(subjectid,start,over)

load([subjectid '_paramatrix']);
HideCursor;

background=128; %gray level of background 
[window,windowRect]=Screen('OpenWindow', 0, background);
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
frame_rate=Screen('FrameRate',window);
framedur=1000/frame_rate;%单位ms

%%%%%%%%%%定义刺激参数%%%%%%%%%%%%
DistanceToScreen=40; %屏幕距离 厘米
WidthOfScreen=29.5; %屏幕宽度 厘米
XResolution=windowRect(3); %屏幕水平分辨率
pixelsize=atan((WidthOfScreen/XResolution)/DistanceToScreen)*180/pi;%计算每个像素的度数
pixelsperdeg=1/pixelsize;%每度视角有多少个像素

FixDuration=500;%注视点呈现时间

SpatialPeriod=round(pixelsperdeg/1); % 1 cycles/degree, 光栅每个周期的像素数
FixationRect=CenterRect([0 0 2 2],windowRect);%%注视点位置
FixLum=0;%注视点的灰度 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%1up3down阶梯法测阈值的初始值%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxstrength(1)=30; %刺激呈 现的最长时间窗口，表示高斯包络的标准差，单位ms
minstrength(1)=3; %刺激呈现的最小时间窗口，表示高斯包络的标准差，单位ms  
initialstrength(1,:)=[minstrength(1) maxstrength(1)]; 

stairtype='1u3d';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%提示声音%%%%%%%%%%%%%%%%%%%
ff=1500;%%声音频率
duration=100 ;%%声音持续的时间，单位毫秒
samplefrq=10000;%%声音信号的采样频率
nn=duration/1000;
errorsound_data=MakeBeep(ff, duration/1000, samplefrq);
errorsound_player=audioplayer(errorsound_data,samplefrq);%%声音的handle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%实验开始之前呈现注视点
   while KbCheck; end
   Screen('FillOval',window,FixLum,FixationRect);%fixation 
   Screen('DrawText',window,'Press any key to begin',FixationRect(1)-160,600-100,[0 0 0]);%提示开始   
   Screen('Flip', window);   
   KbWait;
%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=start:over
   Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
   
   if mod(i,80)==1
     
      if i~=1
      Screen('DrawText',window,'Please have a rest...',FixationRect(1)-150,FixationRect(2),[0 0 0]);%提示开始
      Screen('Flip', window);
      while KbCheck; end
      KbWait;
      end
   
   end
    
    %%提取当前对应的刺激强度矩阵（光栅对比度）和反应矩阵
    strengthmatrix=[];
    responsematrix=[];
    conditions=paramatrix(i,2);%staircase number
    if i~=1
       strengthmatrix=paramatrix(find(paramatrix(1:i-1,2)==conditions),7);
       responsematrix=paramatrix(find(paramatrix(1:i-1,2)==conditions),8);
    end

   %%阶梯法测阈值，确定每个trial光栅的呈现时间
   paramatrix(i,7)=updownstaircase(stairtype,strengthmatrix,responsematrix,...
                       minstrength,maxstrength,initialstrength(mod(conditions,2)+1));

   %%%%%%生成光栅%%%%%%%%%%%%%%%%%%%%
    GratingSize=round(paramatrix(i,3)*pixelsperdeg);
    
    gratingphase=randsample(0:pi/6:2*pi,1);%每个trial的相位随机
    i_2sd_size=GratingSize; %中央Gabor的2sd大小，像素
    i_Speriod=SpatialPeriod;%i_Speriod,中央光栅的空间周期，像素
    i_speed=(paramatrix(i,5)*pixelsperdeg)*paramatrix(i,6);%速度*运动方向
    i_phase=gratingphase;%i_phase,中央光栅的相位
    i_contrast=paramatrix(i,4);%i_contrast,标准光栅的对比度   
    i_orientation=0;%i_orientation,中央光栅的朝向
    i_ramptime=round(paramatrix(i,7));
    
    gratingmatrix=driftGabormatrix(frame_rate,background,i_2sd_size,i_Speriod,i_speed,i_phase,i_contrast,i_orientation,i_ramptime);
    %gratingmatrix=driftSinBlurGratingmatrix(frame_rate,background,i_2sd_size*3,i_Speriod,i_speed,i_phase,i_contrast,i_orientation,i_ramptime);
    
    
    gratingmatrix=round(gratingmatrix);
    ActuallSize=size(gratingmatrix);
    GratingRect0=CenterRect([0 0 ActuallSize(1) ActuallSize(2)],windowRect);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   
  %% 呈现刺激%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %呈现每个trial开始的注视点
    for pp=1:round(FixDuration/framedur)  
         Screen('FillOval',window,FixLum,FixationRect);%fixation 
         Screen('Flip', window);
    end
    
    %%grating
    grating_frames=length(gratingmatrix(1,1,:));
    for pp=1:grating_frames
        gratings(pp)=Screen('MakeTexture',window,  gratingmatrix(:,:,pp));
        
        Screen('DrawTexture', window,gratings(pp),[],GratingRect0);%光栅
        Screen('FillOval',window,FixLum,FixationRect);%fixation 
        Screen('Flip',window);     
    end
    
    %注视点
    Screen('FillOval',window,FixLum,FixationRect);%fixation 
    Screen('Flip', window);
    
    %%%%%%记录按键反应%%%%%
     keycode=zeros(1,256);
     leftkey=KbName('left');
     rightkey=KbName('right');
     upkey=KbName('up');
     downkey=KbName('down');
     qkey=KbName('q');
    
    while (keycode(qkey)==0)&&(keycode(leftkey)==0)&&(keycode(rightkey)==0)
         WaitSecs(0.0001);
         [touch,secs,keycode]=KbCheck;
    end
     
    if keycode(qkey)==1 %q键退出
        break
    end
       
    if (keycode(leftkey)==1 && paramatrix(i,6)==-1 && sum(keycode)==1) || ... %%left按键表示看到向左运动
        (keycode(rightkey)==1 && paramatrix(i,6)==1 && sum(keycode)==1)      %%right按键表示看到向右运动
          paramatrix(i,8)=1;
      else
          paramatrix(i,8)=0;
          sound(errorsound_data,samplefrq);
          %Beeper(1000,1,0.2)
    end
     
     %%%%%%存储数据%%%%%%%
     save([subjectid '_paramatrix'],'paramatrix');
     
     for pp=1:grating_frames 
       Screen('Close',gratings(pp));%每个试次都要关闭生成的Gabor纹理，不然会占用很多内存空间
     end
    
     %%%%%被试按Ctrl进入下一个trial%%%%%
     nexttrial=KbName('control');
     
     Screen('FillOval',window,FixLum+100,FixationRect);%fixation 
     Screen('Flip',window);
     while keycode(nexttrial)==0
         WaitSecs(0.0001);
         [touch,secs,keycode]=KbCheck;
     end
     
end

Screen('CloseAll');

