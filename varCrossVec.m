function crossTerm = varCrossVec(varargin)
% This function returns cross terms of m dimensional given order n.
% 
%   INPUT
%       X     - to dimension m
%               length of X's should be same
%               each x input as a vector
%       order - cross term to the order
% 
%   OUTPUT
%       cells of X^order
% 

xdim = nargin - 1;
order = varargin{nargin};

if order~=floor(order) % check if positive integer
    crossTerm = [];
    disp('Order should be a positive integer.')
elseif order==1
    crossTerm{1,1} = [];
    for m = 1:xdim
        crossTerm{1,1} = [crossTerm{1,1}; reshape(varargin{m},1,[])];
    end
else
    crossTerm = cell(1,order);
    crossTerm{1,1} = [];
    for m = 1:xdim
        crossTerm{1,1} = [crossTerm{1,1}; reshape(varargin{m},1,[])];
    end
    for o = 2:order
        comb = outerprod(xdim,o);
        ncross = length(comb.mult);
        nx = length(varargin{1});
        crossTerm{1,o} = ones(ncross,nx);
        for m = 1:ncross
            for t = 1:o
                crossTerm{1,o}(m,:) = crossTerm{1,o}(m,:) .* reshape(varargin{comb.listofComb(m,t)},1,[]);
            end
            crossTerm{1,o}(m,:) = crossTerm{1,o}(m,:) * comb.mult(m);
        end
    end
end

end
