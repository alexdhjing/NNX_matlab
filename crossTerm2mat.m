function crossmat = crossTerm2mat(crossTerm)
% This function makes a cross term into a matrix
% 
%   INPUT
%       crossTerm
% 
%   OUTPUT
%       crossmat
% 
[~,order] = size(crossTerm);

crossmat = [];
for i=1:order
    crossmat = [crossmat; crossTerm{i}];
end