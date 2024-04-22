%%column1 sequence number
%%column2 condition number
%%column3 validation of cue:valid or invalide,大数字默认为有效cue，值为1；被小数字提示，则为-1
%%column4 location of large number cue: left or right
%%column5 location of target:left or right
%%column6 是否是catch trial，是为1 不是为0
%%column7 左侧的数字
%%column8 右侧的数字
%%column9 （暂未指定意义）
%%column10 catch trial是否按键
%%column11 目标判断的反应时
%%column12 isi duration between offset of cue and onset of target

numbercondition=1:9;%一共9对数字
cuevalidity=[1 -1];%cue的有效性
cuelocation=[1 -1];%cue的位置
ISIdur=[150 600];%cue到target之间的时间间隔


trialpercondition=3;%每种情况下的trial数3（每一个空间位置）
numofcue=length(numbercondition);%数字cue的个数
catchtrials=48;%catchtrial（只呈现cue，不呈现目标刺激，被试不作按键反应。这是为了减少被试的期待效应）个数
col=12;%参数矩阵一共多少列
numcue=[2 7;2 8;2 9;...
        3 7;3 8;3 9;...
        4 7;4 8;4 9];%9对数字对

%%%生成实验trial的所有情况组合%%%%
[x0,x1,x2,x3]=ndgrid(numbercondition,cuevalidity,cuelocation,ISIdur);%生成参数组合矩阵
combinedpara=[x0(:),x1(:),x2(:),x3(:)];%实验trial所有的条件组合
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%生成各种cue下的参数矩阵%%%%%%%%%%%%%%%%
%%非catch trial
paramatrixtemp0=zeros(length(combinedpara(:,1)),col);
paramatrixtemp0(:,2)=combinedpara(:,1);%numbercondition
paramatrixtemp0(:,3)=combinedpara(:,2);%cuevalidity
paramatrixtemp0(:,4)=combinedpara(:,3);%cuelocation
paramatrixtemp0(:,12)=combinedpara(:,4);%ISIdur
paramatrixtemp0(:,6)=0;%是否是catch trial，不是catchtrial为则0
for i=1:length(combinedpara(:,1)) %设定大小数字的左/右位置
  num0=numcue(paramatrixtemp0(i,2),:);%数字对
  if paramatrixtemp0(i,4)==-1;%大数字在左侧
      paramatrixtemp0(i,7)=num0(2);paramatrixtemp0(i,8)=num0(1);
    elseif paramatrixtemp0(i,4)==1%大数字在右侧
      paramatrixtemp0(i,7)=num0(1);paramatrixtemp0(i,8)=num0(2);
  end
  paramatrixtemp0(i,5)=paramatrixtemp0(i,3)*paramatrixtemp0(i,4);%cue的有效性以及大数字的位置决定了target的位置
end
paramatrix0=[];

for j=1:trialpercondition %重复拼接以上矩阵trialpercondition次
    paramatrix0=[paramatrix0;paramatrixtemp0];
end

paramatrix1=paramatrix0;%这是非catch trial的参数矩阵
    

%%catch trial
paramatrix0=zeros(catchtrials,col);
for i=1:catchtrials
  num0=numcue(randsample([1 2 3 4 5 6 7 9],1),:);%为每个catch trial随机选定一个数字对
  paramatrix0(i,2)=10;%condition number
  if mod(i,2)==1
     paramatrix0(i,3)=1;%valid
   else
     paramatrix0(i,3)=-1;%invalid
  end
  paramatrix0(:,4)=-1;%location of cue: -1,left
  paramatrix0(1:(catchtrials/2),4)=1;%location of cue:1,right
  paramatrix0(i,5)=paramatrix0(i,3)*paramatrix0(i,4);
  if paramatrix0(i,4)==-1;
      paramatrix0(i,7)=num0(2);paramatrix0(i,8)=num0(1);
    elseif paramatrix0(i,4)==1
      paramatrix0(i,7)=num0(1);paramatrix0(i,8)=num0(2);
  end
end
paramatrix0(:,6)=1;%是catchtrial

paramatrix2=paramatrix0;%这是catch trial的参数矩阵


%%%%%%%%%%%%%%%%%%%%%%%%%%%合并各catch trial和非catch trial的参数矩阵并随机化%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
paramatrix=[paramatrix1;paramatrix2];

paramatrix0=paramatrix;
[pointer,index]=Shuffle(paramatrix0(:,1));%%%打乱刺激的次序
for i=1:length(paramatrix0(:,1))
    paramatrix(i,:)=paramatrix0(index(i),:);
end

paramatrix(:,1)=[1:length(paramatrix(:,1))]';

clearvars -except paramatrix %清除工作空间中的所有变量，除了paramatrix