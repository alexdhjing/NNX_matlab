%% sample data ramdomly into three parts
function data = sampledata(x,ratio,p)
% returns randomly segmented data
% up to 7 segments
%
% x - data
%   each row as datapoint
%   e.g.  name   gender   age
%         john   M        23
%         kate   F        22
%
% ratio - ratio of data
%   e.g. 10000 data points
%        taking ratio * 10000 points to segment
%
% p - percentage
%   It takes up to 7 elements; adds up to 1
%   e.g.  p = [0.7 0.2 0.1]
len = length(x(:,1));
n = randperm(len,round(ratio*len,0));
x = x(n,:);
stru = struct();
for i = 1:length(p)
    len = length(x(:,1));
    r = randperm(len,round(len*p(i)/sum(p(i:end)),0));
    switch i
        case 1
            x1 = x(r,:);
            x(r,:) = [];
            stru.seg1 = x1;
        case 2
            x2 = x(r,:);
            x(r,:) = [];
            stru.seg2 = x2;
        case 3
            x3 = x(r,:);
            x(r,:) = [];
            stru.seg3 = x3;
        case 4
            x4 = x(r,:);
            stru.seg4 = x4;
        case 5
            x5 = x(r,:);
            x(r,:) = [];
            stru.seg5 = x5;
        case 6
            x6 = x(r,:);
            x(r,:) = [];
            stru.seg6 = x6;
        case 7
            x7 = x;
            stru.seg7 = x7;
    end
end

data = stru