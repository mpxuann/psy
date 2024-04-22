%%20201014��������ģ���߹�դ����դ�Ը�˹�����ʱ�䴰����/��ʧ 
%By CaiYongchun
%  i_size����դ��ֱ��������
%  i_Speriod����դ�Ŀռ����ڣ�����
%  i_speed����դ�ƶ��ٶȣ���λ pixels/��,��ֵΪ�������˶�����ֵ�෴
%  i_phase����դ����λ
%  i_contrast����դ�ĶԱȶ�
%  i_orientation����դ�ĳ���
%  i_ramptime; %�����դ�Ը�˹����ķ�ʽƽ�����ֺ���ʧ���˲�����ʾ��˹������sd,��λms
 
function output=driftSinBlurGratingmatrix(frame_rate,background,i_size,i_Speriod,i_speed,i_phase,i_contrast,i_orientation,i_ramptime)
   
i_rampwidth=(i_ramptime/(1000/frame_rate));
                             
frames=round(i_rampwidth.*8); %�̼����ִ�ȡ��˹�ֲ���+/-4sd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x,y]=meshgrid((1-i_size/2):(i_size/2),(1-i_size/2):(i_size/2));%����x,y����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %�����դ������ģ����Ե%%%%%%%%
   r_c=round(i_size/2);%��դ�뾶
   blur_size=0.33*i_size;%ģ���ߵĿ����1/3�̼�ֱ��
   rampperiod=2*blur_size;%�����դ����ramp������
   bound1_i_1=(sin(2*pi*(1/rampperiod)*(sqrt(x.^2+y.^2)-r_c)-pi/2)+1)/2;%����Բ�̵����ҵݼ���
   bound1_i_2=sign(sign((r_c).^2-x.^2-y.^2)+1);
   bound1_i_3=sign(sign(-(r_c-rampperiod/2).^2+x.^2+y.^2)+1);
   bound1_i_4=sign(sign((r_c-rampperiod/2).^2-x.^2-y.^2)+1);
   bound1_i=bound1_i_1.*bound1_i_2.*bound1_i_3+bound1_i_4;
   bound1_i=min(bound1_i,1);
   
   bound3=sign(sign((r_c).^2-x.^2-y.^2)+1);%�����դ��Բ�α�
   SinBoundary=bound3.*bound1_i;%����Բ�����������rampģ��
  %%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Gaussian  time window
TimePoints=1:frames; %frame ��
CenterPoint=round((1+frames)/2); %ʱ�䴰�����ĵ�
i_timewindow=exp(-((TimePoints-CenterPoint).^2)/(2*(i_rampwidth^2)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%���� �ռ�Ƶ�ʵ�%%%%%%%%%%%%%%%
    angle_c=i_orientation;%��դ����, ��λ ��
    ang_c=angle_c*pi/180;%ת�� �� Ϊ ����
    fre_c=1/i_Speriod;

    aa_c=2*pi*fre_c*cos(ang_c);
    bb_c=2*pi*fre_c*sin(ang_c);
    
    con_c=i_contrast;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
for jj=1:frames
    gratingmatrix(:,:,jj)=background*(1+i_timewindow(jj)*con_c*cos(aa_c*x+bb_c*y+i_phase-i_speed*jj/frame_rate).*SinBoundary);    %��դ�ڲ�ͬ֡�Ĵ̼�����                                
end

output=gratingmatrix;


