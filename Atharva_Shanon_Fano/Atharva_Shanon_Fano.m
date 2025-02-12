% Created by Atharva Deopujari
clc; 
clear; 
close all;

% Read and convert the image to grayscale
img = imread('https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg'); % Load a sample image
img = double(img); % Convert to double for processing

% Define all possible grayscale pixel values (0 to 255)
pixel_values = (0:255)';

% Get total number of pixels
total_pixels = numel(img);

% Compute probabilities for all 256 grayscale values
probabilities = arrayfun(@(x) sum(img(:) == x), pixel_values) / total_pixels;

% Sort probabilities in descending order, keeping track of pixel values
[probabilities, sort_idx] = sort(probabilities, 'descend');
pixel_values = pixel_values(sort_idx); % Reorder pixel values accordingly

% Initialize codes as empty strings
codes = repmat({''}, size(probabilities));

% Call Shannon-Fano Encoding function and get updated codes
codes = shannon_fano(1, length(probabilities), probabilities, codes);

% Create a dictionary for encoding
dict = containers.Map(pixel_values, codes);

% Display Shannon-Fano Codes with probabilities for ALL 256 pixel values
disp('Pixel Value -> Probability -> Shannon-Fano Code:');
for i = 1:length(pixel_values)
    fprintf('%3d -> %.6f -> %s\n', pixel_values(i), probabilities(i), codes{i});
end

% Shannon-Fano Encoding Function (Recursive) - Now returns updated codes
function codes = shannon_fano(start_idx, end_idx, probabilities, codes)
    if start_idx >= end_idx
        return;
    end
    
    % Find partition index where sum of probabilities is nearly equal
    total_sum = sum(probabilities(start_idx:end_idx));
    cum_sum = 0;
    split_idx = start_idx;
    
    for i = start_idx:end_idx
        cum_sum = cum_sum + probabilities(i);
        if cum_sum >= total_sum / 2
            split_idx = i;
            break;
        end
    end

    % Assign '0' to the first subset and '1' to the second subset
    for i = start_idx:split_idx
        codes{i} = strcat(codes{i}, '0');
    end
    for i = split_idx+1:end_idx
        codes{i} = strcat(codes{i}, '1');
    end

    % Recursively encode the two subsets
    codes = shannon_fano(start_idx, split_idx, probabilities, codes);
    codes = shannon_fano(split_idx+1, end_idx, probabilities, codes);
end