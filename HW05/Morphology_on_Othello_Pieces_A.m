%
%  Fun trying to find the number of Othello pieces in an image.
%
%  Thomas B. Kinsman,
%
%    '24-Sep-2019'
%
function Morphology_on_Othello_Pieces_A( ) 

% You can get the image "Othello_Pieces_02.jpg" from MyCourses ... TEST_IMAGES.
%
% Here I add my local TEST_IMAGES directory to my path, so that this script can find
% the image in one location.
% 
addpath( '../../MY_COURSES_MIRROR/TEST_IMAGES/' );

FONT_SIZE = 20;         % Sets font size for text.  Used later on.


    % Now Matlab can find the image, and load it.
    %
    % Notice that I convert it to double immediately.
    % This is because I know I am going to do math on it very soon.
    %
    im = im2double( imread('Othello_Pieces_02.jpg') );

    %
    % One of many ways to get to gray is to average the three colors together.
    im_temp = im(:,:,1) + im(:,:,2) + im(:,:,3);    % Add up all the color channels.
    im_gray = im_temp / 3;                          % Take the average.
    
    imshow( im_gray );
    
    % The "pause" command all by itself makes the 
    % processing stop until you hit the return key.
    disp('Paused.  Look at the image.  Hit return to continue.');
    pause();
    
    %  Let us be naive, and assume that the values <= 0.5 are black,
    %  and the values > 0.5 are white:
    black_and_white_im = im2bw( im_gray, 0.5 );
    imshow( black_and_white_im );
    
    
    % The "pause" command all by itself makes the 
    % processing stop until you hit the return key.
    fprintf('Look CLOSELY at the black and white image.  Notice the following things:\n\n');
    fprintf('1.  Just using a middle value of 0.5 did not make a very good "black and white" image.\n');
    fprintf('2.  Notice that there is a gradient across the image.  Some regions of the image are darker.\n');
    fprintf('3.  Notice that the corners of the image tend to be darker then the center.\n');
    fprintf('    This is caused by the light spreading out inside the camera.\n');
    fprintf('4.  Notice that you can see imperfections in the gray surface -- scratches and dents.\n');
    fprintf('5.  Notice that there is a "speckling" pattern where the image transitions between dark and bright.\n');
    fprintf('6.  Notice that there are DARK   shadows around the white pieces.\n');
    fprintf('7.  Notice that there are BRIGHT rings around the black pieces, caused by light reflecting off the plastic.\n\n');
    fprintf('\nHit return to continue.');
    pause();
    
    %
    % Another quick way to get to gray is to average the three colors together,
    % BUT GIVE THE GREEN CHANNEL MORE WEIGHT.  NOTICE THE VALUE OF TWO HERE:
    im_temp = im(:,:,1) + 2* im(:,:,2) + im(:,:,3);    
    im_gray = im_temp / 4;                          % Take the average.

    % Let's create a new figure, and put a histogram of the grayscale version in that figure:
    figure( 'Position', [10 10 1024 768] );  % Set the size to 1024x768 for display.
    imhist( im_gray );                                      % This version displays the data.
    
    fprintf('Looking at the histogram, we can see that the image has three modes to it:\n');
    fprintf('There are three lumps in the histogram.\n');
    [bin_counts, bin_locations] = imhist( im_gray );        % Collects the data.

    % Here I "decorate" the histogram with some text.
    x_over   = bin_locations( 25 );
    y_height = max( bin_counts( 20:30 ) ) * 1.15;
    text( x_over, y_height, '\leftarrow These Pixels are DARK.', ...
                            'FontSize',   FONT_SIZE, ...
                            'FontWeight', 'bold', ...
                            'Rotation', 90 );
                        
    offset_index            = 180;
    [max_ht, max_location]  = max( bin_counts( 180:225 ) );
    max_location            = max_location + offset_index;
    x_over                  = bin_locations( max_location );
    y_height = max( bin_counts( 180:225 ) ) * 1.15;
    text( x_over, y_height, '\leftarrow These Pixels are BRIGHT.', ...
                            'Color', 'w', ...
                            'BackgroundColor', 'k', ...
                            'FontSize',   FONT_SIZE, ...
                            'FontWeight', 'bold', ...
                            'Rotation', 90 );

    x_over   = bin_locations( 128 );
    text( x_over, y_height, '\leftarrow These Pixels are GRAY, or Middle level.', ...
                            'Color', [1 1 1]*0.75, ...
                            'BackgroundColor', 'k', ...
                            'FontSize',   FONT_SIZE, ...
                            'FontWeight', 'bold', ...
                            'Rotation', 90 );

    % The "pause" command all by itself makes the 
    % processing stop until you hit the return key.
    disp('Paused.   Hit return to continue.');
    pause();

    
    % Display the grayscale image itself:
    imagesc( im_gray );
    axis image;
    colormap(gray);
    
    disp('Paused.  Hit return to continue.');
    pause();

    % This runs Otsu's method to find a threshold to segment the image at:
    % This assumes it is a text document, not an image.
    thresh = graythresh( im_gray );            
    fprintf('The threshold which the computer might automatically use for a black-and-white text image would be %4.2f\n', ...
        thresh );
    
    % Your task is to find a way to count the number of black othello pieces.
    % And the number of white othello pieces, in this image.
    %
    % Use thresholding to segment the image.
    % You will have to do it a couple of ways -- to segment out the white pieces.
    % And again to segment out the dark pieces.
    %
    % In both cases, you will need the following commands, with some structuring elements:
    % imerode( ) to remove small white specs.
    % imdilate() to remove small black specs.
    % imopen( )  to do erosion followed by dilation.
    % imclose( ) to do dilation followed by erosion.
    % imcomplement to invert the image.
    % bwlabel( ) count the number of white blobs in the image.
    %
    
    % here are some doodles from Dr. Kinsman:
    
    % sub-sample the image, because those are big pieces in a big image:
    im_gray_small = imresize( im_gray, 0.125 );    % Much easier to handle.  Only 192 x 256 pixels.
    
    % Guess at a threshold here:
    im_bw_white_stuff     = imbinarize( im_gray_small, 0.667 );
    imagesc( im_bw_white_stuff );
    axis image;
    title('First Attempt at finding white things.', 'FontSize', FONT_SIZE );

    disp('Paused.  Hit Return when ready');
    pause();


    % Get rid of small white blobs caused by specular reflections:
    large_structuring_element   = strel( 'disk', 6, 4 );
    im_bw_white_erodded         = imerode( im_bw_white_stuff, large_structuring_element );
    imagesc( im_bw_white_erodded );
    axis image;
    title('Second Attempt.  After erosion...', 'FontSize', FONT_SIZE );

    disp('Paused.  Hit Return when ready');
    pause();
    
    %
    %  bwlabel  finds regions connected.  These are called "connected components".
    %
    [labeled_image, n_regions_found] = bwlabel( im_bw_white_erodded );
    
    fprintf('According to bwlabel, there are %d regions there.\n', n_regions_found );
    
    pause( 3 );
    for region_idx = 0 : n_regions_found
        
        % Create a temporary boolean image:
        bw_temp_region  =  labeled_image==region_idx;
        
        % Display the region:
        imagesc( bw_temp_region );
        axis image;
        
        % Create a temporary title, and put it on the image:
        temp_ttl = sprintf('Region Number %d', region_idx );
        title( temp_ttl, 'FontSize', FONT_SIZE );
        
        pause( 3 );
    end

end



