clear
close all;
clc;
% the directory where our frames are located
imageFiles = dir('grayscale/*.png');
nImages = length(imageFiles);
imageDir = imageFiles.folder;
% initialize frames
iFrame=uint8(zeros(528,528));
pFrame=uint8(zeros(528,528));
for cnt=1:nImages
%     Dimensions for DCT blocksize
    A=8;
    B=8;
    N=8;
    W=2*N;
%     reading image
    curImageName = [imageDir '\' imageFiles(cnt).name];
    curImage = imread(curImageName);
    curImage = imresize(curImage, [512, 512]);
%     image dimensions
    [imX, imY] = size(curImage);
%     pad image
    curPaddedImage = double(padarray(curImage, [W/2, W/2], 'replicate'));
%     caused an error
%     curImageDouble = im2double(curImage);
    
    if cnt == 1 || (mod(cnt,5) == 0)
        for j=1:N:imX
            for k=1:N:imY
                blockI = IntraPrediction(curPaddedImage,j,k,N);
                iFrame(j:j+N-1, k:k+N-1)=blockI;
            end
        end
%         iFrame = IntraPrediction(curImage,imX,imY,N);
        curDct=ComputeDCT(iFrame, A, B, imX, imY);
        curZigZag = ComputeZigZag(curDct, A, B, imX, imY, 8, 8);
        curRunLength = RunLength(curZigZag, A, B, imX, imY);
        save(['runlength/iFrames/' imageFiles(cnt).name '.mat'], 'curRunLength');
    else
        for j=1:N:imX
            for k=1:N:imY
                [blockP,pred_err]=MotionEstimation(iFrame,uint8(curPaddedImage),j,k,N);
%                 recons_p = MotionEstimationR(iFrame,uint8(blockP),pred_err,j,k,N);
                pFrame(j:j+N-1, k:k+N-1)=blockP;
            end
        end
%         [pFrame,pred_err]=MotionEstimation(iFrame,curImage,imX,imY,N);
        curDct=ComputeDCT(pFrame, A, B, imX, imY);
        curZigZag = ComputeZigZag(curDct, A, B, imX, imY, 8, 8);
        curRunLength = RunLength(curZigZag, A, B, imX, imY);
        save(['runlength/pFrames/' imageFiles(cnt).name '.mat'], 'curRunLength');
    end
end