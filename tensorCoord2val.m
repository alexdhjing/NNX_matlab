function val = tensorCoord2val(tensor,coord)
% This function returns an element in a tensor given coordinate.
% 
%   INPUT
%       tensor  - tensor of order n [n,m,p,...]
%       coord   - coordinate of element inn tensor
% 
%   OUTPUT
%       val     - value of the element
%
%% check if dim match
order = size(tensor);
if length(order)~=length(coord)
    disp('Dimensionn of tensor and coordinates not match.')
else
    ov = find(coord>order);
    if length(ov)>0
        fprintf('N0. %i Coordinate(s) exceed(s) dimension.\n',ov)
    end
end
%% find val
num = 0;
for ax = length(order):-1:1
    num = num + (prod(order(1:ax-1)) * (coord(ax)-1));
end
val = tensor(num+1);