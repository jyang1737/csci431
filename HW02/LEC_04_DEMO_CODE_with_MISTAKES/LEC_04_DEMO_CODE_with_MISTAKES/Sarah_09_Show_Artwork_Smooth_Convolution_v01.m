
function Sarah_09_Show_Artwork_Smooth_Convolution_v01( fn_in )
% Do median over every block:
BLOCK_SIZE      = 4;

    if ( nargin < 1 )
        fn_in = 'me.jpg';
    end
    
    im_in  = im2double( imread( fn_in ) );
    im_rot = imrotate( im_in, -90 );
    
    % Shrink the image, and play with the green channel only:
    im_sm = im_rot( 2:3:end, 2:3:end, 2 );
    
    % Find out the size of the small image:
    whos im_sm
    
    im_art = im_sm;      
    
    % get and store the size (or dimensions) of the image:
    dims = size( im_sm );
    figure('Position',[10 10 1024 800]);

    % Do random art on the image.
    for top = round(BLOCK_SIZE/2) : floor((dims(1)-(BLOCK_SIZE/2)))
        for left = round(BLOCK_SIZE/2) : floor((dims(2)-(BLOCK_SIZE/2)))

            % Compute the local average for this region:
            
            tmp_total = 0;
            
            for iii = ceil(-BLOCK_SIZE/2) : floor(BLOCK_SIZE/2)
                for jjj = ceil(-BLOCK_SIZE/2) : floor(BLOCK_SIZE/2)
                    tmp_total = tmp_total + im_sm( top+iii, left+jjj );
                end
            end
            block_avg   = tmp_total / (BLOCK_SIZE^2);
            
            im_art( top, left ) = block_avg;

        end
        
        if ( mod( top, 4 ) == 0 )
            % After every so-many lines, update the output:
            imagesc( im_art );
            colormap(gray);
            hold on;
            axis image;
            plot( [0 dims(2)], [1 1]*top, 'r-', 'LineWidth', 1 );
            drawnow;
            
        end
    end
    
    % Redraw the final form:
    imagesc( im_art );
    colormap(gray);
    axis image;
    drawnow;
    
    imwrite( im_art, 'Sarah_09_Local_Avg_Convolution_v01.jpg', 'JPEG', 'Quality', 95 );

end



