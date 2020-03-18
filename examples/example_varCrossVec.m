clear
clc
load('example_data/spring_data.mat');
%% inputs of function
p = x(:,1)';
v = x(:,2)';
order = 3;
%% outputs of function
crossTerm = varCrossVec(p,v,order)
% for i=1:length(crossTerm)
%     fprintf('X%d = \n',i)
%     disp(crossTerm{i})
% end