clear
clc
load('example_data/spring_net.mat');
%% inputs of function
net;
activation_func = 'tansig';
order = 3;
%% results
[a0,A] = findCoef(net,activation_func,order);
a0
for i=1:length(A)
    fprintf('A%d = \n',i)
    disp(A{i})
end