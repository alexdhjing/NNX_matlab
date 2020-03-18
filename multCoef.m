function new_coef = multCoef(xdim,order1,coef1,order2,coef2)
% This function calculates coefficients multiplication.
% coefs are in flattened form A x(cross)n
% 
%   INPUT
%       xdim    - dimension of x 
%       order1  - the order of x coef1 takes responsible to
%       coef1   - coefficient 1
%       order2  - the order of x coef2 takes responsible to
%       coef2   - coefficient 2
%
%   OUTPUT 
%       new_coef    - new combined coefficient,
%                     to the order of (order1+order) wrt x
% 

op1 = outerprod(xdim,order1);
op2 = outerprod(xdim,order2);
if size(coef1,1)~=size(coef2,1)
    error('coef1 and coef2 dimension 2 not match.')
    return
else
    zdim = size(coef1,1);
end
if length(op1.mult)~=size(coef1,2)
    error('coef1 dimension 2 is incorrect.')
    return
end
if length(op2.mult)~=size(coef2,2)
    error('coef2 dimension 2 is incorrect.')
    return
end

if order1==0 || order2==0
    new_coef = coef1 .* coef2;
    return
end

new_order = order1 + order2;
new_op = outerprod(xdim,new_order);
new_dim = length(new_op.mult);

new_coef = zeros(zdim,new_dim);

for i = 1:new_dim
    pool = new_op.listofComb(i,:);
    pair = [];
    for m = 1:size(coef1,2)
        buffer = pool;
        [in1, index1] = isinlist(op1.listofComb(m,:),buffer);
        if in1
            buffer(index1) = [];
            for n=1:size(coef2,2)
                [in2, index2] = isinlist(op2.listofComb(n,:),buffer);
                if in2
                    pair = [pair; m n];
                    break
                end
            end
        end
    end
    for j=1:size(pair,1)
        new_coef(:,i) = new_coef(:,i) + ...
            coef1(:,pair(j,1))/op1.mult(pair(j,1)) .* ... 
            coef2(:,pair(j,2))/op2.mult(pair(j,2)) * new_op.mult(i);
    end
end