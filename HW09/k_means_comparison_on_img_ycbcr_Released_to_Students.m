function k_means_comparison_on_img_ycbcr_Released_to_Students( fn_in )
% Because we want multiple segmentations on the same figure, they cannot use colormaps.
% We must convert to (r,g,b) pixels, and display them.
%
% Cluster image to see if number of objects is identifyable...
% K_MIN =  11;
% K_MAX =  21;
%
%
% target_size = 1220;         % Approximate pixels
%
% dst_wts = [ 1/40, 1, 5 ];

rand( 'seed', 1498 );
randn('seed', 1498 );

dst_wts   = [  0.3,  0.5, 1.0, 5.0   ];
k_vals    = [   8,  16,  40,  64  ];


% We will setup sub-plots.
% Here is the size of the matrices:
nAcross     = length(dst_wts);
nDown       = length(k_vals);
FS          = 16;                       % Small fonts for small axes:
%vers        = get_fn_version( mfilename() );

    warning(' Do not hand in copies of this code.  Use this as an example for your own implementation.');
    warning(' Dr. Kinsman might ask question about what these things mean.');
    warning(' What does meshgrid() do? ');
    %error(' This is TOO COMPLICATED FOR ONE IMAGE.  Hand in hte code that works for you... ');

    if nargin==0
        fn_in = 'me.jpg';     % This version is 720x960x3
    end

    im_orig     = imread( fn_in );
    
    % WHY RESIZE here... 
    im          = imresize( im_orig, 0.5 );
    dims        = size( im );
    im          = rgb2ycbcr( im );
    
    % What does this do??? 
    fltr        = fspecial( 'gauss', [15 15], 1.4 );
    im          = imfilter( im, fltr, 'same', 'repl' );
    
    % What does this do???
    [xs, ys]    = meshgrid( 1:dims(2), 1:dims(1) );

    lums        = im(:,:,1);
    cb_s        = im(:,:,2);
    cr_s        = im(:,:,3);

    fig_imgs    = figure('Position', [ 10 10 1024 768] );      % For image comparisons:
    fig_edgs    = figure('Position', [600 10 1024 768] );      % For edge maps between segments:
    
    loop_counter = 1;
    
    for wt_idx = 1:length(dst_wts)
        
        wt = dst_wts(wt_idx);

        for k_idx = 1:length(k_vals)
            
            k                       = k_vals(k_idx);
            attributes              = [ xs(:)*wt, ys(:)*wt, double(lums(:)), double(cb_s(:)), double(cr_s(:)) ];

            tic;
            [clstrID, clstrCntr]    = kmeans( attributes, k) %... pick some parameters here ... );
            toc

            cm_to_use_ycbcr         = uint8( clstrCntr( :, 3:end ) );
            cm_to_use_rgb_uint8     = ycbcr2rgb( cm_to_use_ycbcr );
            
            % Convert the cluster ID's back into the shape of an image.
            % (Matlab Judo)
            im_new                  = reshape( clstrID, dims(1), dims(2) );
            
            %  Find the any edges between segments:
            fltr_dx                 = [-1, 0, 1] / 2;
            fltr_dy                 = [-1, 0, 1].' / 2;
            dI_dx                   = imfilter( im_new, fltr_dx, 'same', 'repl');
            dI_dy                   = imfilter( im_new, fltr_dy, 'same', 'repl');
            dI_mag                  = sqrt( dI_dx.^2 + dI_dy.^2 );
            im_edges                = ~(dI_mag > 0);
            
            %
            %  Now we need to convert from indexed color to RGB for common display:
            %
            red_lut                 = cm_to_use_rgb_uint8(:,1);
            grn_lut                 = cm_to_use_rgb_uint8(:,2);
            blu_lut                 = cm_to_use_rgb_uint8(:,3);
            
            im_new_rgb24            = red_lut(im_new);
            im_new_rgb24(:,:,2)     = grn_lut(im_new);
            im_new_rgb24(:,:,3)     = blu_lut(im_new);

            
            axes_width              = 1 / (nAcross + 1);
            axes_height             = 1 / (nDown   + 1);
            margin_dx               = axes_width  / 8;
            margin_dy               = axes_height / 8;
            axes_dist_over          = (wt_idx-1)   / (nAcross) + margin_dx;
            axes_dist_up            = 1 - (k_idx)  / (nDown)   + margin_dy;
            
            
            %
            %  Display the Resulting Image:
            %
            figure( fig_imgs );
            new_axes                = axes( 'Position', [ axes_dist_over,  axes_dist_up, ...
                                                          axes_width,      axes_height ] );
            imagesc( im_new_rgb24 );
            axis off;
            ttl_txt = sprintf('Clusters=%d,  xyWT=%3.1f', k, wt);
            title( ttl_txt, 'FontSize', FS );
            drawnow;
            

            %
            %  Display the Edges:
            %
            figure( fig_edgs );
            new_axes                = axes( 'Position', [ axes_dist_over,  axes_dist_up, ...
                                                          axes_width,      axes_height ] );
            imagesc( im_edges );
            axis off;
            title( ttl_txt, 'FontSize', FS );
            colormap( gray );
            drawnow;
            
            loop_counter = loop_counter + 1;
         end
    end

    [dr, bn, ex] = fileparts( mfilename() );
    
    figure( fig_imgs );
    set(gcf,'Color','w');
    set(gcf,'Resize','off');
    
    figure( fig_edgs );
    set(gcf,'Color','w');
    set(gcf,'Resize','off');
    
    fprintf('DONE \n');
end

