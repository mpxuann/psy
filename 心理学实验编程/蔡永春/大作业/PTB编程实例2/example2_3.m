 %����Ļ����ʾ�����ļ�ֵ����������Esc���˳�ѭ��
fprintf('Press any key(s). Press escape key to exit.\n');
while KbCheck; end % �ȴ�û�а���������
escapekey = KbName('esc');%esc����Ӧ�ļ�ֵ
while 1
  keyisdown = 0;
  while ~keyisdown
      [keyisdown, secs, keycode] = KbCheck;
     % WaitSecs(0.001); % delay to prevent CPU hogging
  end
  fprintf('Current key(s) down: %s which is %s\n',...
       char(int2str(find(keycode))),char(KbName(keycode))');%��ʾ��ֵ����������
  if keycode(escapekey) %����esc��ʱ���˳�ѭ��
     break;
  end
  %while KbCheck; end % wait until all keys are released
  KbWait([],1);
end
fprintf('Thank you for participation. Press any key(s) to exit.\n');
KbWait([],2);
%while KbCheck; end
%keyisdown = 0;
% while ~keyisdown
%     [keyisdown, secs, keycode] = KbCheck;
% end
fprintf('exit succeed.\n');
