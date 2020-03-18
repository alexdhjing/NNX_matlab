function tail_list = taylor2order(xdim,coef,head_list,order)
% assume
% z1 = A0 + A1*x^1 + A2*x^2 + A3*x^3 + ...
% z2 = B0 + B1*z1^1 + B2*z1^2 + B3*z1^3 + ...
% This function calculates overall coef of one order wrt x(cross)n and z2
% for example, coefs of x(cross)n of term B2*z1^2 into a list,
% which contains,
% {x orders, coefs}
%  0 B2*multCoef(A0,A0)
%  1 2*B2*multCoef(A0,A1)
%  2 2*B2*multCoef(A0,A2)
%  ......
% 
%   INPUT
%       xdim        - dimension of x
%       coef        - coefficient of this term (B2 in the example)
%       head_list   - list of previous layer {x orders, coefs}
%       cross_order - cross term to which order
%       coef_order  - coef order
% 
%   OUTPUT
%       tail_list   - list of current term {x orders, coefs}

num_ele = size(head_list,1);
op = outerprod(num_ele,order);
new_num = length(op.mult);
tail_list = cell(new_num,2);
for i=1:new_num
    tail_list{i,1} = head_list{op.listofComb(i,1),1};
    tail_list{i,2} = head_list{op.listofComb(i,1),2};
    if size(op.listofComb,2)<2
        tail_list{i,2} = coef * coef2order(tail_list{i,2},order);
    else
        for j=2:size(op.listofComb,2)
            tail_list{i,2} = multCoef(xdim,...
                                      tail_list{i,1},...
                                      tail_list{i,2},...
                                      head_list{op.listofComb(i,j),1},...
                                      head_list{op.listofComb(i,j),2});
            tail_list{i,1} = tail_list{i,1} + head_list{op.listofComb(i,j),1};
        end
        tail_list{i,2} = coef * coef2order(tail_list{i,2},order);
    end
end
end
