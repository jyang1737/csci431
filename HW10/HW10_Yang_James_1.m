function HW10_Yang_James_1() 

    %image names
    img_list(1).name = 'IMG_9720.JPG';
    img_list(2).name = 'IMG_9740.JPG';
    img_list(3).name = 'IMG_9743.JPG';
    
    %corners of the sheet of paper for each image
    img_list(1).xs = [749.9 816.8 4826.5 3986.4];
    img_list(1).ys = [1078.5 2992.2 2588.5 828.2];
    
    img_list(2).xs = [1131.8 1847.8 4167.7 3167.7];
    img_list(2).ys = [1490.3 2685.4 1805.2 908.9];
    
    img_list(3).xs = [2372.9 1150.9 3146.2 4234.6];
    img_list(3).ys = [868.5 1659.9 2774.2 1635.6];
    
    %points to map the corners to
    fixed_points_xs = [1000 1000 4000 4000];
    fixed_points_ys = [2000 4000 4000 2000];
    fixed_points = [fixed_points_xs.', fixed_points_ys.'];
    
    for file_index = 1 : length(img_list)
            
        im = im2double(imread(img_list(file_index).name));
        
        %create the matrix for source points
        source_pts = [img_list(file_index).xs.', img_list(file_index).ys.'];
        
        %create the transformation matrix with a projective one
        image_tform = fitgeotrans(source_pts, fixed_points, 'projective');
        
        %apply the transformation
        im = imwarp(im, image_tform, 'FillValues', 255);
    
        imagesc(im); 
        %imwrite(im, 'Hello.jpg');
        pause();
    end
    
end