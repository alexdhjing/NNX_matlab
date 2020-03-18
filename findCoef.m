function [a0,A] = findCoef(net,activation_func,order)
% This function finds coefficients of polynomials
% 
%   INPUT
%       net              - NN model
%       activation_func  - activation function ('tansig', 'logsig')
%       order            - up to which order of approximation
% 
%   OUTPUT
%       a0  - constant 
%       A   - cell contains coef from 1 to order'th order

A = cell(1,order);
iw = iwgenerate(net.IW{1},order);

if isequal(activation_func,'tansig')
    a0 = net.b{2} + net.LW{2,1}*tansig(net.b{1});
    for i=1:order
        A{i} = 1/factorial(i) * net.LW{2,1} * diag(tansigDerivative(net.b{1},i)) * iw{i};
    end
elseif isequal(activation_func,'logsig')
    a0 = net.b{2} + net.LW{2,1}*logsig(net.b{1});
    for i=1:order
        A{i} = 1/factorial(i) * net.LW{2,1} * diag(logsigDerivative(net.b{1},i)) * iw{i};
    end
end



