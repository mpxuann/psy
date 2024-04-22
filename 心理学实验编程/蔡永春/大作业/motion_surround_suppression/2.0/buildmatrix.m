function buildmatrix(subject)
    %% column 1 trial number
    % column 2 staircase编号：1 小刺激，2 中刺激，3 大刺激; 
    % column 3 刺激大小：高斯包络的sd为 0.4 or 1.2 or 2 degree
    % column 4 刺激大小：sd*4
    % column 5 刺激运动速度 4 degree/second
    % column 6 刺激运动方向-1为朝左运动，1为朝右运动；
    % column 7 刺激呈现时间：0.1s
    % column 8 判断情况：1，运动方向判断正确；0，运动方向判断错误
    % column 9 反应时

DriftSpeed=4; %degree/second
GratingSize=[1.6, 4.8, 8.0]; %degree
DriftDirection=[-1, 1];
StimTime = 0.05; 
trialpercondition = 2;

%%生成实验trial的所有情况组合
[x0,x1] = ndgrid(GratingSize,DriftDirection);%生成参数组合矩阵
CombinedParamatrix = [x0(:),x1(:)];%实验trial所有的条件组合

% 绘制矩阵单元
column = 8;
ParaMatrixUnit = zeros(length(CombinedParamatrix(:,1)),column);
ParaMatrixUnit(:,6) = CombinedParamatrix(:,2);
ParaMatrixUnit(:,7) = StimTime;
ParaMatrixUnit(:,4) = CombinedParamatrix(:,1); %gratingsize
ParaMatrixUnit(:,2) = ceil(0.3*ParaMatrixUnit(:,4)); % 1 小刺激，2 中刺激，3 大刺激
ParaMatrixUnit(:,3) = 0.25*ParaMatrixUnit(:,4); %Spatial sd
ParaMatrixUnit(:,5) = DriftSpeed; % 4 degree/sec


% 重复矩阵单元并打乱次序
ParaMatrixTemp = [];
for i = 1:trialpercondition
    ParaMatrixTemp = [ParaMatrixTemp;ParaMatrixUnit];%重复试次
end

paramatrix=[];
[~,index]=Shuffle(ParaMatrixTemp(:,1));%打乱刺激的次序
for i=1:length(ParaMatrixTemp(:,1))
    paramatrix(i,:)=ParaMatrixTemp(index(i),:);
end

paramatrix(:,1)=[1:length(paramatrix(:,1))]';

save([subject '_paramatrix'],'paramatrix');


end

