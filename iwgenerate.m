function iw = iwgenerate(IW,order)
% This function finds matricized tensor of net.IW to the order'th order.
% Doing this is to find coef of polynomials.
%
%   INPUT
%       IW      - input weight of a NN
%       order   - approximation to which order
% 
%   OUTPUT
%       iw  - cells contain matricized IW up to order'th order
% 

if mod(order,1)~=0 || order==0
    error('order should be positive integer')
    iw = {};
    return
elseif order==1
    iw = cell(1,order);
    iw{1} = IW;
else
    k = size(IW,1);
    iw = cell(1,order);
    iw{1} = IW;
    for i=2:order
        comb = outerprod(size(IW,2),i);
        li = comb.listofComb;
        n = length(comb.mult);
        w = zeros(k,n);
        for p=1:k
            for q=1:n
                w(p,q) = prod(IW(p,li(q,:)));
            end
        end
        iw{i} = w;
    end
end
            
    