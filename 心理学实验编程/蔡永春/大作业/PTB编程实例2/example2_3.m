 %在屏幕上显示按键的键值及键符，按Esc键退出循环
fprintf('Press any key(s). Press escape key to exit.\n');
while KbCheck; end % 等待没有按键被按下
escapekey = KbName('esc');%esc键对应的键值
while 1
  keyisdown = 0;
  while ~keyisdown
      [keyisdown, secs, keycode] = KbCheck;
     % WaitSecs(0.001); % delay to prevent CPU hogging
  end
  fprintf('Current key(s) down: %s which is %s\n',...
       char(int2str(find(keycode))),char(KbName(keycode))');%显示键值及按键符号
  if keycode(escapekey) %遇到esc键时则退出循环
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
