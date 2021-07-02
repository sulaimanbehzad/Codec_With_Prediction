clear;
close all;
clc;

encodedFiles = dir('runlength/*.mat');
nFiles = length(encodedFiles);
encodedDir = encodedFiles.folder;
% initialize decoded image
decodedImage=double(zeros(528,528));
for cnt=1:nFiles
%     Dimensions for DCT blocksize
    A=8;
    B=8;
    N=8;
    W=2*N;
%     Image dimesnsions
    imX=512;
    imY=512;
    curFileName = [encodedDir '\' encodedFiles(cnt).name];
    curRL = load(curFileName);
    
%     curRecreatedImage = im2uint8(curRecreatedImage);
    
    if  cnt==1 || (mod(cnt,5) == 0)
        curRL = curRL.curRunLength;
        curZigZag = ComputeRunLengthR(curRL, A, B, imX, imY, 8);
        curTransformInv = ComputeZigZagR(curZigZag,A,B,imX,imY,8,8);
        curRecreatedImage = ComputeDCTR(curTransformInv,A,B,imX,imY);
%         curRecreatedImage = curRecreatedImage/max(max(curRecreatedImage));
        curPaddedImage = double(padarray(curRecreatedImage, [W/2, W/2], 'replicate'));
        for j=1:N:imX
            for k=1:N:imY
                rBlockIntra = IntraPredictionR(curPaddedImage,j,k,N);
                decodedImage(j:j+N-1, k:k+N-1)=rBlockIntra;
            end
        end
    else
        for j=1:N:imX
            for k=1:N:imY
                pInfo = curRL.pInfo;
                recons_p = MotionEstimationR(double(curPaddedImage),pInfo(j,k).motion,pInfo(j,k).pred_err,j,k,N);
                decodedImage(j:j+N-1, k:k+N-1)=recons_p;
            end
        end
    end
    decodedImage = im2uint8(decodedImage);
%     figure, imshow(curRecreatedImage);
%   Write images
    outputPath = 'C:\Users\lenovo\Documents\MATLAB\Codec_With_Prediction\recreated\';
    outputFileName = sprintf('Frame %4.4d.png', cnt);
    outputFullPath = fullfile(outputPath, outputFileName);
    imwrite(decodedImage, outputFullPath, 'png');
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
cnt
end