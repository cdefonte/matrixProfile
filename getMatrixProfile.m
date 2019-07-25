
clear
clc

cd '...\en_625_620\project\featureList'

% Load data as table
load('globalHist_0.mat');
load('globalHist_1.mat');

load('dualHist_0.mat');
load('dualHist_1.mat');

load('ACHist_0.mat');
load('ACHist_1.mat');

load('coOccurence_0.mat');
load('coOccurence_1.mat');

load('markov_0.mat');
load('markov_1.mat');

load('variation_0.mat');
load('variation_1.mat');

% Convert table to matrix
globalHistMat_0 = globalHist_0{:,:};
globalHistMat_1 = globalHist_1{:,:};

dualHistMat_0 = dualHist_0{:,:};
dualHistMat_1 = dualHist_1{:,:};

ACHistMat_0 = ACHist_0{:,:};
ACHistMat_1 = ACHist_1{:,:};

coOccurenceMat_0 = coOccurence_0{:,:};
coOccurenceMat_1 = coOccurence_1{:,:};

markovMat_0 = markov_0{:,:};
markovMat_1 = markov_1{:,:};

variationMat_0 = variation_0{:,:};
variationMat_1 = variation_1{:,:};

% Transpose data
globalHistMat_0 = transpose(globalHistMat_0);
globalHistMat_1 = transpose(globalHistMat_1);

dualHistMat_0 = transpose(dualHistMat_0);
dualHistMat_1 = transpose(dualHistMat_1);

ACHistMat_0 = transpose(ACHistMat_0);
ACHistMat_1 = transpose(ACHistMat_1);

coOccurenceMat_0 = transpose(coOccurenceMat_0);
coOccurenceMat_1 = transpose(coOccurenceMat_1);

markovMat_0 = transpose(markovMat_0);
markovMat_1 = transpose(markovMat_1);

variationMat_0 = transpose(variationMat_0);
variationMat_1 = transpose(variationMat_1);

% Melt columns
globalHistMat_0 = reshape(globalHistMat_0,[],1);
globalHistMat_1 = reshape(globalHistMat_1,[],1);

dualHistMat_0 = reshape(dualHistMat_0,[],1);
dualHistMat_1 = reshape(dualHistMat_1,[],1);

ACHistMat_0 = reshape(ACHistMat_0,[],1);
ACHistMat_1 = reshape(ACHistMat_1,[],1);

coOccurenceMat_0 = reshape(coOccurenceMat_0,[],1);
coOccurenceMat_1 = reshape(coOccurenceMat_1,[],1);

markovMat_0 = reshape(markovMat_0,[],1);
markovMat_1 = reshape(markovMat_1,[],1);

variationMat_0 = reshape(variationMat_0,[],1);
variationMat_1 = reshape(variationMat_1,[],1);

% Generate spectrograms
spectrogram(globalHistMat_0)
spectrogram(globalHistMat_1)
spectrogram(dualHistMat_0)
spectrogram(dualHistMat_1)
spectrogram(ACHistMat_0)
spectrogram(ACHistMat_1)
spectrogram(coOccurenceMat_0)
spectrogram(coOccurenceMat_1)
spectrogram(markovMat_0)
spectrogram(markovMat_1)
spectrogram(variationMat_0)
spectrogram(variationMat_1)

% Calculate max subsequence search length
maxGlobHist = length(globalHistMat_0)/20;
maxDualHist = length(dualHistMat_0)/20;
maxACHist = length(ACHistMat_0)/20;
maxCoOccur = length(coOccurenceMat_0)/20;
maxMarkov = length(markovMat_0)/20;
maxVar = length(variationMat_0)/20;
dim = 55;

% Custom functional dimensions
custom_globalHist = 11;
custom_ACHist = 55;
custom_dualHist = 99;
custom_coOccur = 25;
custom_markov = 81;

