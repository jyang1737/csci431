function Example_elementWise_operations() 

    m3 = magic(3);
    
    m5 = [ 1 0 1 ;
           0 1 0 ;
           0 0 1 ];
    
    m3b = m3 .* m5
    
    tmp = m5 ./ m3

    im = im2double( imread('cameraman.tif') );
    
    s1 = [-1 0 1;
          -2 0 2 ;
          -1 0 1 ]/8;

    edges_dx = imfilter( im, s1,   'same', 'repl' );
    edges_dy = imfilter( im, s1.', 'same', 'repl' );
             
    mag = sqrt( edges_dx.^2 + edges_dy.^2 );
    
    imagesc( mag );
    colormap( jet );
    axis image;

end
