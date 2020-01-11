
function rectify_plates_and_make_GIF_v60_shrunk( )
%
% Warp all of the images so that the license plates match the plate
% in image number 4 (the middle image).  Capture all of the images
% in HD resolution (1920×1080) and save the results to an animated GIF 
% file that goes back and forth between the seven images.
%
% Thomas B. Kinsman
% Nov. 03, 2019
%
HD_SIZE = [ 1480, 2620 ];       % HEIGHT by WIDTH


    img_list(1).name = 'images/IMG_20190813_150428.jpg';
    img_list(2).name = 'images/IMG_20190813_150431.jpg';
    img_list(3).name = 'images/IMG_20190813_150435.jpg';
    img_list(4).name = 'images/IMG_20190813_150439.jpg';
    img_list(5).name = 'images/IMG_20190813_150446.jpg';
    img_list(6).name = 'images/IMG_20190813_150449.jpg';
    img_list(7).name = 'images/IMG_20190813_150452.jpg';

    img_list(1).xs	= [ 1817.916, 2110.263, 2117.417, 1819.346 ];
    img_list(1).ys	= [ 1542.449, 1527.525, 1680.488, 1697.743 ];

    img_list(2).xs	= [ 1676.598, 1992.033, 1997.148, 1676.598 ];
    img_list(2).ys	= [ 1513.457, 1499.817, 1656.682, 1671.459 ];

    img_list(3).xs	= [ 1702.402, 2029.018, 2035.527, 1702.994 ];
    img_list(3).ys	= [ 1524.853, 1513.610, 1673.368, 1688.752 ];

    img_list(4).xs	= [ 1534.553, 1869.297, 1871.150, 1531.465 ];
    img_list(4).ys	= [ 1462.479, 1462.479, 1625.528, 1624.293 ];

    img_list(5).xs	= [ 1409.723, 1744.942, 1744.320, 1402.882 ];
    img_list(5).ys	= [ 1499.956, 1505.554, 1668.499, 1662.280 ];

    img_list(6).xs	= [ 1415.896, 1739.921, 1736.189, 1405.324 ];
    img_list(6).ys	= [ 1520.019, 1537.433, 1697.269, 1679.233 ];

    img_list(7).xs	= [ 1566.374, 1883.324, 1875.498, 1555.287 ];
    img_list(7).ys	= [ 1425.863, 1446.080, 1605.859, 1583.034 ];


    middle_id       = ceil(length(img_list)/2);
    fixed_pts       = [ img_list(middle_id).xs.', img_list(middle_id).ys.' ];


    for im_idx = [ 1 : length( img_list ) ]

        figure('Position', [300 10 1200 900] );
        fn_of_plate     = img_list(im_idx).name;
        im_of_plate     = im2double( imread( fn_of_plate ) );
        dims            = size( im_of_plate );                  % Assume all images are the same size.
        
        margins         = round( ( dims(1:2) - HD_SIZE ) / 2 );
        
        imagesc( im_of_plate );
        ttl             = sprintf('%2d, %s', im_idx, fn_of_plate);
        ttl(ttl=='_')   = ' ';
        title( ttl, 'FontSize', 18 );
        
        hold on;
        plot( img_list(im_idx).xs, img_list(im_idx).ys, 'rs', 'MarkerSize', 20, 'LineWidth', 2 );
        
        % Create the geometric transformation:
        source_pts       = [ img_list(im_idx).xs.',     img_list(im_idx).ys.'    ];

        image_tform       = fitgeotrans( source_pts, fixed_pts,  'affine');
        point_tform       = fitgeotrans( fixed_pts,  source_pts, 'affine');
        im_temp           = imwarp( im_of_plate, image_tform,   ...
                              'Fill', [ 1, 0.0, 0.0],           ...
                              'OutputView',imref2d( dims ) );
        
        
%         imagesc( im_of_plate );
%         hold on;
%         plot( source_pts(:,1), source_pts(:,2), 'go', 'MarkerSize', 20, 'LineWidth', 2 );
%         pause(5);

        hold off;
        imagesc( im_temp );
        hold on;
        plot( fixed_pts(:,1),  fixed_pts(:,2),  'co', 'MarkerSize', 10, 'LineWidth', 2 );
        
        frame{ im_idx } = im_temp( margins(1):margins(1)+HD_SIZE(1), margins(2):margins(2)+HD_SIZE(2), : );

        [new_xsA,new_ysA] = transformPointsInverse( point_tform, source_pts(:,1), source_pts(:,2) );
        plot( new_xsA, new_ysA, 'yo', 'MarkerSize', 25, 'LineWidth', 2 );

        hold off;
        
        pause(1);
    end
    
    delay_time  = 0.5;
    im          = frame{1};
    im_shrunk    = im( 2:3:end, 2:3:end, : );

    [x,map]     = rgb2ind( im_shrunk, 256 );
    fname       = 'New_View_of_Car_Plate_Shrunk_v60.gif';

    imwrite( x, map, fname,     'GIF', ...
              'WriteMode',      'overwrite', ...
              'DelayTime',      delay_time, ...
              'LoopCount',      Inf, ...
              'Comment',        'Created by Thomas B. Kinsman, 2019.' );
                  
    for im_idx = [ 2 : length(img_list), length(img_list)-1:-1:2 ]
        im          = frame{im_idx};
        im_shtunk   = im( 2:3:end, 2:3:end, : );
        
        [x, map]    = rgb2ind( im_shtunk, 256 );
        imwrite( x, map, fname, 'GIF', ...
              'WriteMode', 'append', ...
              'DelayTime', delay_time );
    end

end

