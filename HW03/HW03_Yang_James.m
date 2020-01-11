function HW03_Yang_James() 

    %loads in data from file
    load('popcorn_wave_data.mat', 'popCornSoundShape');
    
    %converts into double array, then squared to get rid of negative
    popCornSoundShape = double(popCornSoundShape);
    popCornSoundShape = popCornSoundShape.^2;
  
    %constants used
    WIDTH = 50;
    dims = size(popCornSoundShape);
    
    %copy 
    popCorn_median_small = popCornSoundShape;
    
    %using median to smooth over small range
    for left = round(WIDTH/2)+1 : floor(dims(1)-(WIDTH/2))
        tmp_block = popCornSoundShape(left-WIDTH/2:left+WIDTH/2);
        median_val = median(tmp_block(:));
        popCorn_median_small(left) = median_val;
    end
    
    %using median to smooth over large range
    WIDTH = 500;
    popCorn_median_big = popCornSoundShape;
    
    for left = round(WIDTH/2)+1 : floor(dims(1)-(WIDTH/2))
        tmp_block = popCornSoundShape(left-WIDTH/2:left+WIDTH/2);
        median_val = median(tmp_block(:));
        popCorn_median_big(left) = median_val;
    end
    
    %calculating difference between different smoothings
    popCorn_diff = popCornSoundShape;
    
    for iii = 1 : dims(1)
        popCorn_diff(iii) = popCorn_median_small(iii) - popCorn_median_big(iii);
    end
    
    %finding average of background microwave, started from 10 because 
    %data begins with more sound than usual background
    init_width = 20000;
    avg_background = max(popCorn_median_small(1000:init_width));
    heuristic = 500;
    kernels_popped = 0;
    next = 1;
    
    %determines if a kernel is popped
    for iii = 1 : dims(1)
        if (iii < next)
            continue;
        end
        if (popCorn_diff(iii) > 0)
            if (popCorn_median_small(iii) > avg_background)
                kernels_popped = kernels_popped + 1;
                next = next + heuristic;
                continue;
            end
        end
        next = next + 1;
    end
    
    
    fprintf('Kernels popped: %d\n', kernels_popped);

    %graph plotting
    %hold on;  
    %plot(popCornSoundShape, 'k');
    %plot(popCorn_median_small, 'r');
    %plot(popCorn_median_big, 'g');
    %plot(popCorn_diff, 'b');
    %hold off;
    % Change the size of the current figure:
    % gcf() stands for "get current figure()".
    %set( gcf(), 'Position', [100, 10, 1024, 768] );
    
    % Other things to do to a plot:
    %grid on;
    
    % Add a title:
    %title( 'Popcorn Popping in a Closed Microwave', 'FontSize', 20 );
    
    %xlabel( 'Time, in samples.  11,025 Samples per second.', 'FontSize', 18 );
    %ylabel( 'Sound Pressure (unknown units)', 'FontSize', 18 );

end
