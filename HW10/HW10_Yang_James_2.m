function HW10_Yang_James_2

    %list of images
    img_list(1).name = 'IMG_9755.JPG';
    img_list(2).name = 'IMG_9758.JPG';
    
    %points of corners of the paper
    img_list(1).xs = [1066.5 2258.5 4402.5 3094.5];
    img_list(1).ys = [1330.5 2574.5 1370.5 494.5];
    
    img_list(2).xs = [1238.5 1422.5 4306.5 3578.5];
    img_list(2).ys = [1242.5 2638.5 2226.5 994.5];
    
    %points to map corners to
    fixed_points_xs = [0 0 4000 4000];
    fixed_points_ys = [2000 3000 3000 2000];
    fixed_points = [fixed_points_xs.', fixed_points_ys.'];
    for file_index = 1 : length(img_list)
            
        im = im2double(imread(img_list(file_index).name));
        %make matrix of the original corners
        source_pts = [img_list(file_index).xs.', img_list(file_index).ys.'];
        %get transformation matrix, projective because of image angle
        image_tform = fitgeotrans(source_pts, fixed_points, 'projective');
        %apply transformation 
        im = imwarp(im, image_tform, 'FillValues', 255);
        %imwrite(im, 'Secret.jpg');
        imagesc(im); 
        
        pause();
    end
    
end
