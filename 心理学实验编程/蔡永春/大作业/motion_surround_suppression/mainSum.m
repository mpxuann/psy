function mainSum()
    Screen('Preference', 'SkipSyncTests', 1);
    winNum = 0;
    background = 128;
    [winPtr, winRect] = Screen('OpenWindow', winNum, background); %screen函数，设置屏幕参数

    %% buildmatrix1为向左运动
    % column 1 trial number
    % column 2 随机点大小
    % column 3 随机点运动方向：-，1为向右运动
    % column 4 被试判断情况：1.运动方向判断正确；0.运动方向判断错误
    % column 5 被试反应时间
    matrix = zeros(90, 5);
    cnt = 0;

    for rep = 1:15

        for i = 1:3

            for j = [-1, 1]
                cnt = cnt + 1;
                matrix(cnt, 2) = i;
                matrix(cnt, 3) = j;
            end

        end

    end

    matrix = matrix(randperm(cnt), :);

    for i = 1:cnt
        matrix(i, 1) = i;
    end

    save("matrix.mat", "matrix");

    %% run test
    distanceToScreen = 57; %屏幕距离 厘米
    widthOfScreen = 33.8; %屏幕宽度 厘米
    xResolution = winRect(3); %屏幕水平分辨率
    pixelSize = atan((widthOfScreen / xResolution) / distanceToScreen) * 180 / pi; %计算每个像素的度数
    S = [round(2 / pixelSize), round(1.2 / pixelSize), round(0.4 / pixelSize)]; %计算大中小噪声像素
    noiPix = 5; %小块噪声大小

    for i = 1:3
        noiNum = round(S(i) / noiPix);
        S(i) = noiPix * noiNum;

        if mod(S(i), 2) == 1
            S(i) = S(i) + 5;
        end

    end

    frameRate = Screen('FrameRate', winPtr); %获取屏幕刷新率
    frameDur = 1 / frameRate; %计算每一帧的呈现时间

    midX = round(winRect(3) / 2);
    midY = round(winRect(4) / 2);

    for i = 1:cnt

        stimSize = S(matrix(i, 2));
        dir = matrix(i, 3);

        %% 呈现注视点
        fixDur = 0.5; %注视点呈现时间为500毫秒

        for time = 1:round(fixDur / frameDur)
            Screen('FillOval', winPtr, [0, 0, 0], [midX - 3 midY - 3 midX + 3 midY + 3]); %注视点
            Screen('flip', winPtr); %呈现
        end

        %% 呈现运动噪声
        stimDur = 0.1; %刺激持续时间
        stimCon = 0.45; %刺激对比度
        noiNum = round(stimSize / noiPix); %总共有多少小噪声
        stimRect = CenterRect([0 0 stimSize stimSize], winRect);
        noiMatrix = rand(noiNum, noiNum) * 2 - 1;
        temp = ones(noiPix);
        stimMatrix = kron(noiMatrix, temp);

        [x, y] = meshgrid(round(-stimSize / 2):round(stimSize / 2) - 1, round(-stimSize / 2):round(stimSize / 2) - 1);
        maskRadius = stimSize / 2; %mask半径
        circleMask = (x .^ 2 + y .^ 2 <= maskRadius ^ 2);
        sd = round(stimSize / 4); %高斯参数（经验值）
        gauseMask = exp(- (x .^ 2 + y .^ 2) / (2 * sd ^ 2)); %高斯

        pixelMov = round(4 / pixelSize); %每4度视角有多少个像素

        for time = 1:round(stimDur / frameDur)
            stimMatrixMov = circshift(stimMatrix, dir * i * pixelMov, 2); %移动噪声
            stimMatrixMov = background * (1 + stimCon * stimMatrixMov .* circleMask .* gauseMask); %计算噪声
            stimTexture = Screen('MakeTexture', winPtr, stimMatrixMov); %转换纹理
            Screen('DrawTexture', winPtr, stimTexture, [], stimRect);
            Screen('FillOval', winPtr, [0, 0, 0], [midX - 3 midY - 3 midX + 3 midY + 3]); %注视点
            Screen(winPtr, 'Flip');
        end

        %% 获取按键
        Screen('FillOval', winPtr, [0, 0, 0], [midX - 3 midY - 3 midX + 3 midY + 3]); %注视点
        Screen('flip', winPtr);

        keyLeft = KbName('f');
        keyRight = KbName('j');
        secsBegin = GetSecs; %当前时间点
        waitTime = 2; %最长等待2s

        while GetSecs - secsBegin < waitTime
            KbWait([], 2, secsBegin + waitTime);
            [~, ~, keycode] = KbCheck;

            if GetSecs - secsBegin > waitTime
                break;
            end

            if (keycode(keyLeft) || keycode(keyRight)) == 1
                break;
            end

        end

        matrix(i, 5) = GetSecs - secsBegin;
        keyAns = 0;

        if (matrix(i, 5) <= waitTime)

            if keycode(keyLeft) == 1
                keyAns = -1;
            else
                keyAns = 1;
            end

        end

        if (keyAns == dir)
            matrix(i, 4) = 1;
        end

    end

    save("ansMatrix.mat", "matrix");
    Screen('CloseAll');

    %% 绘图
    rtMean = [0 0 0];
    rtSum = [0 0 0];

    for i = 1:cnt

        if matrix(i, 4) == 1
            rtMean(matrix(i, 2)) = rtMean(matrix(i, 2)) + matrix(i, 5);
            rtSum(matrix(i, 2)) = rtSum(matrix(i, 2)) + 1;
        end

    end

    for i = 1:3

        if rtSum(i) > 0
            rtMean(i) = rtMean(i) / rtSum(i);
        end

    end

    plot(S, rtMean);
    xlabel("size(px)");
    ylabel("rt(ms)");
end
