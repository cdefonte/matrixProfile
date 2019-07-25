
clear
clc

cd '...\en_625_620\project\featureList'

% Load data as table
load('dualHist_0.mat');
load('dualHist_1.mat');

% Convert table to matrix
dualHistMat_0 = dualHist_0{:,:};
dualHistMat_1 = dualHist_1{:,:};
dualHistMat_single_0 = dualHist_0{1,:};
dualHistMat_single_1 = dualHist_1{1,:};

% Transpose data
dualHistMat_0 = transpose(dualHistMat_0);
dualHistMat_1 = transpose(dualHistMat_1);
dualHistMat_single_0 = transpose(dualHistMat_single_0);
dualHistMat_single_1 = transpose(dualHistMat_single_1);


% Melt columns
dualHistMat_0 = reshape(dualHistMat_0,[],1);
dualHistMat_1 = reshape(dualHistMat_1,[],1);
dualHistMat_single_0 = reshape(dualHistMat_single_0,[],1);
dualHistMat_single_1 = reshape(dualHistMat_single_1,[],1);

% Generate spectrograms
spectrogram(dualHistMat_0)
spectrogram(dualHistMat_1)
spectrogram(dualHistMat_single_0)
spectrogram(dualHistMat_single_1)

% Calculate max subsequence search length
maxDualHist = length(dualHistMat_0)/20;
dim = 55;
custom = 99;

% Perform Matrix Profile SCRIMP++, window=max, Noisy
[matrixProfile_dualHistNoisy_0,profileIndex_dualHistNoisy_0,motifIdxs_dualHistNoisy_0,discordIdx_dualHistNoisy_0] = matrixProfileSCRIMP(dualHistMat_0,floor(maxDualHist));
[matrixProfile_dualHistNoisy_1,profileIndex_dualHistNoisy_1,motifIdxs_dualHistNoisy_1,discordIdx_dualHistNoisy_1] = matrixProfileSCRIMP(dualHistMat_1,floor(maxDualHist));
[matrixProfile_dualHist_single_0,profileIndex_dualHist_single_0,motifIdxs_dualHist_single_0,discordIdx_dualHist_single_0] = matrixProfileSCRIMP(dualHistMat_0,9);
[matrixProfile_dualHist_single_1,profileIndex_dualHist_single_1,motifIdxs_dualHist_single_1,discordIdx_dualHist_single_1] = matrixProfileSCRIMP(dualHistMat_1,9);

% Perform Matrix Profile SCRIMP++, window=max, Smooth
[matrixProfile_dualHist_0,profileIndex_dualHist_0,motifIdxs_dualHist_0,discordIdx_dualHist_0] = matrixProfileSCRIMP(smooth(dualHistMat_0,dim),floor(maxDualHist));
[matrixProfile_dualHist_1,profileIndex_dualHist_1,motifIdxs_dualHist_1,discordIdx_dualHist_1] = matrixProfileSCRIMP(smooth(dualHistMat_1,dim),floor(maxDualHist));

% Perform Matrix Profile SCRIMP++, window=custom, Smooth
[matrixProfile_dualHist_custom_0,profileIndex_dualHist_custom_0,motifIdxs_dualHist_custom_0,discordIdx_dualHist_custom_0] = matrixProfileSCRIMP(smooth(dualHistMat_0,dim),custom);
[matrixProfile_dualHist_custom_1,profileIndex_dualHist_custom_1,motifIdxs_dualHist_custom_1,discordIdx_dualHist_custom_1] = matrixProfileSCRIMP(smooth(dualHistMat_0,dim),custom);

% Generate plots of Matrix Profiles
compPlot = figure('Name', 'Matrix Profiles, Dual Histograms');
ax1 = axes('Parent', compPlot);
hold(ax1, 'on');
plot(ax1, matrixProfile_dualHist_0, 'Color', 'black');
plot(ax1, matrixProfile_dualHist_1, 'Color', 'blue');
title(ax1, 'Matrix Profiles SCRIMP++, Dual Histograms');
legend('Untampered Images', 'Tampered Images');
hold(ax1, 'off');

subplot(2,1,1); % top subplot
y1 = matrixProfile_globalHist_0;
plot(y1, 'Color', 'black')
title('Matrix Profile SCRIMP++, Dual Histogram, Untampered')

subplot(2,1,2); % bottom subplot
y2 = matrixProfile_dualHist_1;
plot(y2, 'Color', 'blue')
title('Matrix Profile SCRIMP++, Dual Histogram, Tampered')
hold off








