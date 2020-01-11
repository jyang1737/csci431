function HW05_Yang_James() 

    %adding path for images
    addpath('../TEST_IMAGES');
    addpath('../../TEST_IMAGES');
    FONT_SIZE = 20;
    %reading othello image
    im = im2double( imread('Othello_Pieces_02.jpg'));

    %Morphology
    %choosing colormap and resizing image to make it easier
    colormap(gray);
    im_gray = imresize(rgb2gray(im) , 0.125);

    %Using the complement threshold from the white pieces.
    black_and_white_im = imbinarize( im_gray, 0.33 );

    %Using complement for all the operations
    im_bw_complement = imcomplement(black_and_white_im);
    
    %Using imclose to fill in the holes
    structuring_element   = strel( 'disk', 5, 4 );
    im_bw_close = imclose(im_bw_complement, structuring_element);

    %Using bwlabel to segment the regions and return the result
    [~, number_of_black] = bwlabel(im_bw_close);

    fprintf('According to bwlabel, there are %d black pieces.\n',number_of_black);

    
    %Edge Detection
    %sobel filter
    sobel = [-1 0 1;
             -2 0 2;
             -1 0 1];
         
    edges_dx = imfilter( im_gray, sobel,   'same', 'repl' );
    edges_dy = imfilter( im_gray, sobel.', 'same', 'repl' );

    %Magnitude of edges usign sobel filter
    mag = sqrt( edges_dx.^2 + edges_dy.^2 );
    colormap( jet );
    imagesc( mag );
    axis image;
    title('Magnitude of edge using Sobel', 'FontSize', FONT_SIZE);
    colorbar;
    pause();
    
    %angle to the edge using sobel filter
    angle = atan2d(edges_dy, edges_dy);
    imagesc(angle);
    colorbar;
    title('Angle of edges in image, in degrees', 'FontSize', FONT_SIZE);
    pause();
    
    %finding edges using laplacian 
    fltr = fspecial('laplacian', 1);
    edges_dx = imfilter(im_gray, fltr, 'same', 'repl');
    edges_dy = imfilter(im_gray, fltr.', 'same', 'repl');
    mag_lap = sqrt(edges_dx.^2 + edges_dy.^2);
    imagesc(mag_lap);
    colorbar;
    title('Edges using Laplacian', 'FontSize', FONT_SIZE);
    pause();
    
    %finding edges using LoG filter
    fltr_lap_log = fspecial('log', 9, 2);
    edges_dx = imfilter(im_gray, fltr_lap_log, 'same', 'repl');
    edges_dy = imfilter(im_gray, fltr_lap_log.', 'same', 'repl');
    mag_log = sqrt(edges_dx.^2 + edges_dy.^2);
    imagesc(mag_log);
    colorbar; 
    title('Edges using LoG', 'FontSize', FONT_SIZE);
    pause();
end