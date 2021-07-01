close all;
clear;
clc;

frameI = imread('./grayscale/Frame 0001.png');
frameIPlus =  imread('./grayscale/Frame 0010.png');
[x,y, dx, dy]= MotionEstimation(frameI, frameIPlus,8, 8);