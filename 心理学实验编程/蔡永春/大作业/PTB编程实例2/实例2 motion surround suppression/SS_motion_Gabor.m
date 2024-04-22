%%2018 9 25
%%by Cai Yongchun
%%2AFC���� ����surround suppression of motion

function SS_motion_Gabor(subjectid,start,over)

load([subjectid '_paramatrix']);
HideCursor;

background=128; %gray level of background 
[window,windowRect]=Screen('OpenWindow', 0, background);
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
frame_rate=Screen('FrameRate',window);
framedur=1000/frame_rate;%��λms

%%%%%%%%%%����̼�����%%%%%%%%%%%%
DistanceToScreen=40; %��Ļ���� ����
WidthOfScreen=29.5; %��Ļ��� ����
XResolution=windowRect(3); %��Ļˮƽ�ֱ���
pixelsize=atan((WidthOfScreen/XResolution)/DistanceToScreen)*180/pi;%����ÿ�����صĶ���
pixelsperdeg=1/pixelsize;%ÿ���ӽ��ж��ٸ�����

FixDuration=500;%ע�ӵ����ʱ��

SpatialPeriod=round(pixelsperdeg/1); % 1 cycles/degree, ��դÿ�����ڵ�������
FixationRect=CenterRect([0 0 2 2],windowRect);%%ע�ӵ�λ��
FixLum=0;%ע�ӵ�ĻҶ� 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%1up3down���ݷ�����ֵ�ĳ�ʼֵ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxstrength(1)=30; %�̼��� �ֵ��ʱ�䴰�ڣ���ʾ��˹����ı�׼���λms
minstrength(1)=3; %�̼����ֵ���Сʱ�䴰�ڣ���ʾ��˹����ı�׼���λms  
initialstrength(1,:)=[minstrength(1) maxstrength(1)]; 

stairtype='1u3d';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%��ʾ����%%%%%%%%%%%%%%%%%%%
ff=1500;%%����Ƶ��
duration=100 ;%%����������ʱ�䣬��λ����
samplefrq=10000;%%�����źŵĲ���Ƶ��
nn=duration/1000;
errorsound_data=MakeBeep(ff, duration/1000, samplefrq);
errorsound_player=audioplayer(errorsound_data,samplefrq);%%������handle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%ʵ�鿪ʼ֮ǰ����ע�ӵ�
   while KbCheck; end
   Screen('FillOval',window,FixLum,FixationRect);%fixation 
   Screen('DrawText',window,'Press any key to begin',FixationRect(1)-160,600-100,[0 0 0]);%��ʾ��ʼ   
   Screen('Flip', window);   
   KbWait;
%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=start:over
   Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
   
   if mod(i,80)==1
     
      if i~=1
      Screen('DrawText',window,'Please have a rest...',FixationRect(1)-150,FixationRect(2),[0 0 0]);%��ʾ��ʼ
      Screen('Flip', window);
      while KbCheck; end
      KbWait;
      end
   
   end
    
    %%��ȡ��ǰ��Ӧ�Ĵ̼�ǿ�Ⱦ��󣨹�դ�Աȶȣ��ͷ�Ӧ����
    strengthmatrix=[];
    responsematrix=[];
    conditions=paramatrix(i,2);%staircase number
    if i~=1
       strengthmatrix=paramatrix(find(paramatrix(1:i-1,2)==conditions),7);
       responsematrix=paramatrix(find(paramatrix(1:i-1,2)==conditions),8);
    end

   %%���ݷ�����ֵ��ȷ��ÿ��trial��դ�ĳ���ʱ��
   paramatrix(i,7)=updownstaircase(stairtype,strengthmatrix,responsematrix,...
                       minstrength,maxstrength,initialstrength(mod(conditions,2)+1));

   %%%%%%���ɹ�դ%%%%%%%%%%%%%%%%%%%%
    GratingSize=round(paramatrix(i,3)*pixelsperdeg);
    
    gratingphase=randsample(0:pi/6:2*pi,1);%ÿ��trial����λ���
    i_2sd_size=GratingSize; %����Gabor��2sd��С������
    i_Speriod=SpatialPeriod;%i_Speriod,�����դ�Ŀռ����ڣ�����
    i_speed=(paramatrix(i,5)*pixelsperdeg)*paramatrix(i,6);%�ٶ�*�˶�����
    i_phase=gratingphase;%i_phase,�����դ����λ
    i_contrast=paramatrix(i,4);%i_contrast,��׼��դ�ĶԱȶ�   
    i_orientation=0;%i_orientation,�����դ�ĳ���
    i_ramptime=round(paramatrix(i,7));
    
    gratingmatrix=driftGabormatrix(frame_rate,background,i_2sd_size,i_Speriod,i_speed,i_phase,i_contrast,i_orientation,i_ramptime);
    %gratingmatrix=driftSinBlurGratingmatrix(frame_rate,background,i_2sd_size*3,i_Speriod,i_speed,i_phase,i_contrast,i_orientation,i_ramptime);
    
    
    gratingmatrix=round(gratingmatrix);
    ActuallSize=size(gratingmatrix);
    GratingRect0=CenterRect([0 0 ActuallSize(1) ActuallSize(2)],windowRect);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   
  %% ���ִ̼�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %����ÿ��trial��ʼ��ע�ӵ�
    for pp=1:round(FixDuration/framedur)  
         Screen('FillOval',window,FixLum,FixationRect);%fixation 
         Screen('Flip', window);
    end
    
    %%grating
    grating_frames=length(gratingmatrix(1,1,:));
    for pp=1:grating_frames
        gratings(pp)=Screen('MakeTexture',window,  gratingmatrix(:,:,pp));
        
        Screen('DrawTexture', window,gratings(pp),[],GratingRect0);%��դ
        Screen('FillOval',window,FixLum,FixationRect);%fixation 
        Screen('Flip',window);     
    end
    
    %ע�ӵ�
    Screen('FillOval',window,FixLum,FixationRect);%fixation 
    Screen('Flip', window);
    
    %%%%%%��¼������Ӧ%%%%%
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
     
    if keycode(qkey)==1 %q���˳�
        break
    end
       
    if (keycode(leftkey)==1 && paramatrix(i,6)==-1 && sum(keycode)==1) || ... %%left������ʾ���������˶�
        (keycode(rightkey)==1 && paramatrix(i,6)==1 && sum(keycode)==1)      %%right������ʾ���������˶�
          paramatrix(i,8)=1;
      else
          paramatrix(i,8)=0;
          sound(errorsound_data,samplefrq);
          %Beeper(1000,1,0.2)
    end
     
     %%%%%%�洢����%%%%%%%
     save([subjectid '_paramatrix'],'paramatrix');
     
     for pp=1:grating_frames 
       Screen('Close',gratings(pp));%ÿ���Դζ�Ҫ�ر����ɵ�Gabor������Ȼ��ռ�úܶ��ڴ�ռ�
     end
    
     %%%%%���԰�Ctrl������һ��trial%%%%%
     nexttrial=KbName('control');
     
     Screen('FillOval',window,FixLum+100,FixationRect);%fixation 
     Screen('Flip',window);
     while keycode(nexttrial)==0
         WaitSecs(0.0001);
         [touch,secs,keycode]=KbCheck;
     end
     
end

Screen('CloseAll');

