
clear
clc

cd '...\en_625_620\project\featureList'

% Load data as table
load('ACHist_0.mat');
load('ACHist_1.mat');

% Convert table to matrix
ACHistMat_0 = ACHist_0{:,:};
ACHistMat_1 = ACHist_1{:,:};
ACHistMat_single_0 = ACHist_0{1,:};
ACHistMat_single_1 = ACHist_1{1,:};

% Transpose data
ACHistMat_0 = transpose(ACHistMat_0);
ACHistMat_1 = transpose(ACHistMat_1);
ACHistMat_single_0 = transpose(ACHistMat_single_0);
ACHistMat_single_1 = transpose(ACHistMat_single_1);

% Melt columns
ACHistMat_0 = reshape(ACHistMat_0,[],1);
ACHistMat_1 = reshape(ACHistMat_1,[],1);
ACHistMat_single_0 = reshape(ACHistMat_single_0,[],1);
ACHistMat_single_1 = reshape(ACHistMat_single_1,[],1);

% Generate spectrograms
spectrogram(ACHistMat_0)
spectrogram(ACHistMat_1)
spectrogram(ACHistMat_single_0)
spectrogram(ACHistMat_single_1)

% Calculate max subsequence search length
maxACHist = length(ACHistMat_0)/20;
custom = 55;
dim = 55;

% Perform Matrix Profile SCRIMP++, window=max, Noisy
[matrixProfile_ACHistNoisy_0,profileIndex_ACHistNoisy_0,motifIdxs_ACHistNoisy_0,discordIdx_ACHistNoisy_0] = matrixProfileSCRIMP(ACHistMat_0,floor(maxACHist));
[matrixProfile_ACHistNoisy_1,profileIndex_ACHistNoisy_1,motifIdxs_ACHistNoisy_1,discordIdx_ACHistNoisy_1] = matrixProfileSCRIMP(ACHistMat_1,floor(maxACHist));
[matrixProfile_ACHistNoisy_single_0,profileIndex_ACHistNoisy_single_0,motifIdxs_ACHistNoisy_single_0,discordIdx_ACHistNoisy_single_0] = matrixProfileSCRIMP(ACHistMat_single_0,5);
[matrixProfile_ACHistNoisy_single_1,profileIndex_ACHistNoisy_single_1,motifIdxs_ACHistNoisy_single_1,discordIdx_ACHistNoisy_single_1] = matrixProfileSCRIMP(ACHistMat_single_1,5);

% Perform Matrix Profile SCRIMP++, window=max, Smooth
[matrixProfile_ACHist_0,profileIndex_ACHist_0,motifIdxs_ACHist_0,discordIdx_ACHist_0] = matrixProfileSCRIMP(smooth(ACHistMat_0,dim),floor(maxACHist));
[matrixProfile_ACHist_1,profileIndex_ACHist_1,motifIdxs_ACHist_1,discordIdx_ACHist_1] = matrixProfileSCRIMP(smooth(ACHistMat_1,dim),floor(maxACHist));

% Perform Matrix Profile SCRIMP++, window=custom, Smooth
[matrixProfile_ACHist_custom_0,profileIndex_ACHist_custom_0,motifIdxs_ACHist_custom_0,discordIdx_ACHist_custom_0] = matrixProfileSCRIMP(smooth(ACHistMat_0,dim),custom);
[matrixProfile_ACHist_custom_1,profileIndex_ACHist_custom_1,motifIdxs_ACHist_custom_1,discordIdx_ACHist_custom_1] = matrixProfileSCRIMP(smooth(ACHistMat_1,dim),custom);

% Generate plots of Matrix Profiles
compPlot = figure('Name', 'Matrix Profiles, AC Histograms');
ax1 = axes('Parent', compPlot);
hold(ax1, 'on');
plot(ax1, matrixProfile_ACHist_0, 'Color', 'black');
plot(ax1, matrixProfile_ACHist_1, 'Color', 'blue');
title(ax1, 'Matrix Profiles SCRIMP++, AC Histograms');
legend('Untampered Images', 'Mixture Images');
hold(ax1, 'off');

subplot(2,1,1); % top subplot
y1 = matrixProfile_ACHist_0;
plot(y1, 'Color', 'black')
title('Matrix Profile SCRIMP++, AC Histogram, Untampered')

subplot(2,1,2); % bottom subplot
y2 = matrixProfile_ACHist_1;
plot(y2, 'Color', 'blue')
title('Matrix Profile SCRIMP++, AC Histogram, Tampered')









