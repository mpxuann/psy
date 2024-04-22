function [a] = grade(b)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
if b =='A'
    a = 'Excellent';
elseif b =='B'||b == 'C'
    a = 'Well done';
elseif b == 'D'
    a = 'You Passed';
elseif b == 'F'
    a = 'Better try again';
else
    a = 'Invalid grade';
end
end