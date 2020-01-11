function HW07_Yang_James_MAIN() 
    addpath('../TEST_IMAGES');
    %cd ../TEST_IMAGES;
    show_all_files_in_dir();
   
end

function show_all_files_in_dir()
    file_list = dir('*.jpg');

    for counter = 1 : length(file_list)
       
        %reading image
        fn = file_list(counter).name;
        fprintf('file %3d = %s\n', counter, fn);
        
        im_in = imread(fn);
        dims = size(im_in);
        if (dims(1) > dims(2))
            im_in = imrotate(im_in, 90);
        end
        %use red channel 
        im_gray = im_in(:,:,1);
        %change to bw
        im_bin = imbinarize(im_gray, 0.7);
        %decrease resolution
        im_bin = imresize(im_bin, 0.5);
        structuring_element_sq = strel('square', 50);
        structuring_element_cir = strel('disk', 4);
        
        %use closing and opening to separate dice and dots
        im_close = imclose(im_bin, structuring_element_sq);
        im_open = imopen(im_bin, structuring_element_cir);
        imshow(im_open);
        pause();
        im_combine = and(im_open, im_close);
        im_combine = imdilate(im_combine, structuring_element_cir);
        
        [regions, number_of_die] = bwlabel(im_combine);
        %use map to keep track of dice with dots
        c = containers.Map;
        for iii = 1:6
            c(string(iii)) = 0;
        end
        c('unknown') = 0;
        
        totaldots = 0;
        
        %loop through regions to count dots on a die
        for region_idx = 1 : number_of_die

            % Create a temporary boolean image:
            bw_temp_region  =  regions==region_idx;

            % use bwlabel again to count the number of dots on the die
            bw_dots = imcomplement(bw_temp_region);
            bw_dots = imclose(bw_dots, structuring_element_cir);
            [~, number_of_dots] = bwlabel(bw_dots);
            number_of_dots = number_of_dots - 1;
            
            %if there are too many or too little dots, put it in unknown
            if (number_of_dots < 1 || number_of_dots > 6)
                c('unknown') = c('unknown') + 1;
                continue;
            end
            totaldots = totaldots + number_of_dots;
            c(string(number_of_dots)) = c(string(number_of_dots)) + 1;
        end
        
        %print out information
        fprintf('Number of dice: %d\n', number_of_die);
        for iii = 1:6
            fprintf('Number of %d''s:\t%d\n', iii, c(string(iii)));
        end
        fprintf('Number of unknown:\t%d\n', c('unknown'));
        fprintf('Total of all dots:\t%d\n', totaldots);

    end
end