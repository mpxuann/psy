%%2020 10 13
%%by Cai Yongchun
%%小数2 3 4  大数7 8 9   一共9对数字对
%%不同大小的数字吸引注意，detection任务

function num_attention(subjectid,start,over) 
   
    load([subjectid '_paramatrix']); %%导入参数矩阵paramatrix

    background=128;
    
    %%openwindow
    [windowPtr, windowRect]=Screen('OpenWindow', 0, background);
    HideCursor;
    hz=Screen('FrameRate',windowPtr);%获取当前刷新率
    framedur=1/hz;%单位，秒

    fixation_dur=1000;%duration of fixation, 1000ms
    cue_dur=100;%duration of cue, 100ms
    target_dur=200;%duration of target, 200ms
    
    fix_size=[12 4];
    cue_size=65;%数字cue的大小
    target_w=16;%目标宽度
    target_l=16;%目标长度
    hoffset=200;%horizontal offset,左右两侧cue偏离中心注视点的距离，像素数
    
    cue_rect=CenterRect([0 0 cue_size cue_size],windowRect);
    cue_left_rect=OffsetRect(cue_rect,-hoffset,0); %左侧cue位置
    cue_right_rect=OffsetRect(cue_rect,hoffset,0); %右侧cue位置
    
    target_rect0=CenterRect([0 0 target_w target_l],windowRect);
    target_left_rect=OffsetRect(target_rect0,-hoffset,0);%左侧target位置
    target_right_rect=OffsetRect(target_rect0,hoffset,0);%右侧target位置
    
    fix_rect1=CenterRect([0 0 fix_size(1) fix_size(2)],windowRect);%注视点位置
    fix_rect2=CenterRect([0 0 fix_size(2) fix_size(1)],windowRect);%注视点位置
    
    load matchednummatrix; %调入需要呈现的图形像素矩阵，数字，作为cue
    nummatrix=(nummatrix/255)*background; %把数字矩阵的白色背景的灰度值设置为屏幕灰色背景
    
    for kk=1:10
       numimage(kk)=Screen('MakeTexture',windowPtr,nummatrix(:,:,kk));%%把数字矩阵转化为可呈现的纹理图
    end
    %%%%%%%%%%%%%%%%%%%%% 

     %%%实验开始之前的fixation，任意键开始实验%%%%
     Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
     Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
     Screen('DrawText',windowPtr,'Be Ready to begin......',350,250,[0 0 0]); 
     Screen('Flip', windowPtr); 
     
     %while KbCheck end
     KbWait;
  
 for trialindex=start:over
  
 %%%%%%%%%%%%%%%%呈现刺激以及记录反应%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% 获取用到的按键键值
    quitekey=KbName('q');
    downkey=KbName('down');
    keycode=zeros(1,256);
    
    %%%%%呈现注视点%%%%%%
    for i=1:(fixation_dur/1000)*hz
        Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
        Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
        Screen('Flip', windowPtr);
    end


    %%%%%%%%%%%呈现cue%%%%%%%%%%
   for i=1:(cue_dur/1000)*hz
        Screen('DrawTexture',windowPtr, numimage(paramatrix(trialindex,7)+1),[],cue_left_rect,0);%左数字
        Screen('DrawTexture',windowPtr, numimage(paramatrix(trialindex,8)+1),[],cue_right_rect,0);%右数字
        Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
        Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
        Screen('Flip',windowPtr);
   end
    
    %%%%%%ISI blank%%%%%
    for i=1:(paramatrix(trialindex,12)/1000)*hz%呈现注视点
        Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
        Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
        Screen('Flip', windowPtr);
    end
   
    
    %%%%%呈现target%%%%%
    if paramatrix(trialindex,5)==-1
        target_rect=target_left_rect;
      elseif paramatrix(trialindex,5)==1
        target_rect=target_right_rect;
    end

     %secs0=getsecs;%把target flip到屏幕后，立即开始记录反应时
     for i=1:(target_dur/1000)*hz
        Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
        Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
        if paramatrix(trialindex,6)==0 %非catch trial
           Screen('FillOval',windowPtr,[0 0 0],target_rect);%target
        end
        Tonset(i)=Screen('Flip', windowPtr);
     end
    
    %%%%fixation%%%%
    Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
    Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
    Screen('Flip', windowPtr);%刺激消失，把黑注视点flip到桌面
    
    %%%%%纪录安键%%%%%%%%%
    noresponse=1;
    secs0=GetSecs;
    while noresponse && (GetSecs-secs0<1.5)%等待按键，如果1.5秒还没作出反应，则退出此循环
          [touch,secs,keycode]=KbCheck;
          if keycode(downkey)||keycode(quitekey)==1 
              noresponse=0; %按下了下方向键，或者q键时，则退出此等待按键的循环
          end
    end
    secs1=GetSecs;%记录按键的时间（也可用上面的secs代替）
    paramatrix(trialindex,11)=(secs1-Tonset(1))*1000;%记录反应时，转换为毫秒，写入参数矩阵第11列
    
   %%如果非catch trial没有按键，或者catch trial按键了，则提示错误 
   if (paramatrix(trialindex,6)==1&&keycode(downkey)==1) || (paramatrix(trialindex,6)==0&&keycode(downkey)==0) 
        paramatrix(trialindex,10)=1;
        Beeper(1000,1,0.2);%catchtrial按键 错误提示音（1000hz 0.2秒的提示音）
      else
        paramatrix(trialindex,10)=0;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    if keycode(quitekey)==1
        break %如果按了q键，则退出程序
    end
    
    %%%%按键完毕给灰屏%%%%%
 %   Screen('FillRect',windowPtr,background);%fixation
    Screen('Flip',windowPtr);

    %%%%保存结果%%%%
    save([subjectid '_paramatrix'],'paramatrix');
    WaitSecs(1.5);%等待2秒进入下一trial

    %%每88个trial休息一次，一共3个block
    if trialindex==88||trialindex==176
       SCREEN('DrawText',windowPtr,'Please take a break, Press any key to continue...',350,250, [0 0 0]);
       Screen('FillRect',windowPtr,[0 0 0],fix_rect1);%fixation
       Screen('FillRect',windowPtr,[0 0 0],fix_rect2);%fixation
       Screen('Flip',windowPtr);
       KbWait;
    end
 end
Screen('CloseAll')
