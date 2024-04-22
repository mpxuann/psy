%%2020 10 13
%%by Cai Yongchun
%%С��2 3 4  ����7 8 9   һ��9�����ֶ�
%%��ͬ��С����������ע�⣬detection����

function num_attention(subjectid,start,over) 
   
    load([subjectid '_paramatrix']); %%�����������paramatrix

    background=128;
    
    %%openwindow
    [windowPtr, windowRect]=Screen('OpenWindow', 0, background);
    HideCursor;
    hz=Screen('FrameRate',windowPtr);%��ȡ��ǰˢ����
    framedur=1/hz;%��λ����

    fixation_dur=1000;%duration of fixation, 1000ms
    cue_dur=100;%duration of cue, 100ms
    target_dur=200;%duration of target, 200ms
    
    fix_size=[12 4];
    cue_size=65;%����cue�Ĵ�С
    target_w=16;%Ŀ����
    target_l=16;%Ŀ�곤��
    hoffset=200;%horizontal offset,��������cueƫ������ע�ӵ�ľ��룬������
    
    cue_rect=CenterRect([0 0 cue_size cue_size],windowRect);
    cue_left_rect=OffsetRect(cue_rect,-hoffset,0); %���cueλ��
    cue_right_rect=OffsetRect(cue_rect,hoffset,0); %�Ҳ�cueλ��
    
    target_rect0=CenterRect([0 0 target_w target_l],windowRect);
    target_left_rect=OffsetRect(target_rect0,-hoffset,0);%���targetλ��
    target_right_rect=OffsetRect(target_rect0,hoffset,0);%�Ҳ�targetλ��
    
    fix_rect1=CenterRect([0 0 fix_size(1) fix_size(2)],windowRect);%ע�ӵ�λ��
    fix_rect2=CenterRect([0 0 fix_size(2) fix_size(1)],windowRect);%ע�ӵ�λ��
    
    load matchednummatrix; %������Ҫ���ֵ�ͼ�����ؾ������֣���Ϊcue
    nummatrix=(nummatrix/255)*background; %�����־���İ�ɫ�����ĻҶ�ֵ����Ϊ��Ļ��ɫ����
    
    for kk=1:10
       numimage(kk)=Screen('MakeTexture',windowPtr,nummatrix(:,:,kk));%%�����־���ת��Ϊ�ɳ��ֵ�����ͼ
    end
    %%%%%%%%%%%%%%%%%%%%% 

     %%%ʵ�鿪ʼ֮ǰ��fixation���������ʼʵ��%%%%
     Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
     Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
     Screen('DrawText',windowPtr,'Be Ready to begin......',350,250,[0 0 0]); 
     Screen('Flip', windowPtr); 
     
     %while KbCheck end
     KbWait;
  
 for trialindex=start:over
  
 %%%%%%%%%%%%%%%%���ִ̼��Լ���¼��Ӧ%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% ��ȡ�õ��İ�����ֵ
    quitekey=KbName('q');
    downkey=KbName('down');
    keycode=zeros(1,256);
    
    %%%%%����ע�ӵ�%%%%%%
    for i=1:(fixation_dur/1000)*hz
        Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
        Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
        Screen('Flip', windowPtr);
    end


    %%%%%%%%%%%����cue%%%%%%%%%%
   for i=1:(cue_dur/1000)*hz
        Screen('DrawTexture',windowPtr, numimage(paramatrix(trialindex,7)+1),[],cue_left_rect,0);%������
        Screen('DrawTexture',windowPtr, numimage(paramatrix(trialindex,8)+1),[],cue_right_rect,0);%������
        Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
        Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
        Screen('Flip',windowPtr);
   end
    
    %%%%%%ISI blank%%%%%
    for i=1:(paramatrix(trialindex,12)/1000)*hz%����ע�ӵ�
        Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
        Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
        Screen('Flip', windowPtr);
    end
   
    
    %%%%%����target%%%%%
    if paramatrix(trialindex,5)==-1
        target_rect=target_left_rect;
      elseif paramatrix(trialindex,5)==1
        target_rect=target_right_rect;
    end

     %secs0=getsecs;%��target flip����Ļ��������ʼ��¼��Ӧʱ
     for i=1:(target_dur/1000)*hz
        Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
        Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
        if paramatrix(trialindex,6)==0 %��catch trial
           Screen('FillOval',windowPtr,[0 0 0],target_rect);%target
        end
        Tonset(i)=Screen('Flip', windowPtr);
     end
    
    %%%%fixation%%%%
    Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
    Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
    Screen('Flip', windowPtr);%�̼���ʧ���Ѻ�ע�ӵ�flip������
    
    %%%%%��¼����%%%%%%%%%
    noresponse=1;
    secs0=GetSecs;
    while noresponse && (GetSecs-secs0<1.5)%�ȴ����������1.5�뻹û������Ӧ�����˳���ѭ��
          [touch,secs,keycode]=KbCheck;
          if keycode(downkey)||keycode(quitekey)==1 
              noresponse=0; %�������·����������q��ʱ�����˳��˵ȴ�������ѭ��
          end
    end
    secs1=GetSecs;%��¼������ʱ�䣨Ҳ���������secs���棩
    paramatrix(trialindex,11)=(secs1-Tonset(1))*1000;%��¼��Ӧʱ��ת��Ϊ���룬д����������11��
    
   %%�����catch trialû�а���������catch trial�����ˣ�����ʾ���� 
   if (paramatrix(trialindex,6)==1&&keycode(downkey)==1) || (paramatrix(trialindex,6)==0&&keycode(downkey)==0) 
        paramatrix(trialindex,10)=1;
        Beeper(1000,1,0.2);%catchtrial���� ������ʾ����1000hz 0.2�����ʾ����
      else
        paramatrix(trialindex,10)=0;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    if keycode(quitekey)==1
        break %�������q�������˳�����
    end
    
    %%%%������ϸ�����%%%%%
 %   Screen('FillRect',windowPtr,background);%fixation
    Screen('Flip',windowPtr);

    %%%%������%%%%
    save([subjectid '_paramatrix'],'paramatrix');
    WaitSecs(1.5);%�ȴ�2�������һtrial

    %%ÿ88��trial��Ϣһ�Σ�һ��3��block
    if trialindex==88||trialindex==176
       SCREEN('DrawText',windowPtr,'Please take a break, Press any key to continue...',350,250, [0 0 0]);
       Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
       Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
       Screen('Flip',windowPtr);
       KbWait;
    end
 end
Screen('CloseAll')
