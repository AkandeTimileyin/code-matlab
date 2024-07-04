% Load data (Example: MNIST dataset)
data = digitTrain4DArrayData; % Load a 4D array of image data

% Define the layers of the encoder
encoderLayers = [
    imageInputLayer([28 28 1], 'Name', 'input')
    convolution2dLayer(3, 16, 'Padding', 'same', 'Name', 'conv1')
    reluLayer('Name', 'relu1')
    maxPooling2dLayer(2, 'Stride', 2, 'Name', 'maxpool1')
    convolution2dLayer(3, 8, 'Padding', 'same', 'Name', 'conv2')
    reluLayer('Name', 'relu2')
    maxPooling2dLayer(2, 'Stride', 2, 'Name', 'maxpool2')
    ];

% Define the layers of the decoder
decoderLayers = [
    transposedConv2dLayer(3, 8, 'Stride', 2, 'Cropping', 'same', 'Name', 'deconv1')
    reluLayer('Name', 'relu3')
    transposedConv2dLayer(3, 16, 'Stride', 2, 'Cropping', 'same', 'Name', 'deconv2')
    reluLayer('Name', 'relu4')
    convolution2dLayer(3, 1, 'Padding', 'same', 'Name', 'conv3')
    ];

% Combine encoder and decoder into one network
layers = [
    encoderLayers
    decoderLayers
    regressionLayer('Name', 'output')
    ];

% Specify training options
options = trainingOptions('adam', ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 64, ...
    'Shuffle', 'every-epoch', ...
    'Verbose', false, ...
    'Plots', 'training-progress');

% Train the network
autoencoderNet = trainNetwork(data, data, layers, options);

% Test the network on some input data
outputData = predict(autoencoderNet, data);

% Display original and reconstructed images
figure;
subplot(1, 2, 1);
imshow(data(:,:,:,1));
title('Original Image');

subplot(1, 2, 2);
imshow(outputData(:,:,:,1));
title('Reconstructed Image');