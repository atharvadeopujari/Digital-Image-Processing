% Created by Atharva Deopujari
% Read the input image
color_img = imread('https://thumbs.dreamstime.com/z/vinayagar-images-ai-hd-photo-2023-289916691.jpg');

% Convert the color image to grayscale
gray_img = rgb2gray(color_img);

% Display the original and grayscale images
figure;
subplot(1, 2, 1);
imshow(color_img);
title('Original Color Image');

subplot(1, 2, 2);
imshow(gray_img);
title('Grayscale Image');

% Ensure the grayscale image is in 8-bit format
gray_img = im2uint8(gray_img);

% Get the size of the image
[rows, cols] = size(gray_img);

% Perform bit-plane slicing
bit_planes = zeros(rows, cols, 8, 'uint8');
for k = 1:8
    bit_planes(:, :, k) = bitget(gray_img, k) * 2^(k-1);
end

% Display bit planes
figure;
for k = 1:8
    subplot(2, 4, k);
    imshow(bit_planes(:, :, k), []);
    title(['Bit Plane ', num2str(k)]);
end

% Set the LSB (1st bit plane) to 0
gray_img_modified = bitset(gray_img, 1, 0);

% Compare the original and modified images
figure;
subplot(1, 2, 1);
imshow(gray_img);
title('Original Grayscale Image');

subplot(1, 2, 2);
imshow(gray_img_modified);
title('Grayscale Image with LSB = 0');