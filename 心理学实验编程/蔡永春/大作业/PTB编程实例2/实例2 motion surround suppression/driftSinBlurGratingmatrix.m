%%20201014生成余弦模糊边光栅，光栅以高斯包络的时间窗出现/消失 
%By CaiYongchun
%  i_size，光栅的直径，像素
%  i_Speriod，光栅的空间周期，像素
%  i_speed，光栅移动速度，单位 pixels/秒,正值为从左到右运动，负值相反
%  i_phase，光栅的相位
%  i_contrast，光栅的对比度
%  i_orientation，光栅的朝向
%  i_ramptime; %中央光栅以高斯包络的方式平缓出现和消失，此参数表示高斯函数的sd,单位ms
 
function output=driftSinBlurGratingmatrix(frame_rate,background,i_size,i_Speriod,i_speed,i_phase,i_contrast,i_orientation,i_ramptime)
   
i_rampwidth=(i_ramptime/(1000/frame_rate));
                             
frames=round(i_rampwidth.*8); %刺激呈现窗取高斯分布的+/-4sd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x,y]=meshgrid((1-i_size/2):(i_size/2),(1-i_size/2):(i_size/2));%生产x,y网格
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %中央光栅的正弦模糊边缘%%%%%%%%
   r_c=round(i_size/2);%光栅半径
   blur_size=0.33*i_size;%模糊边的宽度是1/3刺激直径
   rampperiod=2*blur_size;%中央光栅正弦ramp的周期
   bound1_i_1=(sin(2*pi*(1/rampperiod)*(sqrt(x.^2+y.^2)-r_c)-pi/2)+1)/2;%中央圆盘的余弦递减边
   bound1_i_2=sign(sign((r_c).^2-x.^2-y.^2)+1);
   bound1_i_3=sign(sign(-(r_c-rampperiod/2).^2+x.^2+y.^2)+1);
   bound1_i_4=sign(sign((r_c-rampperiod/2).^2-x.^2-y.^2)+1);
   bound1_i=bound1_i_1.*bound1_i_2.*bound1_i_3+bound1_i_4;
   bound1_i=min(bound1_i,1);
   
   bound3=sign(sign((r_c).^2-x.^2-y.^2)+1);%中央光栅的圆形边
   SinBoundary=bound3.*bound1_i;%中央圆形区域，外边有ramp模糊
  %%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Gaussian  time window
TimePoints=1:frames; %frame 点
CenterPoint=round((1+frames)/2); %时间窗的中心点
i_timewindow=exp(-((TimePoints-CenterPoint).^2)/(2*(i_rampwidth^2)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%朝向 空间频率等%%%%%%%%%%%%%%%
    angle_c=i_orientation;%光栅朝向, 单位 度
    ang_c=angle_c*pi/180;%转换 度 为 弧度
    fre_c=1/i_Speriod;

    aa_c=2*pi*fre_c*cos(ang_c);
    bb_c=2*pi*fre_c*sin(ang_c);
    
    con_c=i_contrast;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
for jj=1:frames
    gratingmatrix(:,:,jj)=background*(1+i_timewindow(jj)*con_c*cos(aa_c*x+bb_c*y+i_phase-i_speed*jj/frame_rate).*SinBoundary);    %光栅在不同帧的刺激矩阵                                
end

output=gratingmatrix;


