clear
clc
load('example_data/spring_net.mat');
%% inputs of function
IW = net.IW{1};
order = 3;
%% results
iw = iwgenerate(IW,order);
for i=1:length(iw)
    fprintf('iw%d = \n',i)
    disp(iw{i})
end