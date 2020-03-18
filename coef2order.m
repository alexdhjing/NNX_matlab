function new_coef = coef2order(coef,order)
z1dim = size(coef,1);
op = outerprod(z1dim,order);
z2dim = length(op.mult);
new_coef = zeros(z2dim,size(coef,2));
for i=1:z2dim
    new_coef(i,:) = prod(coef(op.listofComb(i,:),:),1) * op.mult(i);
end
end