% extract descriptor
%
% Input:
%   keyPoints     - detected keypoints in a k x 2 matrix holding the key
%                   point coordinates
%   img           - the gray scale image
%   
% Output:
%   descr         - k x m^2 matrix, stores for each keypoint a
%                   descriptor. m is the size of the image patch,
%                   represented as vector

% Simple feature descriptor
% 9*9 square window without orientation

function dscr = extractDescriptor(corners, img)
    m = 9;   % m: image patch
    numOfcorners = size(corners, 1);
    dscr = zeros(numOfcorners, m^2);
    
    for a = 1:numOfcorners
        cood = corners(a, :);   % coordinate of a point
%         x = cood(1);
%         y = cood(2);
        
        i = 1;
        for x = (cood(1)-(m-1)/2):(cood(1)+(m-1)/2)
            for y = (cood(2)-(m-1)/2):(cood(2)+(m-1)/2)
                dscr(a, i) = img(x, y);
                i = i+1;
            end
        end
    end
end