
function Sarah_05_Show_Artwork_v01( )
rand('seed', 2345);     % Always seed your random number generator.
N_BLOCKS        = 500;
BLOCK_SIZE      = 15;

    fn_in = 'me.jpg';
    im_in = imrotate( imread( fn_in ), -90 );
    
    % Shrink the image, and play with the green channel only:
    im_sm = im_in( 2:3:end, 2:3:end, 2 );
    
    % Find out the size of the small image:
    whos im_sm
    
    im_art = im_sm;         % Deep copy automatically.
    
    % get and store the size (or dimensions) of the image:
    dims = size( im_sm );
    figure('Position',[10 10 1024 800]);

    % Do random art on the image.
    for block_idx = 1 : N_BLOCKS
        % Get a chunk of the image:
        tmp_rand    = rand(1,1) * ( dims(1) - BLOCK_SIZE ) + 1;
        rand_top    = round( tmp_rand );
        
        tmp_rand    = rand(1,1) * ( dims(2) - BLOCK_SIZE ) + 1;
        rand_left   = round( tmp_rand );
        
        % Now get a full block of the image:
        img_block   = im_sm( rand_top:(rand_top+BLOCK_SIZE-1), rand_left:(rand_left+BLOCK_SIZE-1) );
        avg_block   = mean( img_block(:) );
        
        im_art(rand_top:(rand_top+BLOCK_SIZE-1), rand_left:(rand_left+BLOCK_SIZE-1) ) = avg_block;
        imagesc( im_art );
        colormap(gray);
        axis image;
        drawnow;			% Force an update on the display.
    end

    imwrite( im_art, 'Sarah_05_Show_Artwork_v01.jpg', 'JPEG' );

end


