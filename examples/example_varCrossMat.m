clear
clc
load('example_data/spring_data.mat');
%% inputs of function
X = x';
order = 3;
%% outputs of function
crossTerm = varCrossMat(X,order)
% for i=1:length(crossTerm)
%     fprintf('X%d = \n',i)
%     disp(crossTerm{i})
% end