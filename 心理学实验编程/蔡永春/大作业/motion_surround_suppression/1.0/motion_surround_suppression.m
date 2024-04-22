function motion_surround_suppression(subject,blocks)
%RANDOMDOT_MOTION_DISPLAY 此处显示有关此函数的摘要
% 此处显示详细说明


HideCursor;
Screen('Preference', 'SkipSyncTests', 1);                                                                           
background=128; %gray level of background 
[window,windowRect]=Screen('OpenWindow',0,background);
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);         % 这一行有什么用？
frame_rate=Screen('FrameRate',window);
framedur=1/frame_rate;%单位s

%% 定义刺激参数%%%%%%%%%%%%
DistanceToScreen=40; %屏幕距离 厘米
WidthOfScreen=35.4; %屏幕宽度 厘米  mpx的电脑35.4*19.9 cm
XResolution=windowRect(3); %屏幕水平分辨率
pixelsize=atan((WidthOfScreen/XResolution)/DistanceToScreen)*180/pi;%计算每个像素的度数
pixelsperdeg=1/pixelsize;%每度视角有多少个像素
ISI = 0.5; 

%% 定义注视点参数
FixDuration=0.5;%注视点呈现时间0.5s
FixLum = 0;%注视点亮度为0
FixationRect=CenterRect([0 0 8 8],windowRect);%注视点位置

%% 定义键盘参数
keycode = zeros(1,256);


% 开始n个block
for n = 1:blocks

    Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    %% 实验开始之前呈现注视点
    %KbWait([],1);
    while KbCheck;end
    Screen('FillOval',window,FixLum,FixationRect);% draw fixation 
    Screen('DrawText',window,'Press any key(s) to continue',FixationRect(1)-250,650,[0 0 0]);%提示开始   
    Screen('Flip', window);   
    KbWait;
    %KbWait([],1);
    while KbCheck;end

    %生成这个block的参数矩阵
    buildmatrix(subject);
    load([subject '_paramatrix']);

    %进入试次
    for i = 1:length(paramatrix(:,1))

        %生成该试次的噪声图
        StimContrast=0.45; %对比度
        StimSize=2*pixelsperdeg*paramatrix(i,4);%刺激大小

        NoisePix=10;%每个噪音点的像素数；
        NoiseNum=round(StimSize/NoisePix);%水平或竖直方向上的噪音点个数
        StimSize=NoisePix*NoiseNum;%重新计算刺激大小

        StimRect=CenterRect([0 0 StimSize StimSize],windowRect);%%刺激呈现于屏幕中央,刺激的位置矩阵
        [x,y]=meshgrid(round(-StimSize/2):round(StimSize/2)-1,round(-StimSize/2):round(StimSize/2)-1);

        maskradius=StimSize/2;

        sd=paramatrix(i,3)*pixelsperdeg;
        Circlemask=exp(-(x.^2+y.^2)/(2*sd^2));%生成三维高斯mask
        %Circlemask=(x.^2+y.^2 <= maskradius^2);%生成圆形mask

        NoiseMatrix=rand(NoiseNum,NoiseNum)*2-1;
        temp0=ones(NoisePix);
        StimMatrix0=kron(NoiseMatrix,temp0);%生成像素噪音点，值范围-1~1; kron命令是扩大每个noise元素的值为设定的噪音像素大小
        
        % ISI 500ms
        for t = 1:round(ISI/framedur)
            Screen('FillRect',window,background,CenterRect([0 0 StimSize StimSize],windowRect));
            Screen('Flip',window);
        end

        
        % 500ms fixation
        for t = 1:round(FixDuration/framedur)
            Screen('FillOval',window,FixLum,FixationRect);% draw fixation 
            Screen('Flip', window);   
        end

        
        start = GetSecs;
        for t = 1:round(paramatrix(i,7)/framedur)
            StimMatrix1 = circshift(StimMatrix0,paramatrix(i,6)*round(t*framedur*paramatrix(i,5)*pixelsperdeg),2);
            StimMatrix=background*(1+StimContrast*StimMatrix1.*Circlemask);
            StimTexture=Screen('MakeTexture',window, StimMatrix);%把矩阵变为纹理
            Screen('DrawTexture',window,StimTexture,[],StimRect);%画纹理
            Screen('FillOval',window,FixLum,FixationRect);% draw fixation 
            Screen(window,'Flip');%呈现刺激
        end
        
        %刺激结束
        Screen('FillOval',window,FixLum,FixationRect);% draw fixation 
        Screen('Flip',window);
        
        %设置按键参数
        quit = KbName('q');
        left = KbName('f');
        right = KbName('j');
        
        
        % %KbWait([],1);
        % while KbCheck;end%等待所有键释放
        
        keycode = zeros(1,256);
        %
        while (keycode(quit)==0 && keycode(left)==0 && keycode(right)==0)
            % WaitSecs(0.0001);
            % [keyisdown,secs,keycode]=KbCheck;
            [secs,keycode,~]= KbWait;
        end
        
        restime = secs-start;
        %记录按键反应
        if keycode(left)==1 || keycode(right)==1
            if (keycode(left)==1 && paramatrix(i,6)==-1)||...
                    (keycode(right)==1 && paramatrix(i,6)==1)
                paramatrix(i,8) = 1;
                paramatrix(i,9) = restime;
            else
                paramatrix(i,8) = 0;
                paramatrix(i,9) = restime;
            end
        end
        
        %按q(quit)退出
        if keycode(quit)
            % %KbWait([],1);
            % while KbCheck;end
            for i = 1:60
                Screen('flip',window);
            end
            Screen('closeall');
        end

        
            
        end
        
    Screen('Flip',window);
    
    save([subject '_paramatrix_' int2str(n)],'paramatrix');
    
    if n<blocks
        % %KbWait([],1);
        while KbCheck;end
        Screen('DrawText',window,['Block ' int2str(n) ' finished, take a rest. Press any key to continue next block :)'],FixationRect(1)-600,650,[0 0 0]);%提示开始   
        Screen('Flip', window);   
        KbWait;
    else
         while KbCheck; end
        % keyisdown = 0;
        % while ~keyisdown
        %     [keyisdown] = KbCheck;
            Screen('DrawText',window,'Finished! Thank You For Your Participation~. Press any key to Exit',FixationRect(1)-500,650,[0 0 0]);
            Screen('Flip',window);
            KbWait;
        
    end

end

fittingresult(subject,blocks);

% %KbWait([],1);
% while KbCheck; end
for i = 1:60
    Screen('flip',window);
end
Screen('closeall');



