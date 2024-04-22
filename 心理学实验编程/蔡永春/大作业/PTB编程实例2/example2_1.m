%测试GetSecs命令，展示计时的波动性
Times=zeros(1,10000);
for i=1:10000 
  Times(i)=GetSecs; 
end

figure(1)
plot(Times);
xlabel('次数')
ylabel('机器时间（秒）')

figure(2);
plot(diff(Times)*1000)
xlabel('次数')
ylabel('时间间隔（毫秒）')
