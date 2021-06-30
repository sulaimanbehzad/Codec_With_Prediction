clear;
close all;
clc;
inputPath = 'C:\Users\lenovo\Documents\MATLAB\Video-Codec\recreated';
vidWriter = VideoWriter('RecreatedVideo');
vidWriter.FrameRate = 1;
% secsPerImage = 5;
open(vidWriter);


recreatedImages = dir('recreated/*.png');
nFiles = length(recreatedImages);
recDir = recreatedImages.folder;
images=cell(50,1);
for i=1:nFiles
    curFileName = [recDir '\' recreatedImages(i).name];
    images{i} = imread(curFileName);
end
for k=1:length(images)
    rgbImage = zeros(512, 512, 3);
    rgbImage(:,:,1)=images{k};
    rgbImage(:,:,2)=images{k};
    rgbImage(:,:,3)=images{k};
%     rgbImage = ind2rgb(images{k}, jet(256));
    frame = im2frame(uint8(rgbImage));
    writeVideo(vidWriter,frame);
end
close(vidWriter);

