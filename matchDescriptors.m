% match descriptors
%
% Input:
%   descr1        - k x n descriptor of first image
%   descr2        - k x m descriptor of second image
%   thresh        - scalar value to threshold the matches
%   
% Output:
%   matches       - w x 2 matrix storing the indices of the matching
%                   descriptors

function matches = matchDescriptors(descr1, descr2, thresh)

match = [];
for i = 1:size(descr1, 1)
    ssd = [];
    
    for j = 1:size(descr2, 1)
        ssd_list = horzcat(ssd, sum((descr1(i,:) - descr2(j,:)).^2));   % Compute SSD
        ssd = ssd_list;
    end
    
    ssd2 = sort(ssd_list);
    
    % Ratio Test:
    % Compute (score of the best feature match)/(score of the second best feature match)
    ratio = ssd2(1) / ssd2(2);
    
    if ratio < thresh
        matches = vertcat(match, [i, find(ssd_list == ssd2(1))]);
        match = matches;
    end
end
        

end