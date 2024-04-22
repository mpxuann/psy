%%20201014����Gabor��դ���󣬹�դ�Ը�˹�����ʱ�䴰����/��ʧ 
%By CaiYongchun
%  i_2sd_size��Gabor��դ��˹����sd��2������2sd������
%  i_Speriod����դ�Ŀռ����ڣ�����
%  i_speed����դ�ƶ��ٶȣ���λ pixels/��,��ֵΪ�������˶�����ֵ�෴
%  i_phase����դ����λ
%  i_contrast����դ�ĶԱȶ�
%  i_orientation����դ�ĳ���
%  i_ramptime; %�����դ�Ը�˹����ķ�ʽƽ�����ֺ���ʧ���˲�����ʾ��˹������sd,��λms
 
function output=driftGabormatrix(frame_rate,background,i_2sd_size,i_Speriod,i_speed,i_phase,i_contrast,i_orientation,i_ramptime)
   
i_rampwidth=(i_ramptime/(1000/frame_rate));
                             
frames=round(i_rampwidth.*8); %�̼����ִ�ȡ��˹�ֲ���+/-4sd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i_sd=i_2sd_size/2;%����Gabor��sd
i_size=6*i_sd;%�̼��Ĵ�С��6��sd����+/-3sd

[x,y]=meshgrid((1-i_size/2):(i_size/2),(1-i_size/2):(i_size/2));%����x,y����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %����Gabor��դ�ĸ�˹����%%%%%%%%
  r_c=round(i_size/2);%�����դ�뾶
  %bound1_i=exp(-(x.^2+y.^2)/(2*i_sd^2));
  GaussianBoundary=exp(-(x.^2+y.^2)/(2*(i_sd^2)));


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
    gratingmatrix(:,:,jj)=background*(1+i_timewindow(jj)*con_c*cos(aa_c*x+bb_c*y+i_phase-i_speed*jj/frame_rate).*GaussianBoundary);    %��դ�ڲ�ͬ֡�Ĵ̼�����                                
end

output=gratingmatrix;


