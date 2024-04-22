windowNumber = 0;
windowColor = [100 100 100];
rect = [];
[windowPtr,rect] = Screen('OpenWindow',windowNumber,windowColor,rect);
picRect1 = CenterRect([0 0 20 4],rect);
picRect2 = CenterRect([0 0 4 20],rect);
Duration = 2;
frame_rate = Screen('Framerate',windowPtr);
framedur = 1/frame_rate;
for i = 1:round(Duration/framedur)
    Screen('fillrect',windowPtr,[10 10 10],picRect2);
    Screen('fillrect',windowPtr,[10 10 10],picRect1);
    Screen(windowPtr,'flip');
end
Screen('closeall');
