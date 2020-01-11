function perspective_distort_checkerboard_For_Release_v02() 
% Start with known transformations, and see if you can reproduce them.
% The goal is to figure out how the new Matlab routines work.
%
%
% It turns out that the new API for Matlab keeps points in columns instead of rows,
% as the previous standard used.
%
%
x_inputs    = [ 400 ;
                880 ;
                960 ;
                320 ];
y_inputs    = [ 320 ;
                320 ;
                960 ; 
                960 ];

xys_in = [ x_inputs, y_inputs ];

% Again, the output X's are in the left column, and the 
% desired output Y's are in the right column.
xys_out = [ ...
    320.000  320.000 ;
    960.000  320.000 ;
    960.000  960.000 ;
    320.000  960.000 ;
];

    % Compute the distortion of these points:
    distortion = fitgeotrans( xys_in, xys_out, 'projective' );
    
    % Create an input image that is squares:
    im1 = checkerboard( 160 );
    
    % Do the image warping to find the transformation:
    im2 = imwarp( im1, distortion, 'fill', 0.5 );
    

    figure('Position',[40 140 1400 560] );
    subplot(1,2,1);
    imagesc( im1 );
    axis image;
    colormap(gray);
    hold on;
    plot( xys_in(:,1), xys_in(:,2), 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 20);
    title('Input image, showing original input points.', 'FontSize', 16 );


    subplot(1,2,2);
    imagesc( im2 );
    axis image;
    colormap(gray);
    hold on;

end

