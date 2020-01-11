function HW09_part1_Changing_K_only()
    im_mb = imread('HW_08_MacBeth_Regular.jpg');
    
    for x = 0:256
    
        [IND,map] = rgb2ind(im_mb,x,'nodither');
        imshow(IND);
        colormap(map);
        pause(0.1);
   
    end
end