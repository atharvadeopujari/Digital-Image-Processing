% Created by Atharva Deopujari
clear all;
close all;
clc;
% Read the image
img = imread('lena_color.tiff');

% Resizing the image to 512x512 if it's not already
img = imresize(img, [512 512]);

% Converting the image to grayscale
grayImg = im2gray(img);

% Performing single-level 2D DWT
[LL, LH, HL, HH] = dwt2(grayImg, 'haar');

% Displaying the original and all decomposed images
figure;
subplot(2,3,1), imshow(img), title('Original Image');
subplot(2,3,2), imshow(grayImg), title('Original Grayscale Image');
subplot(2,3,3), imshow(LL, []), title('LL - Approximation');
subplot(2,3,4), imshow(LH, []), title('LH - Horizontal Detail');
subplot(2,3,5), imshow(HL, []), title('HL - Vertical Detail');
subplot(2,3,6), imshow(HH, []), title('HH - Diagonal Detail');
