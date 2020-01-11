

im1         = imread('circles.png');
im1         = imnoise( im2double(im1), 'salt & pepper', 0.02 );
im1         = im1 > 0.5;

se          = strel('disk', 2);       
im2         = imopen(im1, se);


figure('Position',[10 10 1024 768]) ;
subplot(1,2,1);
imshow(im1);

subplot(1,2,2);
imshow(im2);
title('OPEN  -- Erosion followed by Dilation ', 'FontSize', 20 );
