
function Sarah_07_Show_Artwork_Median_v02( fn_in )
rand('seed', 2345);     % Always seed your random number generator.
N_BLOCKS        = 50000;
BLOCK_SIZE      = 10;

    if ( nargin < 1 )
        fn_in = 'me.jpg';
    end
    im_in = imrotate( imread( fn_in ), -90 );
    
    % Shrink the image, and play with the green channel only:
    im_sm = im_in( 2:3:end, 2:3:end, 1 );
    
    % Find out the size of the small image:
    whos im_sm
    
    im_art = im_sm;         % Deep copy automatically.
    
    % get and store the size (or dimensions) of the image:
    dims = size( im_sm );
    figure('Position',[10 10 800 800]);

    % Do random art on the image.
    for block_idx = 1 : N_BLOCKS
        % Get a chunk of the image:
        tmp_rand    = rand(1,1) * ( dims(1) - BLOCK_SIZE ) + 1;
        rand_top    = round( tmp_rand );
        
        tmp_rand    = rand(1,1) * ( dims(2) - BLOCK_SIZE ) + 1;
        rand_left   = round( tmp_rand );
        
        % Now get a full block of the image:
        img_block   = im_sm( rand_top:(rand_top+BLOCK_SIZE-1), rand_left:(rand_left+BLOCK_SIZE-1) );
        avg_block   = median( img_block(:) );
        
        im_art(rand_top:(rand_top+BLOCK_SIZE-1), rand_left:(rand_left+BLOCK_SIZE-1) ) = avg_block;
        
        % Every 100 blocks, show the image:
        if ( mod( block_idx, 100 ) == 0 )
            imagesc( im_art );
            colormap(gray);
            axis image;
            drawnow;
        end
    end
    
    % Redraw the final form:
    imagesc( im_art );
    colormap(gray);
    axis image;
    drawnow;
    
    imwrite( im_art, 'Sarah_07_as_Artwork_Median_v02.jpg', 'JPEG', 'Quality', 95 );

end



