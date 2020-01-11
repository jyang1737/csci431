function show_img_planes( im, plane_names )
% show the separate image color channels.

    if nargin < 2
        % This is a new type of variable called a "cell array".
        % You can stuff anything you want into a cell array.
        % More on this later on.
        plane_names = { 'RGB', 'RED', 'GREEN', 'BLUE' };
    end

    % Display components:
    figure('Position',[10 10 768 768]);
    set(gcf,'Color', [0.5 0.5 0.5]);
    subplot(2,2,1);
    imshow( im );
    ttl = [ plane_names{1} ' ' ];
    title( ttl, 'FontSize', 22 );

    subplot(2,2,2);
    imshow( im(:,:,1) );
    ttl = [ plane_names{1} ' ' ];
    title( ttl, 'FontSize', 22 );
    
    title('Red Channel ', 'FontSize', 22 );

    subplot(2,2,3);
    imshow( im(:,:,2) );
    title('Green Channel ', 'FontSize', 22 );

    subplot(2,2,4);
    imshow( im(:,:,3) );
    title('Blue Channel ', 'FontSize', 22 );
end

