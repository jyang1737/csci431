

im1         = imread('circles.png');  
se          = strel('disk',10);        
im2         = imerode(im1, se);

figure('Position', [200, 10 1024 768] );
subplot(1,2,1);
imshow(im1);
title('Input ', 'FontSize', 20 );

subplot(1,2,2);
imshow(im2);
title('EROSION w/ a Disk of size 11 ', 'FontSize', 20 );