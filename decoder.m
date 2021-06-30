clear;
close all;
clc;

encodedFiles = dir('runlength/*.mat');
nFiles = length(encodedFiles);
encodedDir = encodedFiles.folder;
for i=1:nFiles
%     Dimensions for DCT blocksize
    A=8;
    B=8;
%     Image dimesnsions
    imX=512;
    imY=512;
    curFileName = [encodedDir '\' encodedFiles(i).name];
    curRL = load(curFileName);
    curRL = curRL.curRunLength;
    curZigZag = ComputeRunLengthR(curRL, A, B, imX, imY, 8);
    curTransformInv = ComputeZigZagR(curZigZag,A,B,imX,imY,8,8);
    curRecreatedImage = ComputeDCTR(curTransformInv,A,B,imX,imY);
    curRecreatedImage = curRecreatedImage/max(max(curRecreatedImage));
    curRecreatedImage = im2uint8(curRecreatedImage);
%     figure, imshow(curRecreatedImage);
%   Write images
    outputPath = 'C:\Users\lenovo\Documents\MATLAB\Video-Codec\recreated';
    outputFileName = sprintf('Frame %4.4d.png', i);
    outputFullPath = fullfile(outputPath, outputFileName);
    imwrite(curRecreatedImage, outputFullPath, 'png');
%     curImage = imread(curImageName);
%     curImage = imresize(curImage, [512, 512]);
% %     change image to do
%     curImageDouble = im2double(curImage);
% % Dimensions for DCT blocksize
%     A=8;
%     B=8;
%     curDct=ComputeDCT(curImageDouble, A, B);
%     [imX, imY] = size(curImageDouble);
%     curZigZag = ComputeZigZag(curDct, A, B, imX, imY, 8, 10);
%     curRunLength = RunLength(curZigZag, A, B, imX, imY);
%     save(['runlength/' encodedFiles(i).name '.txt'], 'curRunLength');
%     fprintf(fileID, curRunLength);
%     disp(curRunLength)
%     images{i}=curImage;
end