

clear
clc

cd 'C:\Users\cayle\OneDrive\Documents\cdefonte\academic\su2019\en_625_620\project\featureList'

% Load data as table
load('markov_0.mat');
load('markov_1.mat');

% Convert table to matrix
markovMat_0 = markov_0{:,:};
markovMat_1 = markov_1{:,:};
markovMat_single_0 = markov_0{1,:};
markovMat_single_1 = markov_1{1,:};

% Transpose data
markovMat_0 = transpose(markovMat_0);
markovMat_1 = transpose(markovMat_1);
markovMat_single_0 = transpose(markovMat_single_0);
markovMat_single_1 = transpose(markovMat_single_1);

% Melt columns
markovMat_0 = reshape(markovMat_0,[],1);
markovMat_1 = reshape(markovMat_1,[],1);
markovMat_single_0 = reshape(markovMat_single_0,[],1);
markovMat_single_1 = reshape(markovMat_single_1,[],1);

markovMat_0 = markovMat_0(100:7000);
markovMat_1 = markovMat_1(100:7000);

% Generate spectrograms
%spectrogram(markovMat_0)
%spectrogram(markovMat_1)
%spectrogram(markovMat_single_0)
%spectrogram(markovMat_single_1)

% Calculate max subsequence search length
maxMarkov = length(markovMat_0)/20;
dim = 55;
custom = 81;

% Perform Matrix Profile SCRIMP++, window=max, Noisy
[matrixProfile_markovNoisy_0,profileIndex_markovNoisy_0,motifIdxscoOccur_markovNoisy_0,discordIdx_markovNoisy_0] = matrixProfileSCRIMP(markovMat_0,floor(maxMarkov));
[matrixProfile_markovNoisy_1,profileIndex_markovNoisy_1,motifIdxscoOccur_markovNoisy_1,discordIdx_markovNoisy_1] = matrixProfileSCRIMP(markovMat_1,floor(maxMarkov));
[matrixProfile_markovNoisy_single_0,profileIndex_markovNoisy_single_0,motifIdxscoOccur_markovNoisy_single_0,discordIdx_markovNoisy_single_0] = matrixProfileSCRIMP(markovMat_single_0,9);
[matrixProfile_markovNoisy_single_1,profileIndex_markovNoisy_single_1,motifIdxscoOccur_markovNoisy_single_1,discordIdx_markovNoisy_single_1] = matrixProfileSCRIMP(markovMat_single_1,9);

% Perform Matrix Profile SCRIMP++, window=max, Smooth
[matrixProfile_markov_0,profileIndex_markov_0,motifIdxscoOccur_markov_0,discordIdx_markov_0] = matrixProfileSCRIMP(smooth(markovMat_0,dim),floor(maxMarkov));
[matrixProfile_markov_1,profileIndex_markov_1,motifIdxscoOccur_markov_1,discordIdx_markov_1] = matrixProfileSCRIMP(smooth(markovMat_1,dim),floor(maxMarkov));

% Perform Matrix Profile SCRIMP++, window=custom, Smooth
[matrixProfile_markov_custom_0,profileIndex_markov_custom_0,motifIdxscoOccur_markov_custom_0,discordIdx_markov_custom_0] = matrixProfileSCRIMP(smooth(markovMat_0,dim),custom);
[matrixProfile_markov_custom_1,profileIndex_markov_custom_1,motifIdxscoOccur_markov_custom_1,discordIdx_markov_custom_1] = matrixProfileSCRIMP(smooth(markovMat_1,dim),custom);

% Generate plots of Matrix Profiles
compPlot = figure('Name', 'Matrix Profiles, Markov Features');
ax1 = axes('Parent', compPlot);
hold(ax1, 'on');
%ylim([0 3])
%xlim([100 6500])
plot(ax1, matrixProfile_markovNoisy_single_0, 'Color', 'black');
plot(ax1, matrixProfile_markovNoisy_single_1, 'Color', 'blue');
title(ax1, 'Matrix Profiles SCRIMP++, Markov Features');
legend('Untampered Images', 'Tampered Images');
hold(ax1, 'off');

subplot(2,1,1); % top subplot
y1 = matrixProfile_markovNoisy_single_0;
plot(y1, 'Color', 'black')
%ylim([0 3])
%xlim([100 6500])
title('Matrix Profile SCRIMP++, Markov Features, Untampered')

subplot(2,1,2); % bottom subplot
y2 =  matrixProfile_markovNoisy_single_1;
plot(y2, 'Color', 'blue')
%ylim([0 3])
%xlim([100 6500])
title('Matrix Profile SCRIMP++, Markov Features, Tampered')
hold off



