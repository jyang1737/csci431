function CLOSING_followed_by_OPENING_with_noise_bigger_disk()

    im1         = imread('circles.png');
    im1         = imnoise( im2double(im1), 'salt & pepper', 0.02 );
    im1         = im1 > 0.5;

    se          = strel('disk', 2);       
    im2         = imclose( im1, se);     
    im3         = imopen(im2, se);


    figure('Position',[10 10 1024 768]) ;
    subplot(1,2,1);
    imshow(im1);

    subplot(1,2,2);
    imshow(im3);
    title('CLOSING THEN OPENING disk of size 2 ', 'FontSize', 20 );

end
