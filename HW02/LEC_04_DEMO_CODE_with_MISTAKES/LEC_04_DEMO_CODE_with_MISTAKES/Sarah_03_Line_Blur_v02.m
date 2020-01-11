
function Sarah_03_Line_Blur_v02( )
rand('seed', 2345);     % Always seed your random number generator.
N_BLOCKS        = 500;
BLOCK_SIZE      = 48;

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
   
    % Initially the art is a deep copy of the original:
    im_art = im_sm;         

    % get and store the size (or dimensions) of the image:
    dims = size( im_sm );

    % Create a new figure to show results on:
    figure('Position',[10 10 800 800]);		% X-over, Y-up, Width, Height 

    BLUR_LENGTH  = 31;
    LEFT__MARGIN = round( (BLUR_LENGTH-1)/2 );
    RIGHT_MARGIN = round( (BLUR_LENGTH-1)/2 );

    % Blur each image line over 7 pixels.
    for line_down = 1 : dims(1)		% For each line down the image.

        for column_over = (LEFT__MARGIN+1):(dims(2)-RIGHT_MARGIN)

            % Get seven pixels of the image:
            tmp_chunk               = im_sm( line_down, ...
                                               (column_over-LEFT__MARGIN):(column_over+RIGHT_MARGIN) );

            % Average the block:
            avg_value               = mean( tmp_chunk );

            % Put that average value into the output artwork: 
            im_art(line_down,column_over) = avg_value;
        end

        % Display progress as we go along:
        if ( mod(line_down,10)==1 )
            imagesc( im_art );
            colormap(gray);
            axis image;
            
            hold on;
            plot( [1, dims(2)], [line_down line_down], 'm-', 'LineWidth', 3 );
            drawnow;
            
            hold off;
        end
    end

    imwrite( im_art, 'Sarah_03_Line_Blur.jpg', 'JPEG' );
end


