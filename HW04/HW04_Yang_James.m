function HW04_Yang_James() 
    %read images and convert to hsv
    im_rgb = imread('IMG_0791_GYR_Apples.jpg');
    im_hsv = rgb2hsv(im_rgb);    
    
    %quantization of saturation channel
    quant = 64;
    im_sat = floor(im_hsv(:,:,2) *100/ quant) * quant;

    %quantization of hue channel
    quant = 4
    im_hue = floor(im_hsv(:,:,1) * 100 / quant) * quant;
    
    %using logical operator to find similarities and combine
    im_combined = im_sat | ~im_hue;

    %display
    imshow(im_combined);
    temp_title = sprintf('Quantization = %3d', quant);
    title( temp_title, 'FontSize', 18); 
    


end