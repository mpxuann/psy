function RT_buildmatrix(subject,trials)
    %%  column 1 trial number
    %   column 2 color -1 red 1green
    %   column 3 stimuli time 1s
    %   column 4 stimuli size 100 pix
    %   column 5 response time
    %   column 6 response correction 
        % red: 1 true 0 false
        % green: 1 false 0 true


color = [0];
fillovalSize = 100;
stimTime = 1;

%% 绘制矩阵单元
[x0] = ndgrid(color);%生成参数组合矩阵
CombinedParamatrix = [x0(:)];%实验trial所有的条件组合

column = 6;
ParaMatrixUnit = zeros(length(CombinedParamatrix(:,1)),column);
ParaMatrixUnit(:,2) = CombinedParamatrix(:,1);
ParaMatrixUnit(:,3) = stimTime;
ParaMatrixUnit(:,4) = fillovalSize; %Spatial sd


%% 重复矩阵单元并打乱次序
ParaMatrixTemp = [];
for i = 1:trials
    ParaMatrixTemp = [ParaMatrixTemp;ParaMatrixUnit];%重复试次
end

paramatrix=[];
[~,index]=Shuffle(ParaMatrixTemp(:,1));%打乱刺激的次序

for i=1:length(ParaMatrixTemp(:,1))
    paramatrix(i,:)=ParaMatrixTemp(index(i),:);
end

paramatrix(:,1)=[1:length(paramatrix(:,1))]';
paramatrix(:,2)=sign(rand(trials,1)-0.5);


save([subject '_paramatrix'],'paramatrix');


end