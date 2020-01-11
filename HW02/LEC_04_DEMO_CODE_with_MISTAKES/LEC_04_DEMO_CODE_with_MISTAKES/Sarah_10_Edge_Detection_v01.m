
function Sarah_10_Edge_Detection_v01( fn_in )
% Do median over every block:
BLOCK_SIZE      = 5;

    if ( nargin < 1 )
        fn_in = 'me.jpg';
    end
    
    im_in  = im2double( imread( fn_in ) );
    im_rot = imrotate( im_in, -90 );
    
    % Shrink the image, and play with the green channel only:
    im_sm = im_rot( 2:3:end, 2:3:end, 2 );        % Trim off the bottom
    
    % Find out the size of the small image:
    whos im_sm
    
    im_art = zeros(size(im_sm));      
    
    % get and store the size (or dimensions) of the image:
    dims = size( im_sm );
    figure('Position',[10 10 800 800]);

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
        
        % After each line, update the output, but ignore the edges:
        im_diff = im_sm-im_art;
        imagesc( im_diff( 3:end-3, 3:end-3 ) );
        colormap(gray);
        axis image;
        drawnow;
    end
    
    % Show the difference from the original and the smoothed:
    im_diff = im_sm-im_art;
    imagesc( im_diff( 3:end-3, 3:end-3 ) );
    colormap(gray);
    axis image;
    drawnow;
    
    % Convert the range of im_diff to something we can write out:
    % First, trim off hte edges:
    im_diff     = im_diff( 3:end-3, 3:end-3 );
    mmax        = max( im_diff(:) );
    mmin        = min( im_diff(:) );
    im_writable = uint8((im_diff - mmin) / (mmax-mmin) * 255 );
    
    imwrite( im_writable, 'Sarah_10_Edgy_v01.jpg', 'JPEG', 'Quality', 95 );
end



