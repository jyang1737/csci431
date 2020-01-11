%Starting point courtesy of Dr. Kinsman

function HW06_Yang_James() 

    im_in = im2double(imread('cameraman.tif'));  
    fltr    = [ -1 0 1 ;
                -3 0 3 ;
                -1 0 1 ] /2/5;
   
    fltr_gauss = fspecial('Gauss', 5, 2 );

    %Using normal filter
    expect_ans = imfilter( im_in, fltr, 'same', 'repl' );
    % Display my results:
    figure('Position', [300 100 600 600]);
    imagesc( expect_ans );
    colormap(gray);         % Show in gray
    axis image;             % Make the axes have square pixels.
    title('Expected Results for first filter','FontSize', 24);
    colorbar;
    disp('Showing for 5 seconds:');
    pause(3);
    my_ans_filt      = my_very_own_image_filter( im_in, fltr );
    imagesc(my_ans_filt);
    title('My Results for first filter','FontSize', 24);
    disp('Showing for 5 seconds:');
    pause(3);
    
    im_diff = imabsdiff( expect_ans, my_ans_filt );
    imagesc( im_diff );
    axis image;
    title('Difference for first filter','FontSize', 24);
    colorbar;
    
    pause();
    
    %Using Gaussian Filter
    expect_ans = imfilter( im_in, fltr_gauss, 'same', 'repl' );
    % Display my results:
    figure('Position', [300 100 600 600]);
    imagesc( expect_ans );
    colormap(gray);         % Show in gray
    axis image;             % Make the axes have square pixels.
    title('Expected Results for Gaussian filter','FontSize', 24);
    colorbar;
    disp('Showing for 5 seconds:');
    pause(3);
    my_ans_gauss      = my_very_own_image_filter( im_in, fltr_gauss );
    imagesc(my_ans_gauss);
    title('My Results for Gaussian filter','FontSize', 24);
    disp('Showing for 5 seconds:');
    pause(3);
    
    im_diff = imabsdiff( expect_ans, my_ans_gauss );
    imagesc( im_diff );
    axis image;
    title('Difference for Gaussian filter','FontSize', 24);
    colorbar;
    
    pause();
    
    im_diff = imabsdiff(my_ans_filt, my_ans_gauss);
    imagesc(im_diff);
    axis image;
    colorbar;
    title('Difference between filters');
    
    
end

function im_out = my_very_own_image_filter( im_in, fltr )
    
    %"return" value
    im_out              = im2double(zeros( size(im_in) ));  
    
    image_dimensions    = size( im_in );
    filter_dims         = size( fltr );

    for row = (1+floor(filter_dims(1)/2)) : (image_dimensions(1)-floor(filter_dims(1)/2))
        for col = (1+floor(filter_dims(2)/2)) : (image_dimensions(2)-floor(filter_dims(2)/2))
            %looping through filter
            value = 0;
            for f_row = 1 : filter_dims(1)
                for f_col = 1 : filter_dims(2)
                    %sum up values from filter
                    value = value + fltr(f_row,f_col) * im_in((row - ceil(filter_dims(1)/2) + f_row), (col - ceil(filter_dims(2)/2) + f_col)); 
                end
            end
            %set the pixels to what you want them to be.
            im_out(row,col) = value;
        end
    end
end 