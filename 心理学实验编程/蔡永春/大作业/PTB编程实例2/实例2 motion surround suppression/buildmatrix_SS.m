%%20201014 motion surround suppression参数矩阵程序 by Cai Yongchun
%% column 1 trial number
%% column 2 staircase编号：1 2 小光栅； 3 4 大光栅; 
%% column 3 光栅大小：高斯包络的2sd为 1 or 5 degree
%% column 4 光栅对比度
%% column 5 光栅运动速度 degree/second
%% column 6 光栅运动方向-1为朝左运动，1为朝右运动；
%% column 7 光栅呈现时间：时间高斯包络sd
%% column 8 判断情况：1，运动方向判断正确；0，运动方向判断错误

GratingContrast=0.7;
DriftSpeed=4; %degree/second
%GratingSize=[1 5]; %degree
GratingSize=[0.67 6.7]; %degree
StaircaseNum=[1 2];%每个condition有2个staircase
DriftDirection=[-1 1];
trialpercondition=20;

%%生成实验trial的所有情况组合
[x0,x1,x2]=ndgrid(GratingSize,StaircaseNum,DriftDirection);%生成参数组合矩阵
combinedpara=[x0(:),x1(:),x2(:)];%实验trial所有的条件组合
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%生成参数矩阵%%%%%%%%%%%
col=8;%参数矩阵一共6列
paramatrixtemp0=zeros(length(combinedpara(:,1)),col);
paramatrixtemp0(:,3)=combinedpara(:,1);%grating size
paramatrixtemp0(:,6)=combinedpara(:,3);%drift direction -1 朝左； 1 朝右

temp0=combinedpara(:,2);%staircase number
paramatrixtemp0(:,2)=floor(paramatrixtemp0(:,3)/max(paramatrixtemp0(:,3)))+1;
paramatrixtemp0(:,2)=(paramatrixtemp0(:,2)-1)*2+temp0;%阶梯编号 1 2 表示小光栅； 编号3 4 表示大光栅
paramatrixtemp0(:,4)=GratingContrast;
paramatrixtemp0(:,5)=DriftSpeed;

paramatrix0=[];
for j=1:trialpercondition
    paramatrix0=[paramatrix0;paramatrixtemp0];
end

paramatrix=[];
[pointer,index]=Shuffle(paramatrix0(:,1));%%%打乱刺激的次序
for i=1:length(paramatrix0(:,1))
    paramatrix(i,:)=paramatrix0(index(i),:);
end

paramatrix(:,1)=[1:length(paramatrix(:,1))]';

clearvars -except paramatrix %清除工作空间中的所有变量，除了paramatrix

