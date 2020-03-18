function de = tansigDerivative(x,n)
% This function finds derivatives of tansig function to nth order
%   
%   INPUT
%       x - value (tansig(x))
%       n - order
% 
%   OUTPUT
%       de - derivative
% 
b = [0 1];
for o=1:n
    for i=2:length(b)
        b(i-1) = (i-1)*b(i);
    end
    b1 = [b(1:end-1) 0 0];
    b2 = [0 0 -b(1:end-1)];
    b = b1 + b2;
end

de = zeros(size(x));

for i=1:length(b)
    de = de + b(i) * tansig(x).^(i-1);
end

