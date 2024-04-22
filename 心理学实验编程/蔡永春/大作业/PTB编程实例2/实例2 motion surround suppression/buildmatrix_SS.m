%%20201014 motion surround suppression����������� by Cai Yongchun
%% column 1 trial number
%% column 2 staircase��ţ�1 2 С��դ�� 3 4 ���դ; 
%% column 3 ��դ��С����˹�����2sdΪ 1 or 5 degree
%% column 4 ��դ�Աȶ�
%% column 5 ��դ�˶��ٶ� degree/second
%% column 6 ��դ�˶�����-1Ϊ�����˶���1Ϊ�����˶���
%% column 7 ��դ����ʱ�䣺ʱ���˹����sd
%% column 8 �ж������1���˶������ж���ȷ��0���˶������жϴ���

GratingContrast=0.7;
DriftSpeed=4; %degree/second
%GratingSize=[1 5]; %degree
GratingSize=[0.67 6.7]; %degree
StaircaseNum=[1 2];%ÿ��condition��2��staircase
DriftDirection=[-1 1];
trialpercondition=20;

%%����ʵ��trial������������
[x0,x1,x2]=ndgrid(GratingSize,StaircaseNum,DriftDirection);%���ɲ�����Ͼ���
combinedpara=[x0(:),x1(:),x2(:)];%ʵ��trial���е��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%���ɲ�������%%%%%%%%%%%
col=8;%��������һ��6��
paramatrixtemp0=zeros(length(combinedpara(:,1)),col);
paramatrixtemp0(:,3)=combinedpara(:,1);%grating size
paramatrixtemp0(:,6)=combinedpara(:,3);%drift direction -1 ���� 1 ����

temp0=combinedpara(:,2);%staircase number
paramatrixtemp0(:,2)=floor(paramatrixtemp0(:,3)/max(paramatrixtemp0(:,3)))+1;
paramatrixtemp0(:,2)=(paramatrixtemp0(:,2)-1)*2+temp0;%���ݱ�� 1 2 ��ʾС��դ�� ���3 4 ��ʾ���դ
paramatrixtemp0(:,4)=GratingContrast;
paramatrixtemp0(:,5)=DriftSpeed;

paramatrix0=[];
for j=1:trialpercondition
    paramatrix0=[paramatrix0;paramatrixtemp0];
end

paramatrix=[];
[pointer,index]=Shuffle(paramatrix0(:,1));%%%���Ҵ̼��Ĵ���
for i=1:length(paramatrix0(:,1))
    paramatrix(i,:)=paramatrix0(index(i),:);
end

paramatrix(:,1)=[1:length(paramatrix(:,1))]';

clearvars -except paramatrix %��������ռ��е����б���������paramatrix

