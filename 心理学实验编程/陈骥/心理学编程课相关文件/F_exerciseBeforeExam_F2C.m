function [C] = F_exerciseBeforeExam_F2C(F)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
if isempty(F)
    return;
end
C = (F-32)*5/9;
fprintf('%.2f',C);
end