% show feature matches between two images
%
% Input:
%   img1        - n x m color image 
%   corner1     - k x 2 matrix, holding keypoint coordinates of first image
%   img2        - n x m color image 
%   corner1     - k x 2 matrix, holding keypoint coordinates of second image
%   fig         - figure id
function showFeatureMatches(img1, corner1, img2, corner2, fig)
    [sx, sy, sz] = size(img1);
    img = [img1, img2];
    
    corner2 = corner2 + repmat([sy, 0], [size(corner2, 1), 1]);
    
    figure(fig), imshow(img, []);    
    hold on, plot(corner1(:,1), corner1(:,2), '+r');
    hold on, plot(corner2(:,1), corner2(:,2), '+r');    
    hold on, plot([corner1(:,1), corner2(:,1)]', [corner1(:,2), corner2(:,2)]', 'b');    
end