% Perform Matrix Profile SCRIMP++, window=max, Noisy
[matrixProfile_globalHistNoisy_0,profileIndex_globalHistNoisy_0,motifIdxs_globalHistNoisy_0,discordIdx_globalHistNoisy_0] = matrixProfileSCRIMP(globalHistMat_0,floor(maxGlobHist));
[matrixProfile_globalHistNoisy_1,profileIndex_globalHistNoisy_1,motifIdxs_globalHistNoisy_1,discordIdx_globalHistNoisy_1] = matrixProfileSCRIMP(globalHistMat_1,floor(maxGlobHist));

[matrixProfile_dualHistNoisy_0,profileIndex_dualHistNoisy_0,motifIdxs_dualHistNoisy_0,discordIdx_dualHistNoisy_0] = matrixProfileSCRIMP(dualHistMat_0,floor(maxDualHist));
[matrixProfile_dualHistNoisy_1,profileIndex_dualHistNoisy_1,motifIdxs_dualHistNoisy_1,discordIdx_dualHistNoisy_1] = matrixProfileSCRIMP(dualHistMat_1,floor(maxDualHist));

[matrixProfile_ACHistNoisy_0,profileIndex_ACHistNoisy_0,motifIdxs_ACHistNoisy_0,discordIdx_ACHistNoisy_0] = matrixProfileSCRIMP(ACHistMat_0,floor(maxACHist));
[matrixProfile_ACHistNoisy_1,profileIndex_ACHistNoisy_1,motifIdxs_ACHistNoisy_1,discordIdx_ACHistNoisy_1] = matrixProfileSCRIMP(ACHistMat_1,floor(maxACHist));

[matrixProfile_coOccurNoisy_0,profileIndex_coOccurNoisy_0,motifIdxs_coOccurNoisy_0,discordIdx_coOccurNoisy_0] = matrixProfileSCRIMP(coOccurenceMat_0,floor(maxCoOccur));
[matrixProfile_coOccurNoisy_1,profileIndex_coOccurNoisy_1,motifIdxs_coOccurNoisy_1,discordIdx_coOccurNoisy_1] = matrixProfileSCRIMP(coOccurenceMat_1,floor(maxCoOccur));

[matrixProfile_markovNoisy_0,profileIndex_markovNoisy_0,motifIdxscoOccur_markovNoisy_0,discordIdx_markovNoisy_0] = matrixProfileSCRIMP(markovMat_0,floor(maxMarkov));
[matrixProfile_markovNoisy_1,profileIndex_markovNoisy_1,motifIdxscoOccur_markovNoisy_1,discordIdx_markovNoisy_1] = matrixProfileSCRIMP(markovMat_1,floor(maxMarkov));

% Perform Matrix Profile SCRIMP++, window=max, Smooth
[matrixProfile_globalHist_0,profileIndex_globalHist_0,motifIdxs_globalHist_0,discordIdx_globalHist_0] = matrixProfileSCRIMP(smooth(globalHistMat_0,dim),floor(maxGlobHist));
[matrixProfile_globalHist_1,profileIndex_globalHist_1,motifIdxs_globalHist_1,discordIdx_globalHist_1] = matrixProfileSCRIMP(smooth(globalHistMat_1,dim),floor(maxGlobHist));

[matrixProfile_dualHist_0,profileIndex_dualHist_0,motifIdxs_dualHist_0,discordIdx_dualHist_0] = matrixProfileSCRIMP(smooth(dualHistMat_0,dim),floor(maxDualHist));
[matrixProfile_dualHist_1,profileIndex_dualHist_1,motifIdxs_dualHist_1,discordIdx_dualHist_1] = matrixProfileSCRIMP(smooth(dualHistMat_1,dim),floor(maxDualHist));

