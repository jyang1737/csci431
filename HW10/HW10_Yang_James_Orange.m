function HW10_Yang_James_Orange()
   
    %Majority of code is from sample code by Dr. Kinsman
    %Commented throughout code to show understanding
    fn = 'IMG_3305.jpg';

    %read and rotate image
    im_rgb = imrotate(imread( fn ), -90);
    imshow( im_rgb );

    %select objects to detect
    fprintf('SELECT FOREGROUND OBJECT ... ');
    fprintf('Click on points to capture positions:  Hit return to end...\n');
    [x_fg, y_fg] = ginput();

    %select objects to ignore
    fprintf('SELECT BACKGROUND OBJECT ... ');
    fprintf('Click on points to capture positions:  Hit return to end...\n');
    [x_bg, y_bg] = ginput();

    %color space to use
    im_lab      = rgb2lab( im_rgb );
    im_a        = im_lab(:,:,2);
    im_b        = im_lab(:,:,3);
    
    %get the a and b channels of the foreground points
    fg_indices  = sub2ind( size(im_lab), round(y_fg), round(x_fg) );
    fg_a        = im_a( fg_indices );
    fg_b        = im_b( fg_indices );
    
    %get the a and b channels of the background points
    bg_indices  = sub2ind( size(im_lab), round(y_bg), round(x_bg) );
    bg_a        = im_a( bg_indices );
    bg_b        = im_b( bg_indices );
   
    %form matrix with all the a and b channels for each type
    fg_ab       = [ fg_a fg_b ];
    bg_ab       = [ bg_a bg_b ];
    im_ab       = [ im_a(:) im_b(:) ];
    
    %calculate the mahalanobis distance with all points in the image
    mahal_fg    = ( mahal( im_ab, fg_ab ) ) .^ (1/2);
    mahal_bg    = ( mahal( im_ab, bg_ab ) ) .^ (1/2);
    
    %pick points where foreground is lower than background
    class_0     = mahal_fg < mahal_bg;
    %reform image
    class_im    = reshape( class_0, size(im_a,1), size(im_a,2) );
    
    %calculate statistical measurements, mean and std deviation
    fg_dists        = mahal_fg;
    fg_dists_cls0   = fg_dists(class_0);
    dist_mean       = mean( fg_dists_cls0 );
    dist_std_01     = std(  fg_dists_cls0 );
    

    %choose values within 1 standard deviation of mean. 
    b_inliers       = ( fg_dists_cls0 <= (dist_mean + dist_std_01) ) & ( fg_dists_cls0 >= (dist_mean - dist_std_01));
    the_inliers     = fg_dists_cls0( b_inliers );
    dist_mean       = mean( the_inliers );
    
    %choose points within the threshold
    threshold       = dist_mean;
    guess_cls0      = fg_dists < threshold;
    %reform image 
    class_im        = reshape( guess_cls0, size(im_a,1), size(im_a,2) );
    %Do morphology to clean up some of the spots
    struc_elmt      = strel('disk',5);
    class_im        = imclose(class_im, struc_elmt); 
    
    colormap('gray');
    imagesc(class_im);
    %imwrite(class_im, 'orange.jpg');
    
    
end