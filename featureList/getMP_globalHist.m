

clear
clc

cd '...\en_625_620\project\featureList'

% Load data as table
load('globalHist_0.mat');
load('globalHist_1.mat');

% Convert table to matrix
globalHistMat_0 = globalHist_0{:,:};
globalHistMat_1 = globalHist_1{:,:};
globalHistMat_single_0 = globalHist_0{1,:};
globalHistMat_single_1 = globalHist_1{1,:};

% Transpose data
globalHistMat_0 = transpose(globalHistMat_0);
globalHistMat_1 = transpose(globalHistMat_1);
globalHistMat_single_0 = transpose(globalHistMat_single_0);
globalHistMat_single_1 = transpose(globalHistMat_single_1);

% Melt columns
globalHistMat_0 = reshape(globalHistMat_0,[],1);
globalHistMat_1 = reshape(globalHistMat_1,[],1);
globalHistMat_single_0 = reshape(globalHistMat_single_0,[],1);
globalHistMat_single_1 = reshape(globalHistMat_single_1,[],1);

% Generate spectrograms
spectrogram(globalHistMat_0)
spectrogram(globalHistMat_1)
spectrogram(globalHistMat_single_0)
spectrogram(globalHistMat_single_1)

% Calculate max subsequence search length
maxGlobHist = length(globalHistMat_0)/20;
dim = 55;
custom = 11;

% Perform Matrix Profile SCRIMP++, window=max, Noisy
[matrixProfile_globalHistNoisy_0,profileIndex_globalHistNoisy_0,motifIdxs_globalHistNoisy_0,discordIdx_globalHistNoisy_0] = matrixProfileSCRIMP(globalHistMat_0,floor(maxGlobHist));
[matrixProfile_globalHistNoisy_1,profileIndex_globalHistNoisy_1,motifIdxs_globalHistNoisy_1,discordIdx_globalHistNoisy_1] = matrixProfileSCRIMP(globalHistMat_1,floor(maxGlobHist));
[matrixProfile_globalHistNoisy_single_0,profileIndex_globalHistNoisy_single_0,motifIdxs_globalHistNoisy_single_0,discordIdx_globalHistNoisy_single_0] = matrixProfileSCRIMP(globalHistMat_single_0,4);
[matrixProfile_globalHistNoisy_single_1,profileIndex_globalHistNoisy_single_1,motifIdxs_globalHistNoisy_single_1,discordIdx_globalHistNoisy_single_1] = matrixProfileSCRIMP(globalHistMat_single_1,4);

% Perform Matrix Profile SCRIMP++, window=max, Smooth
[matrixProfile_globalHist_0,profileIndex_globalHist_0,motifIdxs_globalHist_0,discordIdx_globalHist_0] = matrixProfileSCRIMP(smooth(globalHistMat_0,dim),floor(maxGlobHist));
[matrixProfile_globalHist_1,profileIndex_globalHist_1,motifIdxs_globalHist_1,discordIdx_globalHist_1] = matrixProfileSCRIMP(smooth(globalHistMat_1,dim),floor(maxGlobHist));

% Perform Matrix Profile SCRIMP++, window=custom, Smooth
[matrixProfile_globalHist_custom_0,profileIndex_globalHist_custom_0,motifIdxs_globalHist_custom_0,discordIdx_globalHist_custom_0] = matrixProfileSCRIMP(smooth(globalHistMat_0,dim),custom);
[matrixProfile_globalHist_custom_1,profileIndex_globalHist_custom_1,motifIdxs_globalHist_custom_1,discordIdx_globalHist_custom_1] = matrixProfileSCRIMP(smooth(globalHistMat_1,dim),custom);

% Generate plots of Matrix Profiles
compPlot = figure('Name', 'Matrix Profiles, Global Histograms');
ax1 = axes('Parent', compPlot);
hold(ax1, 'on');
plot(ax1, matrixProfile_globalHist_0, 'Color', 'black');
plot(ax1, matrixProfile_globalHist_1, 'Color', 'blue');
title(ax1, 'Matrix Profiles SCRIMP++, Global Histograms');
legend('Untampered Images', 'Tampered Images');
hold(ax1, 'off');

subplot(2,1,1); % top subplot
y1 = matrixProfile_globalHist_0;
plot(y1, 'Color', 'black')
title('Matrix Profile SCRIMP++, Global Histogram, Untampered')

subplot(2,1,2); % bottom subplot
y2 = matrixProfile_globalHist_1;
plot(y2, 'Color', 'blue')
title('Matrix Profile SCRIMP++, Global Histogram, Tampered')
hold off










