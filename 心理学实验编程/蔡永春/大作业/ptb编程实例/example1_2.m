%%example2-2 ��һ��Բ
%By Cai Yongchun, 2020/10/7
WindowNumber=0;
WinColor=[100 100 100];
[WindowPtr,Rect]=Screen('OpenWindow',WindowNumber,WinColor);
Screen('FillRect', WindowPtr,[0,255,0],[100,100,200,200]);%������ţ���ɫ��λ������
Screen('FrameOval',WindowPtr,[0,0,255],[300 200 500 700],5);%������ţ���ɫ��λ�����꣬���ʴ�ϸ
Screen('flip',WindowPtr);%���֣���Ļ���
WaitSecs(2);%�ȴ�5��
Screen('CloseAll');%�ر����д���