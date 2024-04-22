function RT(subject,trials,num)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明

Screen('CloseAll');
HideCursor;
Screen('Preference', 'SkipSyncTests', 1);                                                                           
background=128; %gray level of background 
[window,windowRect]=Screen('OpenWindow',0,background);
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);        
frame_rate=Screen('FrameRate',window);
framedur=1/frame_rate;%单位s

%% 定义键盘参数
keycode = zeros(1,256);
quit = KbName('q');
space = KbName('space');
 
%% 实验开始之前呈现注视点
%KbWait([],1);
while KbCheck;end
%% 定义注视点参数
FixLum = 0;%注视点亮度为0
FixationRect=CenterRect([0 0 8 8],windowRect);%注视点位置
Screen('FillOval',window,FixLum,FixationRect);% draw fixation 
Screen('DrawText',window,'Press any key(s) to continue',FixationRect(1)-250,650,[0 0 0]);%提示开始   
Screen('Flip', window);   
KbWait;
%KbWait([],1);
while KbCheck;end
Screen('flip',window);
%生成这个block的参数矩阵
RT_buildmatrix(subject,trials);
load([subject '_paramatrix']);

%进入试次
for i = 1:length(paramatrix(:,1))
    
    % ISI random >1s
    ISI = 1+rand();
    for t = 1:round(ISI/framedur)
       %Screen('FillRect',window,background,CenterRect([0 0 100 100],windowRect));
       Screen('Flip', window);
    end
    
    keyisdown = 0;
    restime = 0;
    while KbCheck; end
    
    %   column 2 color -1 red; 1 green
    %   column 3 stimuli time 1s
    %   column 4 stimuli size 100 pix
    %   column 5 response time
    %   column 6 response correction 
        % red: 1 true 0 false
        % green: 1 false 0 true
    
    width = windowRect(3)-paramatrix(i,4);
    hight = windowRect(4)-paramatrix(i,4);
    x = width*rand()+paramatrix(i,4)/2;
    y = hight*rand()+paramatrix(i,4)/2;

    
    if paramatrix(i,2) == 1
        color = [0,255,0];
    else
        color = [255,0,0];
    end
    
    start = GetSecs;
    for t = 1:round(paramatrix(i,3)/framedur)
        Screen('FillOval', window,color,[x-50 y-50 x+50 y+50]);
        Screen('flip',window);
        [keyisdown,secs,keycode] = KbCheck;
        if keycode(space) == 1
            restime = secs-start;
            break;
        end
    end
    
    % 刺激结束
    if paramatrix(i,2)==1
        if keyisdown==1
            paramatrix(i,6) = 0;
        else
            paramatrix(i,6) = 1;
        end
    else
        if keyisdown == 1
            paramatrix(i,6) = 1;
            paramatrix(i,5) = restime*1000;
        else
            paramatrix(i,6) = 0;
        end
    end
end       
% save data

Screen('Flip',window);
save([subject '_paramatrix_' int2str(num)],'paramatrix');

for i = 1:60
    Screen('flip',window);
end
Screen('closeall');

RT_fittingresult(subject,num);

end