[matrixProfile_ACHist_0,profileIndex_ACHist_0,motifIdxs_ACHist_0,discordIdx_ACHist_0] = matrixProfileSCRIMP(smooth(ACHistMat_0,dim),floor(maxACHist));
[matrixProfile_ACHist_1,profileIndex_ACHist_1,motifIdxs_ACHist_1,discordIdx_ACHist_1] = matrixProfileSCRIMP(smooth(ACHistMat_1,dim),floor(maxACHist));

[matrixProfile_coOccur_0,profileIndex_coOccur_0,motifIdxs_coOccur_0,discordIdx_coOccur_0] = matrixProfileSCRIMP(smooth(coOccurenceMat_0,dim),floor(maxCoOccur));
[matrixProfile_coOccur_1,profileIndex_coOccur_1,motifIdxs_coOccur_1,discordIdx_coOccur_1] = matrixProfileSCRIMP(smooth(coOccurenceMat_1,dim),floor(maxCoOccur));

[matrixProfile_markov_0,profileIndex_markov_0,motifIdxscoOccur_markov_0,discordIdx_markov_0] = matrixProfileSCRIMP(smooth(markovMat_0,dim),floor(maxMarkov));
[matrixProfile_markov_1,profileIndex_markov_1,motifIdxscoOccur_markov_1,discordIdx_markov_1] = matrixProfileSCRIMP(smooth(markovMat_1,dim),floor(maxMarkov));

% Perform Matrix Profile SCRIMP++, window=custom, Smooth
[matrixProfile_globalHist_custom_0,profileIndex_custom_globalHist_0,motifIdxs_custom_globalHist_0,discordIdx_custom_globalHist_0] = matrixProfileSCRIMP(smooth(globalHistMat_0,dim),custom_globalHist);
[matrixProfile_globalHist_custom_1,profileIndex_custom_globalHist_1,motifIdxs_custom_globalHist_1,discordIdx_custom_globalHist_1] = matrixProfileSCRIMP(smooth(globalHistMat_1,dim),custom_globalHist);

[matrixProfile_dualHist_custom_0,profileIndex_dualHist_custom_0,motifIdxs_dualHist_custom_0,discordIdx_dualHist_custom_0] = matrixProfileSCRIMP(smooth(dualHistMat_0,dim),custom_dualHist);
[matrixProfile_dualHist_custom_1,profileIndex_dualHist_custom_1,motifIdxs_dualHist_custom_1,discordIdx_dualHist_custom_1] = matrixProfileSCRIMP(smooth(dualHistMat_1,dim),custom_dualHist);

[matrixProfile_ACHist_custom_0,profileIndex_ACHist_custom_0,motifIdxs_ACHist_custom_0,discordIdx_ACHist_custom_0] = matrixProfileSCRIMP(smooth(ACHistMat_0,dim),custom_ACHist);
[matrixProfile_ACHist_custom_1,profileIndex_ACHist_custom_1,motifIdxs_ACHist_custom_1,discordIdx_ACHist_custom_1] = matrixProfileSCRIMP(smooth(ACHistMat_1,dim),custom_ACHist);

[matrixProfile_coOccur_custom_0,profileIndex_coOccur_custom_0,motifIdxs_coOccur_custom_0,discordIdx_coOccur_custom_0] = matrixProfileSCRIMP(smooth(coOccurenceMat_0,dim),custom_coOccur);
[matrixProfile_coOccur_custom_1,profileIndex_coOccur_custom_1,motifIdxs_coOccur_custom_1,discordIdx_coOccur_custom_1] = matrixProfileSCRIMP(smooth(coOccurenceMat_1,dim),custom_coOccur);

[matrixProfile_markov_custom_0,profileIndex_markov_custom_0,motifIdxscoOccur_markov_custom_0,discordIdx_markov_custom_0] = matrixProfileSCRIMP(smooth(markovMat_0,dim),custom_markov);
[matrixProfile_markov_custom_1,profileIndex_markov_custom_1,motifIdxscoOccur_markov_custom_1,discordIdx_markov_custom_1] = matrixProfileSCRIMP(smooth(markovMat_1,dim),custom_markov);










