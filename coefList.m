function clist = coefList(order,nl)
% clist             - { order   {comb of coef} }
% {comb of coef}    - { multiplicity    {[comb_i](n-by-3)} }
% [comb_i]          - [ layer_m  coef_n to-cross-order ]
% 

if nl<=0
    error('nl number of layer has to be a positive interger');
elseif floor(nl)~=nl
    error('nl number of layer has to be an interger');
elseif nl==1
    fprintf("y = wx+b, it's linear relation.")
    clist = [];
    return
end

clist = cell(order+1,2);
ctemp = clist;

for i=1:order+1
    ctemp{i,1} = i-1;
    ctemp{i,2} = {1,[1,i-1,1]};
end

clist = ctemp;
end