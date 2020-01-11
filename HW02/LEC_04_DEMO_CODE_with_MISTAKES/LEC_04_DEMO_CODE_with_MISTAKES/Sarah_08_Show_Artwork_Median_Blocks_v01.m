
function Sarah_08_Show_Artwork_Median_Blocks_v01( fn_in )
% Do median over every block:
N_BLOCKS        = 5000;
BLOCK_SIZE      = 16;

    if ( nargin < 1 )
        fn_in = 'me.jpg';
    end
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
    for top = 1 : BLOCK_SIZE : (dims(1)-(BLOCK_SIZE-1))
        for left = 1 : BLOCK_SIZE : (dims(2)-(BLOCK_SIZE-1))

            % Now get a full block of the image:
            img_block   = im_sm( top:(top+BLOCK_SIZE-1), left:(left+BLOCK_SIZE-1) );
            avg_block   = median( img_block(:) );

            im_art(top:(top+BLOCK_SIZE-1), left:(left+BLOCK_SIZE-1) ) = avg_block;

        end
        
        % After each line, update the output:
        imagesc( im_art );
        colormap(gray);
        axis image;
        drawnow;
    end
    
    % Redraw the final form:
    imagesc( im_art );
    colormap(gray);
    axis image;
    drawnow;
    
    imwrite( im_art, 'Sarah_08_Artwork_Median_Blocks_v01.jpg', 'JPEG', 'Quality', 95 );

end

