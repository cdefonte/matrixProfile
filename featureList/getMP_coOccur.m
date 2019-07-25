
clear
clc

cd '...\en_625_620\project\featureList'

% Load data as table
load('coOccurence_0.mat');
load('coOccurence_1.mat');

% Convert table to matrix
coOccurenceMat_0 = coOccurence_0{:,:};
coOccurenceMat_1 = coOccurence_1{:,:};
coOccurenceMat_single_0 = coOccurence_0{1,:};
coOccurenceMat_single_1 = coOccurence_1{1,:};

% Transpose data
coOccurenceMat_0 = transpose(coOccurenceMat_0);
coOccurenceMat_1 = transpose(coOccurenceMat_1);
coOccurenceMat_single_0 = transpose(coOccurenceMat_single_0);
coOccurenceMat_single_1 = transpose(coOccurenceMat_single_1);

% Melt columns
coOccurenceMat_0 = reshape(coOccurenceMat_0,[],1);
coOccurenceMat_1 = reshape(coOccurenceMat_1,[],1);
coOccurenceMat_single_0 = reshape(coOccurenceMat_single_0,[],1);
coOccurenceMat_single_1 = reshape(coOccurenceMat_single_1,[],1);

% Generate spectrograms
spectrogram(coOccurenceMat_0)
spectrogram(coOccurenceMat_1)
spectrogram(coOccurenceMat_single_0)
spectrogram(coOccurenceMat_single_1)

% Calculate max subsequence search length
maxCoOccur = length(coOccurenceMat_0)/20;
dim = 55;
custom = 25;

% Perform Matrix Profile SCRIMP++, window=max, Noisy
[matrixProfile_coOccurNoisy_0,profileIndex_coOccurNoisy_0,motifIdxs_coOccurNoisy_0,discordIdx_coOccurNoisy_0] = matrixProfileSCRIMP(coOccurenceMat_0,floor(maxCoOccur));
[matrixProfile_coOccurNoisy_1,profileIndex_coOccurNoisy_1,motifIdxs_coOccurNoisy_1,discordIdx_coOccurNoisy_1] = matrixProfileSCRIMP(coOccurenceMat_1,floor(maxCoOccur));
[matrixProfile_coOccurNoisy_single_0,profileIndex_coOccurNoisy_single_0,motifIdxs_coOccurNoisy_single_0,discordIdx_coOccurNoisy_single_0] = matrixProfileSCRIMP(coOccurenceMat_single_0,5);
[matrixProfile_coOccurNoisy_single_1,profileIndex_coOccurNoisy_single_1,motifIdxs_coOccurNoisy_single_1,discordIdx_coOccurNoisy_single_1] = matrixProfileSCRIMP(coOccurenceMat_single_1,5);

% Perform Matrix Profile SCRIMP++, window=,max, Smooth
[matrixProfile_coOccur_0,profileIndex_coOccur_0,motifIdxs_coOccur_0,discordIdx_coOccur_0] = matrixProfileSCRIMP(smooth(coOccurenceMat_0,dim),floor(maxCoOccur));
[matrixProfile_coOccur_1,profileIndex_coOccur_1,motifIdxs_coOccur_1,discordIdx_coOccur_1] = matrixProfileSCRIMP(smooth(coOccurenceMat_1,dim),floor(maxCoOccur));

% Perform Matrix Profile SCRIMP++, window=custom, Smooth
[matrixProfile_coOccur_custom_0,profileIndex_coOccur_custom_0,motifIdxs_coOccur_custom_0,discordIdx_coOccur_custom_0] = matrixProfileSCRIMP(smooth(coOccurenceMat_0,dim),custom);
[matrixProfile_coOccur_custom_1,profileIndex_coOccur_custom_1,motifIdxs_coOccur_custom_1,discordIdx_coOccur_custom_1] = matrixProfileSCRIMP(smooth(coOccurenceMat_1,dim),custom);

% Generate plots of Matrix Profiles
compPlot = figure('Name', 'Matrix Profiles,Co-Occurrence');
ax1 = axes('Parent', compPlot);
hold(ax1, 'on');
plot(ax1, matrixProfile_coOccur_0, 'Color', 'black');
plot(ax1, matrixProfile_coOccur_1, 'Color', 'blue');
ylim([0 5])
xlim([30 2600])
title(ax1, 'Matrix Profiles SCRIMP++, Co-Occurrence');
legend('Untampered Images', 'Tampered Images');
hold(ax1, 'off');

subplot(2,1,1); % top subplot
y1 = matrixProfile_coOccur_0;
plot(y1, 'Color', 'black')
ylim([0 2])
xlim([0 2600])
title('Matrix Profile SCRIMP++, Co-Occurrence, Untampered')

subplot(2,1,2); % bottom subplot
y2 = matrixProfile_coOccur_1;
plot(y2, 'Color', 'blue')
ylim([0 2])
xlim([0 2600])
title('Matrix Profile SCRIMP++, Co-Occurrence, Tampered')
hold off








