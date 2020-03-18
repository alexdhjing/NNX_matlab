clear
clc
load('example_data/spring_data.mat');
%% inputs of function
% training data
input_data = x';
train_data = y';
% parameters of neural net
n_neuron = 3; % for best performance, match dimension of input_data
activation_func = 'logsig'; % can be either 'tansig' or 'logsig'
order = 2; % choose a number best reproduce neural net model
%% results
[y_approx,a0,A] = NNXapprox(input_data,train_data,n_neuron,activation_func,order);
a0
for i=1:length(A)
    fprintf('A%d = \n',i)
    disp(A{i})
    
end
%% results plot
t = 1:size(y,1);
figure
subplot(2,1,1)
plot(t,y(:,1)',t,y_approx(1,:))
legend('train data','y approx')
title('position / output(1)')
subplot(2,1,2)
plot(t,y(:,2)',t,y_approx(2,:))
legend('train data','y approx')
title('velocity / output(2)')