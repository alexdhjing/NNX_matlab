%% let's work with a toy case, a linear underdamped spring, 1 DOF
clear
clc
close all

order = 3;

% find the optimal number of neurons for NN
nh = [2 2]; % best for linear relationship between input and output
ni = 2; % number of inputs
no = 2; % number of outputs
nl = length(nh)+1; % number of layers
acti_fun = 'logsig'; % activation function
bcon = ones(nl,1);
ocon = zeros(1,nl); ocon(end) = 1;
lcon = zeros(nl);
    for i=1:nl-1
        lcon(i+1,i) = 1;
    end

%%
% first define the system of interest and the inputs, outputs of interest
p.m = 1;
p.k = 10;
p.c = 0.1;

options = odeset('RelTol', 1e-12,'AbsTol', 1e-12);
dt=.01; tfinal=10;
x_0 = 1; v_0 = 1;
z_0 = [x_0;v_0];


net = fitnet(nh);
net.layers{1}.transferFcn = acti_fun;
% net.layers{1}.transferFcn = 'purelin';
net.numLayers = nl;
net.biasConnect = bcon;
net.OutputConnect = ocon;
net.layerConnect = lcon;
net.numInputs = 1;
net.trainParam.goal = 0;
net.trainParam.min_grad = 0;
net.inputs{1}.processFcns = {};
net.outputs{2}.processFcns = {};


[t,var]=ode45(@spring,0:dt:tfinal,z_0,options,p);
r = var(:,1);
v = var(:,2);

traincross = varCrossVec(r(1:end-1)',v(1:end-1)',order);

X = [r(1:end-1) v(1:end-1)]';
Y = [r(2:end) v(2:end)]';

% train the NN
net = train(net,X,Y);
%% extract coef of each layer
W_l = {};
B_l= net.b;
A_l = {};
for i=1:nl
    if i==1
        W_l{i} = net.IW{1};
    else
        W_l{i} = net.LW{i,i-1};
    end
    A_l{i} = layerCoef(W_l{i},B_l{i},acti_fun,order);
end

%% find coef w.r.t. x
xdim = size(W_l{1},2);
A = cell(1,nl-1);
for i=1:nl-1
    if i==1
        A{i} = A_l{i};
    else
        head_coef = A{i-1};
        coef_temp = {};
        coef = {0 A_l{i}{1,2}};
        order_list = [0];
        for o=1:order
            coef_temp = taylor2order(xdim,A_l{i}{o+1,2},head_coef,o);
            for j=1:size(coef_temp,1)
                if coef_temp{j,1}>order
                    continue
                end
                if ismember(coef_temp{j,1},order_list)
                    idx = find(order_list==coef_temp{j,1});
                    coef{idx,2} = coef{idx,2} + coef_temp{j,2};
                else
                    order_list = [order_list, coef_temp{j,1}];
                    coef{size(coef,1)+1,1} = coef_temp{j,1};
                    coef{size(coef,1),2} = coef_temp{j,2};
                end
            end
        end
        A{i} = coef;
    end
end

coef_A = A{end};
for i=1:size(A{end},1)
    if i==1
        coef_A{i,2} = W_l{end} * coef_A{i,2} + B_l{end};
    else
        coef_A{i,2} = W_l{end} * coef_A{i,2};
    end
end

%%
coef_A
coef_A{1,2}
coef_A{2,2}
coef_A{3,2}
coef_A{4,2}

y_NNraw = net(X);
mse_NNraw = perform(net,y_NNraw,Y)
%%
for i=1:order+1
    A{i} = coef_A{i,2};
    if i==1
        y_NNW = A{i} * ones(1,size(Y,2));       % output from net if you took 0th term of Taylor
    else
        y_NNW = A{i}*traincross{i-1} + y_NNW;
    end
end
err_NNW{i} = Y'-y_NNW';
MSE = sum(err_NNW{i}.^2) / length(err_NNW)
