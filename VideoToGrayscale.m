clc;
clear all;
close all;
% change the relative path accordingly
% relPath = 'C:\Users\lenovo\Documents\MATLAB\Video-Codec';
vidPath = fullfile('C:\Users\lenovo\Documents\MATLAB\Video-Codec\sample video\sample.mp4');
if ~exist(vidPath, 'file')
   warning ("'%s' doesn't exist, running demo VideoWriter first...", vidPath);
end
vid = VideoReader(vidPath);
vidX = vid.Height;
vidY = vid.Width;
numFrames = vid.NumFrames;

outputPath = 'C:\Users\lenovo\Documents\MATLAB\Video-Codec\grayscale';
for frame = 1:numFrames
    outputFileName = sprintf('Frame %4.4d.png', frame);
    outputFullPath = fullfile(outputPath, outputFileName);
    
    curFrame = read(vid, frame);
    imGray = rgb2gray(curFrame);
    imwrite(imGray, outputFullPath, 'png');
    
end 

