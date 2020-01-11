
function Sarah_01_Show_Noise_v01( fn_in )

    if ( nargin < 1 )
        fn_in = 'Sarah_Someone_Full_Sized.JPG';
    end
    im_in = imrotate( imread( fn_in ), -90 );
    
    im_sm = im_in( 2:3:end, 2:3:end, : );
    
    % Find out the size of the small image:
    whos im_sm
    
    imagesc( im_sm )
    axis image
    
    % Get a single line of image data:
    im_line = im_sm( 150, :, 2 );
    
    % Create a new figure:
    figure('Position',[30 20 800 800 ] );
    plot( im_line, 'k-' );
    
    % Output the results from the current frame buffer:
    frm     = getframe();
    imwrite( frm.cdata, 'Sarah_01_NoiseLine.png', 'PNG' );

end

