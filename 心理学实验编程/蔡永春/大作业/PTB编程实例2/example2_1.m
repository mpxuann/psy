%����GetSecs���չʾ��ʱ�Ĳ�����
Times=zeros(1,10000);
for i=1:10000 
  Times(i)=GetSecs; 
end

figure(1)
plot(Times);
xlabel('����')
ylabel('����ʱ�䣨�룩')

figure(2);
plot(diff(Times)*1000)
xlabel('����')
ylabel('ʱ���������룩')
