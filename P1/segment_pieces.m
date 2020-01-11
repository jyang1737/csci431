function segment_pieces()

    addpath('Puzzle_Images\');
    file_list = dir('Puzzle_Images\/*C.jpg');
    %dict to store puzzle pieces with id: edges
    pieces = containers.Map('KeyType', 'uint32', 'ValueType', 'any');
    
    for counter = 1 : length(file_list)
       
        fn = file_list(counter).name;
        fprintf('%s\n', fn);
        %pull id from file name
        id = sscanf(fn, 'piece%dC.jpg');

        %convert, resize to grayscale and blur 
        im = im2double(imresize(imread(fn), 0.25));
        im = rgb2gray(im);
        fltr = fspecial('gaussian');
        im = imfilter(im, fltr, 'same', 'repl');
        %use canny edge to show edges
        im_edge = edge(im, 'Canny', [0.05 0.13]);
        imshow(im_edge);
        pause();
        
        
        %if image has too many edges from the background
        %it doesn't have piece 
        %this might not work with the other sets of images
        %i'm only using the B set.
        ispiece = sum(im_edge(:)==1)/numel(im_edge)*100;
        if (ispiece < 10)
            fprintf("a puzzle piece\n");
            pieces(id) = im_edge;
        else
            fprintf("not a puzzle piece\n");
        end
        %pause();
        
    end
   
    
end