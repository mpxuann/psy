%%
clc;clear;close all;
%%
syms x;
k = 1;
%%
for i = 1: 10
    k = k + i;
end
f = x * innerfun(k);
%%
fplot(f)
%%
function [a] = innerfun(i)
    a = i + 3;
end
