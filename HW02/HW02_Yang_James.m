function HW02_Yang_James(fn_in)
    rand('seed', 2345);    
      
    if ( nargin < 1 )
        fn_in = 'me.jpg';
    end
    
    %reads image into array
    im_in = im2double( imread(fn_in) );
    im_in = imrotate(im_in, -90);
    im_in = imresize(im_in, 0.5);

    %copy of image
    im_art = im_in(:,:,:);

    %constants used for math
    N_BLOCKS        = 8000;
    BLOCK_SIZE      = 10;
    dims = size(im_in);
    figure('Position',[10 10 800 800]);		% X-over, Y-up, Width, Height 
    halfway_col = floor(dims(1)/2);
    halfway_row = floor(dims(2)/2);
    maxcol = dims(1);
    maxrow = dims(2);

    %separates image to four quadrants
    topleft_block = im_in(1:halfway_col, 1:halfway_row,:);
    topright_block = im_in(1:halfway_col , halfway_row+1:maxrow,:);
    bottomleft_block = im_in(halfway_col+1:maxcol, 1:halfway_row,:);
    bottomright_block = im_in(halfway_col+1:maxcol, halfway_row+1:maxrow,:);

    %copies of each channel
    im_art_red = im_art(:,:,1);
    im_art_green = im_art(:,:,2);
    im_art_blue = im_art(:,:,3);

    %rotates red channel quadrants clockwise
    im_art_red(1:halfway_col, 1:halfway_row) = bottomleft_block(:,:,1);
    im_art_red(1:halfway_col, halfway_row+1:maxrow) = topleft_block(:,:,1);
    im_art_red(halfway_col+1:maxcol, 1:halfway_row) = bottomright_block(:,:,1);
    im_art_red(halfway_col+1:maxcol, halfway_row+1:maxrow) = topright_block(:,:,1);

    %rotates blue channel quadrants counterclockwise
    im_art_blue(1:halfway_col, 1:halfway_row) = topright_block(:,:,3);
    im_art_blue(1:halfway_col, halfway_row+1:maxrow) = bottomright_block(:,:,3);
    im_art_blue(halfway_col+1:maxcol, 1:halfway_row) = topleft_block(:,:,3);
    im_art_blue(halfway_col+1:maxcol, halfway_row+1:maxrow) = bottomleft_block(:,:,3);

    %Borrowed code from Dr. Kinsman to take random blocks and find the
    %median color to fill entire block for all each channels
    for block_idx = 1 : N_BLOCKS
        % Get a chunk of the image:
        tmp_rand    = rand(1,1) * ( dims(1) - BLOCK_SIZE ) + 1;
        rand_top    = round( tmp_rand );

        tmp_rand    = rand(1,1) * ( dims(2) - BLOCK_SIZE ) + 1;
        rand_left   = round( tmp_rand );

        % Now get a full block of the image:
        img_block   = im_art_red( rand_top:(rand_top+BLOCK_SIZE-1), rand_left:(rand_left+BLOCK_SIZE-1) );
        avg_block   = median( img_block(:) );

        im_art_red(rand_top:(rand_top+BLOCK_SIZE-1), rand_left:(rand_left+BLOCK_SIZE-1) ) = avg_block;

        % Every 100 blocks, show the image:
        if ( mod( block_idx, 100 ) == 0 )
            imagesc( im_art_red );
            colormap(gray);
            axis image;
            drawnow;
        end
    end
    for block_idx = 1 : N_BLOCKS
        % Get a chunk of the image:
        tmp_rand    = rand(1,1) * ( dims(1) - BLOCK_SIZE ) + 1;
        rand_top    = round( tmp_rand );

        tmp_rand    = rand(1,1) * ( dims(2) - BLOCK_SIZE ) + 1;
        rand_left   = round( tmp_rand );

        % Now get a full block of the image:
        img_block   = im_art_green( rand_top:(rand_top+BLOCK_SIZE-1), rand_left:(rand_left+BLOCK_SIZE-1) );
        avg_block   = median( img_block(:) );

        im_art_green(rand_top:(rand_top+BLOCK_SIZE-1), rand_left:(rand_left+BLOCK_SIZE-1) ) = avg_block;

        % Every 100 blocks, show the image:
        if ( mod( block_idx, 100 ) == 0 )
            imagesc( im_art_green );
            colormap(gray);
            axis image;
            drawnow;
        end
    end
    for block_idx = 1 : N_BLOCKS
        % Get a chunk of the image:
        tmp_rand    = rand(1,1) * ( dims(1) - BLOCK_SIZE ) + 1;
        rand_top    = round( tmp_rand );

        tmp_rand    = rand(1,1) * ( dims(2) - BLOCK_SIZE ) + 1;
        rand_left   = round( tmp_rand );

        % Now get a full block of the image:
        img_block   = im_art_blue( rand_top:(rand_top+BLOCK_SIZE-1), rand_left:(rand_left+BLOCK_SIZE-1) );
        avg_block   = median( img_block(:) );

        im_art_blue(rand_top:(rand_top+BLOCK_SIZE-1), rand_left:(rand_left+BLOCK_SIZE-1) ) = avg_block;

        % Every 100 blocks, show the image:
        if ( mod( block_idx, 100 ) == 0 )
            imagesc( im_art_blue );
            colormap(gray);
            axis image;
            drawnow;
        end
    end

    %replaces original image with new channels
    %added some emphasis to blue and green
    im_in(:,:,1) = im_art_red;
    im_in(:,:,2) = im_art_green*1.1;
    im_in(:,:,3) = im_art_blue*1.2;
    imshow(im_in);
    drawnow;
    xlabel('James Yang', 'FontSize', 18);

    %writes new image to file 'new_me'.jpg
    imwrite( im_in, 'new_me.jpg', 'JPG');
end