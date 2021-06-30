clear
close all;
clc;
% the directory where our frames are located
imageFiles = dir('grayscale/*.png');
nImages = length(imageFiles);
imageDir = imageFiles.folder;
for i=1:nImages
    curImageName = [imageDir '\' imageFiles(i).name];
    curImage = imread(curImageName);
    curImage = imresize(curImage, [512, 512]);
%     caused an error
%     curImageDouble = im2double(curImage);
% Dimensions for DCT blocksize
    A=8;
    B=8;
    [imX, imY] = size(curImage);
    curDct=ComputeDCT(curImage, A, B, imX, imY);
    curZigZag = ComputeZigZag(curDct, A, B, imX, imY, 8, 8);
    curRunLength = RunLength(curZigZag, A, B, imX, imY);
%     saves runlength in .mat format
    save(['runlength/' imageFiles(i).name '.mat'], 'curRunLength');
end