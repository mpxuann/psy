%%column1 sequence number
%%column2 condition number
%%column3 validation of cue:valid or invalide,������Ĭ��Ϊ��Чcue��ֵΪ1����С������ʾ����Ϊ-1
%%column4 location of large number cue: left or right
%%column5 location of target:left or right
%%column6 �Ƿ���catch trial����Ϊ1 ����Ϊ0
%%column7 ��������
%%column8 �Ҳ������
%%column9 ����δָ�����壩
%%column10 catch trial�Ƿ񰴼�
%%column11 Ŀ���жϵķ�Ӧʱ
%%column12 isi duration between offset of cue and onset of target

numbercondition=1:9;%һ��9������
cuevalidity=[1 -1];%cue����Ч��
cuelocation=[1 -1];%cue��λ��
ISIdur=[150 600];%cue��target֮���ʱ����


trialpercondition=3;%ÿ������µ�trial��3��ÿһ���ռ�λ�ã�
numofcue=length(numbercondition);%����cue�ĸ���
catchtrials=48;%catchtrial��ֻ����cue��������Ŀ��̼������Բ���������Ӧ������Ϊ�˼��ٱ��Ե��ڴ�ЧӦ������
col=12;%��������һ��������
numcue=[2 7;2 8;2 9;...
        3 7;3 8;3 9;...
        4 7;4 8;4 9];%9�����ֶ�

%%%����ʵ��trial������������%%%%
[x0,x1,x2,x3]=ndgrid(numbercondition,cuevalidity,cuelocation,ISIdur);%���ɲ�����Ͼ���
combinedpara=[x0(:),x1(:),x2(:),x3(:)];%ʵ��trial���е��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%���ɸ���cue�µĲ�������%%%%%%%%%%%%%%%%
%%��catch trial
paramatrixtemp0=zeros(length(combinedpara(:,1)),col);
paramatrixtemp0(:,2)=combinedpara(:,1);%numbercondition
paramatrixtemp0(:,3)=combinedpara(:,2);%cuevalidity
paramatrixtemp0(:,4)=combinedpara(:,3);%cuelocation
paramatrixtemp0(:,12)=combinedpara(:,4);%ISIdur
paramatrixtemp0(:,6)=0;%�Ƿ���catch trial������catchtrialΪ��0
for i=1:length(combinedpara(:,1)) %�趨��С���ֵ���/��λ��
  num0=numcue(paramatrixtemp0(i,2),:);%���ֶ�
  if paramatrixtemp0(i,4)==-1;%�����������
      paramatrixtemp0(i,7)=num0(2);paramatrixtemp0(i,8)=num0(1);
    elseif paramatrixtemp0(i,4)==1%���������Ҳ�
      paramatrixtemp0(i,7)=num0(1);paramatrixtemp0(i,8)=num0(2);
  end
  paramatrixtemp0(i,5)=paramatrixtemp0(i,3)*paramatrixtemp0(i,4);%cue����Ч���Լ������ֵ�λ�þ�����target��λ��
end
paramatrix0=[];

for j=1:trialpercondition %�ظ�ƴ�����Ͼ���trialpercondition��
    paramatrix0=[paramatrix0;paramatrixtemp0];
end

paramatrix1=paramatrix0;%���Ƿ�catch trial�Ĳ�������
    

%%catch trial
paramatrix0=zeros(catchtrials,col);
for i=1:catchtrials
  num0=numcue(randsample([1 2 3 4 5 6 7 9],1),:);%Ϊÿ��catch trial���ѡ��һ�����ֶ�
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
paramatrix0(:,6)=1;%��catchtrial

paramatrix2=paramatrix0;%����catch trial�Ĳ�������


%%%%%%%%%%%%%%%%%%%%%%%%%%%�ϲ���catch trial�ͷ�catch trial�Ĳ������������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
paramatrix=[paramatrix1;paramatrix2];

paramatrix0=paramatrix;
[pointer,index]=Shuffle(paramatrix0(:,1));%%%���Ҵ̼��Ĵ���
for i=1:length(paramatrix0(:,1))
    paramatrix(i,:)=paramatrix0(index(i),:);
end

paramatrix(:,1)=[1:length(paramatrix(:,1))]';

clearvars -except paramatrix %��������ռ��е����б���������paramatrix