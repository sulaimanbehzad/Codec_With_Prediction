function paddedImg = PadImage(img,padding)
   heightSize = size(img,1); %height of original image (num rows)
   widthSize = size(img,2); %width of original image (num cols)

    %Pad image with zeros
     paddedImg = zeros(heightSize+(padding*2),widthSize+(padding*2)); %Add a spare column left and right of image and a spare row on top and bottom of the image
        for i = (padding+1): (heightSize+padding) % for each row in the original image
            for j = (padding+1): (widthSize+padding)  % for each column in the original image
                 pixelTransferred = img(i-padding,j-padding);%Pixel transferred from original image to padded image
                 paddedImg(i,j) = pixelTransferred;  %Store pixel in new padded image 
            end
        end
     %end of pad images with zeros
     paddedImg = uint8(paddedImg);
end