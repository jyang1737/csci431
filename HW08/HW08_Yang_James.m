function HW08_Yang_James()

    addpath('Training_Data_for_Students\');
    file_names = dir('*.png');
    %
    for file_index = 1 : length(file_names)
        fprintf('name = %s\n', file_names(file_index).name);
        
        im = imread(file_names(file_index).name);

        %edge information to find the lines
        bw = edge(im(:,:,1));
        %Hough transform matrix with thetas and rhos
        [H,T,R] = hough(bw);
        
        %Find the 4 highest peaks, for the four lines
        P = houghpeaks(H,4,'Threshold',0);
        
        %find the lines given all the previous information 
        %and connect the line segments that are far apart.
        lines = houghlines(bw,T,R,P,'FillGap', 1000);
        imshow(im), hold on
        %plot lines over the original image
        %Original code from MatLab documentation
        for k = 1:length(lines)
            xy = [lines(k).point1; lines(k).point2];
            plot(xy(:,1),xy(:,2),'LineWidth',4,'Color','magenta');
        end
        hold off
        pause();
    end
        
end