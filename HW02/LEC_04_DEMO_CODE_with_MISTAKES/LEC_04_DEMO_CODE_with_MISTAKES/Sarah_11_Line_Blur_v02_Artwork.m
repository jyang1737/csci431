
function Sarah_11_Line_Blur_v02_Artwork( )
rand('seed', 2345);     % Always seed your random number generator.

BLUR_LENGTH  = 15;
LEFT__MARGIN = round( (BLUR_LENGTH-1)/2 );
RIGHT_MARGIN = round( (BLUR_LENGTH-1)/2 );

    fn_in = 'me.jpg';

    % Here I read in the image, and immediately convert it to double format
    % for extra precision when doing computations:
    im_in = im2double( imread( fn_in ) );

    % Rotate the image 90 degrees:
    im_in = imrotate( im_in, -90 );
    
    % Shrink the image, and play with the green channel only:
    % This gets every 3rd pixel of every 3rd row, and only the second color.
    im_sm = im_in( 2:3:end, 2:3:end, 2 );
    
    % Display the size of the small image variable:
    whos im_sm
   
    
    % For this particular image, add a sparkle at one point,
    % to show that one point can influence a large range:
    figure('Position',[10 10 800 800]);		% X-over, Y-up, Width, Height 
    imagesc( im_sm );
    colormap(gray);
    beep;
    display('Dear User -- please click on an eyeball, and then hit return:');
    [xs, ys] = ginput();
    
    % Make into an integer location:
    xs = round(xs(1));
    ys = round(ys(1));
    
    im_sm( ys,          xs )                                    = 1.0;
    im_sm( [ys-LEFT__MARGIN:ys+RIGHT_MARGIN], xs )              = 1.0;
    im_sm( ys,          [xs-LEFT__MARGIN:xs+RIGHT_MARGIN] )     = 1.0;
    imagesc( im_sm );
    colormap(gray);
    pause( 3 );
    close( gcf() );
    
    
    % Initially the art is a deep copy of the original:
    im_art = im_sm;         

    % get and store the size (or dimensions) of the image:
    dims = size( im_sm );

    % Create a new figure to show results on:
    figure('Position',[10 10 800 800]);		% X-over, Y-up, Width, Height 

    % Blur each image line over 7 pixels.
    for line_down = 1 : dims(1)		% For each line down the image.

        for column_over = (LEFT__MARGIN+1):(dims(2)-RIGHT_MARGIN)

            % Get seven pixels of the image:
            tmp_chunk                       = im_sm( line_down, (column_over-LEFT__MARGIN):(column_over+RIGHT_MARGIN) );

            % Average the block:
            avg_value                       = mean( tmp_chunk );

            % Put that average value into the output artwork: 
            im_art(line_down,column_over) = avg_value;
        end

        % Display progress as we go along:
        if ( mod(line_down,10)==1 )
            imagesc( im_art );
            colormap(gray);
            axis image;
           
            hold on; 	% DO NOT OVER-WRITE WHAT IS IN THE CURRENT BUFFER: 
            plot( [1, dims(2)], [1 1]* line_down, 'm-', 'LineWidth', 3 );
            drawnow;
            
            hold off; 	% NEXT TIME YOU DRAW, *DO OVER-WRITE THE CURRENT BUFFER* 
        end
    end

    % imwrite( im_art, 'Sarah_03_Line_Blur.jpg', 'JPEG' );
end


