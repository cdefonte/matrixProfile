
clear
clc

cd 'C:\Users\cayle\OneDrive\Documents\cdefonte\academic\su2019\en_625_620\project\featureList'

% Load data as table
load('variation_0.mat');
load('variation_1.mat');

% Convert table to matrix
variationMat_0 = variation_0{:,:};
variationMat_1 = variation_1{:,:};

% Transpose data
variationMat_0 = transpose(variationMat_0);
variationMat_1 = transpose(variationMat_1);

% Melt columns
variationMat_0 = reshape(variationMat_0,[],1);
variationMat_1 = reshape(variationMat_1,[],1);

% Generate spectrograms
spectrogram(variationMat_0)
spectrogram(variationMat_1)

% Calculate max subsequence search length
maxVar = length(variationMat_0)/20;
dim = 55;