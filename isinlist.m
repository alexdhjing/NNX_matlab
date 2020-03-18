function [in, indx] = isinlist(a,b)
in = true;
indx = [];
buffer = b;
for i=1:length(a)
    idx = find(buffer==a(i));
    if length(idx)==0
        in = false;
        indx = [];
        return
    else
        buffer(idx(1)) = 0;
        indx = [indx, idx(1)];
    end
end
end
        