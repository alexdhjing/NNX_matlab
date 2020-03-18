function comb = outerprod(xdim,order)
% This function is meant to find all unique combination of outer product of 
% [x_1, ... , x_m]T in nth order
%
% 
% INPUT
%       xdim  - dimension of x [x_1, ... , x_m]
%       order - nth order; has to be positive integer
%
% OUTPUT
%       comb            - struct with two elements
%       comb.mult       - multiplicity of a certain combination
%       comb.listofComb - combinations
%
  if floor(order)~=order || order<0
      error('Order has to be a non-negative integer')
      comb.mult = [];
      comb.listofComb = [];
      return
  elseif order==0
      comb.mult = 1;
      comb.listofComb = 0;
  elseif order==1
      comb.mult = ones(1,xdim);
      comb.listofComb = [1:xdim]';
  else
      x = [1:xdim];
      xvec = [1:xdim];
      for i = [1:order-1]
          x = combvec(x,xvec);
      end
      x = sort(x)';
      listofComb = zeros(2,length(x(1,:))); 
      mult = [];
      for i = [1:length(x(:,1))]
          [isrow,rowat] = ismember(x(i,:),listofComb,'rows');
          if isrow
              mult(rowat-2) = mult(rowat-2)+1;
          else
              mult = [mult,1];
              listofComb = [listofComb;x(i,:)];
          end
      end
      comb.mult = mult;
      comb.listofComb = listofComb(3:end,:);
  end
  