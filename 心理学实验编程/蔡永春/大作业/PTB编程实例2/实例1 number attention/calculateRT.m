
RTisi150(1,1)=median(paramatrix(find(paramatrix(:,3)==1&paramatrix(:,6)==0&paramatrix(:,10)==0&paramatrix(:,12)==150),11)) %目标被大数字提示条件的反应时
RTisi150(1,2)=median(paramatrix(find(paramatrix(:,3)==-1&paramatrix(:,6)==0&paramatrix(:,10)==0&paramatrix(:,12)==150),11)) %目标被小数字提示条件的反应时

RTisi600(1,1)=median(paramatrix(find(paramatrix(:,3)==1&paramatrix(:,6)==0&paramatrix(:,10)==0&paramatrix(:,12)==600),11)) %目标被大数字提示条件的反应时
RTisi600(1,2)=median(paramatrix(find(paramatrix(:,3)==-1&paramatrix(:,6)==0&paramatrix(:,10)==0&paramatrix(:,12)==600),11)) %目标被小数字提示条件的反应时