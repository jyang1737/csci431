function DEMO__HarrisCorners_1_no_noise()

    warning('Students: read the documentation on detectHarrisFeatures.'):
    
    im = checkerboard( 40, 8, 8 );
    im_gry = im(:,:,1);
    
    pts = detectHarrisFeatures( im_gry );
    
    figure( 'Position', [100 10 1024 768] );
    imagesc( im_gry );
    colormap( gray );
    
    hold on;
    
    for pt_idx = 1:length( pts )
        xy = pts(pt_idx).Location;
        plot( xy(1), xy(2), ...
            'rs', 'MarkerSize', 16, 'LineWidth', 2 );
    end

end
