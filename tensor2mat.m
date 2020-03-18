function xm = tensor2mat(xt)
% This function matricizes a tensor (k * m * m * ...).
%               reduces redundant elements.
%   INPUT
%       xt - a tensor in R(k*m*m*m*...)
% 
%   OUTPUT
%       xm - a matrix in [k-by-n]
%
s = size(xt);
if ~all(s(2:end)==s(2))
    xm = [];
    disp('Error in x dimension input.');
else
    k = s(1);
    xdim = s(2);
    order = length(s)-1;
    comb = outerprod(xdim,order);
    n = length(comb.mult);
    xm = zeros(k,n);
    for i=1:n
        for j=1:k
            xm(j,i) = tensorCoord2val(xt,[j comb.listofComb(i,:)]);
        end
    end
end
