function A = layerCoef(w,b,activation_func,order)
% This function finds coefficients of polynomials for one layer
% 
%   INPUT
%       w                - weight of the layer
%       b                - bias of the layer
%       activation_func  - activation function ('tansig', 'logsig')
%       order            - up to which order of approximation
% 
%   OUTPUT
%       coef   - cell contains coef from 0 to order'th order

A = cell(order+1,2);
iw = iwgenerate(w,order);

if isequal(activation_func,'tansig')
    A{1,2} = tansig(b);
    A{1,1} = 0;
    for i=1:order
        A{i+1,2} = 1/factorial(i) * diag(tansigDerivative(b,i)) * iw{i};
        A{i+1,1} = i;
    end
elseif isequal(activation_func,'logsig')
    A{1,2} = logsig(b);
    A{1,1} = 0;
    for i=1:order
        A{i+1,2} = 1/factorial(i) * diag(logsigDerivative(b,i)) * iw{i};
        A{i+1,1} = i;
    end
else
    error('activation function should be tansig or logsig')
end

end