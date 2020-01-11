
function HW01_Yang_James()
    %2. reads and resizes image, writes out to new file
    im = imread('me.jpg');
    im2 = imrotate(im, -90);
    im2 = imresize(im2, 0.5);
    imshow(im2);
    hold on;
    imwrite(im2, 'new_selfie.jpg');
    
    %3. draw square around eye
    %[x,y] = ginput();
    x = 190;
    y = 311;
    xpts = [x-30,x-30,x+30,x+30,x-30];
    ypts = [y-30,y+30,y+30,y-30,y-30]; 

    plot(xpts, ypts,'r');
    
    %4. draw circle around nose
    %[x2,y2] = ginput();
    x2 = 251;
    y2 = 385;
    angle = 0:pi/100:2*pi;
    xs = 40*cos(angle)+x2;
    ys = 40*sin(angle)+y2;
    
    plot(xs,ys,'r');
end