%����WaitSecs���չʾ��ʱ�Ĳ�����
Times=zeros(1,200);
for i=1:200 
  Times(i)=GetSecs;
  WaitSecs(0.010);%�ȴ�10����
end

figure(1)
plot(Times);
xlabel('����')
ylabel('����ʱ�䣨�룩')
figure(2);
plot(diff(Times)*1000)
xlabel('����')
ylabel('ʱ���������룩')
