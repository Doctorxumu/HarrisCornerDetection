% extract harris corner
%
% Input:
%   img           - n x m gray scale image
%   thresh        - scalar value to threshold corner strength
%   
% Output:
%   corners       - k x 2 matrix storing the keypoint coordinates
%   H             - n x m gray scale image storing the corner strength

function [corners, im] = extractHarrisCorner(img, thresh)
    dx = [-1 0 1; -1 0 1; -1 0 1]; % Derivative masks
    dy = dx';

    Ix = conv2(img, dx, 'same');    % Image derivatives
    Iy = conv2(img, dy, 'same'); 
    
    Ix2 = Ix .^ 2;  % Products of derivatives at every pixel
    Iy2 = Iy .^ 2;
    Ixy = Ix .* Iy;
    
    Sx2 = conv2(Ix2, ones(3), 'same');  %The sums of the products of derivatives at each pixel (3 * 3 neighbourhood)
    Sy2 = conv2(Iy2, ones(3), 'same');
    Sxy = conv2(Ixy, ones(3), 'same');
    
    numOfRows = size(img, 1);
    numOfColumns = size(img, 2);

%     im = zeros(numOfRows, numOfColumns);
    
    for x=1:numOfRows
        for y=1:numOfColumns
            H = [Sx2(x, y) Sxy(x, y); Sxy(x, y) Sy2(x, y)]; % Define the matrix Harris at each pixel
            K = det(H)/trace(H);    % The Harris response measure
            im(x, y) = K;
        end
    end
%     output = im > imdilate(im, [1 1 1; 1 0 1; 1 1 1]);
    
    radius = 3;                                 % Size of mask.
 	mx = ordfilt2(im, radius^2, ones(radius));  % Grey-scale dilate.
 	corner = (im == mx) & (im > thresh);        % Find maxima (with non-maximum suppresion).
%   corner = im > thresh;                       % without non-maximum suppresion
 	
 	[r,c] = find(corner);                            % Find row,column coords.
    corners = [r, c];
    corners(find(corners(:,1)<5),:) = [];   % Remove corners which are on edge of images.
    corners(find(corners(:,2)<5),:) = [];
    corners(end-3:end,:) = [];  % Removed a few indices that have something wrong
end
