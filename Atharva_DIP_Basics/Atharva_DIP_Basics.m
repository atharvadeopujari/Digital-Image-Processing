% Created by Atharva
clc;
clear all;
close all;

%Image Read
I = imread('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlrZqTCInyg6RfYC7Ape20o-EWP1EN_A8fOA&s');

% Initializing colour matrices
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

% Averaging for grey scale
Ig=((R+G+B)/3);

% Setting threshold
count = sum(Ig(:));
threshold=count/(250*250);

% Giving value 1 for above and 0 for below value of threshold
Ib = Ig > threshold;

% Taking only last matrix and changing other 1,2 all values zeroes
% Blue
Iblue=I;
Iblue(:,:,1)=0;
Iblue(:,:,2)=0;

% Red
Ired=I;
Ired(:,:,2)=0;
Ired(:,:,3)=0;

% Green
Igreen=I;
Igreen(:,:,1)=0;
Igreen(:,:,3)=0;

%Plotting
subplot(2,3,1);
imshow(I);
title("Original Image");

subplot(2,3,2);
imshow(Ig);
title("Grayscale Image");

subplot(2,3,3);
imshow(Ib);
title("B&W Image");

subplot(2,3,4);
imshow(Ired);
title("Red Image");

subplot(2,3,5);
imshow(Igreen);
title("Green Image");

subplot(2,3,6);
imshow(Iblue);
title("Blue Image");