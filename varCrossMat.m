function crossTerm = varCrossMat(X,order)
% This function returns cross terms of m dimensional given order n.
% 
%   INPUT
%       X     - to dimension m
%               represent in a matrix form
%               [m-by-n]
%       order - cross term to the order
% 
%   OUTPUT
%       cells of X^order
% 

[xdim,nx] = size(X);

if order~=floor(order) % check if positive integer
    crossTerm = [];
    disp('Order should be a positive integer.')
elseif order==1
    crossTerm{1,1} = [];
    for m = 1:xdim
        crossTerm{1,1} = [crossTerm{1,1}; X(m,:)];
    end
else
    crossTerm = cell(1,order);
    crossTerm{1,1} = [];
    for m = 1:xdim
        crossTerm{1,1} = [crossTerm{1,1}; X(m,:)];
    end
    for o = 2:order
        comb = outerprod(xdim,o);
        ncross = length(comb.mult);
        crossTerm{1,o} = ones(ncross,nx);
        for m = 1:ncross
            for t = 1:o
                crossTerm{1,o}(m,:) = crossTerm{1,o}(m,:) .* X(comb.listofComb(m,t),:);
            end
            crossTerm{1,o}(m,:) = crossTerm{1,o}(m,:) * comb.mult(m);
        end
    end
end

end
