close all;
clear;
clc;

frameI = imread('./grayscale/Frame 0001.png');
frameI = imresize(frameI, [512, 512]);

A=8;
B=8;
N=8;
W=2*N;
curPaddedImage = double(padarray(frameI, [W/2, W/2], 'replicate'));

[imX, imY] = size(frameI);

for j=1:N:imX
    for k=1:N:imY
        blockI = IntraPrediction(curPaddedImage,j,k,N);
        iFrame(j:j+N-1, k:k+N-1)=blockI;
    end
end
figure,
imshow(uint8(iFrame));title('intra image');
% -------------go
curDct=ComputeDCT(iFrame, A, B, imX, imY);
curZigZag = ComputeZigZag(curDct, A, B, imX, imY, 8, 8);
curRunLength = RunLength(curZigZag, A, B, imX, imY);
% -------------back
curZigZag = ComputeRunLengthR(curRunLength, A, B, imX, imY, 8);
curTransformInv = ComputeZigZagR(curZigZag,A,B,imX,imY,8,8);
curRecreatedImage = ComputeDCTR(curTransformInv,A,B,imX,imY);
% curRecreatedImage = curRecreatedImage/max(max(curRecreatedImage));
curPaddedImage = double(padarray(curRecreatedImage, [W/2, W/2], 'replicate'));

for j=1:N:imX
    for k=1:N:imY
        blockI = IntraPredictionR(curPaddedImage,j,k,N);
        iR(j:j+N-1, k:k+N-1)=blockI;
    end
end
figure,
imshow(uint8(iR));title('reverse intra image');
