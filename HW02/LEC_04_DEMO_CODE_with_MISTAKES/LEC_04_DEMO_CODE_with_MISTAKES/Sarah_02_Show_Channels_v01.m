
function Sarah_02_Show_Channels_v01( )

    fn_in = 'me.jpg';
    im_in = imrotate( imread( fn_in ), -90 );
    
    im_sm = im_in( 2:3:end, 2:3:end, : );
    
    % Find out the size of the small image:
    whos im_sm
    
    imagesc( im_sm );
    axis image;
    
    % This is MY ROUTINE TO SHOW EACH COLOR CHANNEL SEPARATELY.
    %
    % We should step through it to see what it does:
    %
    warning('Reminder to Dr. K -- Step through the following code in the debugger.');
    show_img_planes( im_sm );
    
    % Output the results from the current frame:
    frm     = getframe( gcf() );			% Get the data from the current frame.
							% "doc getframe()" for more details.

    imwrite( frm.cdata, 'Sarah_02_Channels.jpg', 'JPEG', 'Quality', 95 );

end

