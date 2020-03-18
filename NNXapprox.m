function [y_approx,a0,A] = NNXapprox(input_data,train_data,n_neuron,activation_func,order)
%
%   INPUT
%       input_data      - [m-by-t] X1 to Xm in time t
%       train_data      - [n-by-t] Y1 to Yn in time t
%       n_neuron        - number of neurons in hidden layer
%       activation_func - activation function ('tansig' or 'logsig')
%       order           - degree that approximation reaches
%
%   OUTPUT
%       y_approx    - approximated output of neural network given input
%       a0          - constant (0th order) term in polynomial
%       A           - coefficients of polynomial
% 

if ~isequal(size(input_data,2),size(train_data,2))
    y_approx = [];
    A = []
    disp('Size of Input data should match size of Output data.')
else
    net = fitnet(n_neuron);
    net.layers{1}.transferFcn = activation_func;
    net.numLayers = 2;
    net.biasConnect = [1; 1];
    net.OutputConnect = [0 1];
    net.layerConnect = [0 0; 1 0];
    net.numInputs = 1;
    net.trainParam.goal = 0;
    net.trainParam.min_grad = 0;
    net.inputs{1}.processFcns = {};
    net.outputs{2}.processFcns = {};
%     net.trainFcn = 'trainlm';
%     net.trainFcn = 'trainbr';
% %     net.trainFcn = 'trainbfg';
% %     net.trainFcn = 'trainrp';
% %     net.trainFcn = 'trainscg';
%     net.trainFcn = 'traincgb';
% %     net.trainFcn = 'traincgf';
% %     net.trainFcn = 'traincgp';
% %     net.trainFcn = 'trainoss';
    
    
    
    net = train(net,input_data,train_data);
    
    net.IW{1}
    net.b{1}
    net.LW{2,1}
    net.b{2}
    
    iw = iwgenerate(net.IW{1},order);
    rcross = varCrossMat(input_data,order);
    [a0,A] = findCoef(net,activation_func,order);
    y = a0;
    for i=1:order
        y = A{i} * rcross{i} + y;
    end
    y_approx = y;
end
