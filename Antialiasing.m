% Parameters
Fs = 1000;                 % Sampling frequency (Hz)
Fc = 50;                   % Cutoff frequency of the antialiasing filter (Hz)
order = 4;                 % Order of the Butterworth filter
downsampleFactor = 4;      % Downsampling factor

% Create a 2D wheel image
theta = linspace(0, 2*pi, 1000); % Angle from 0 to 2*pi
radius = 200;                    % Radius of the wheel
center = 250;                    % Center of the wheel

% Create x and y coordinates for the wheel
x = radius * cos(theta) + center;
y = radius * sin(theta) + center;

% Create a binary image of the wheel
wheelImage = poly2mask(x, y, 500, 500);

% Display the original wheel image
figure;
subplot(2, 2, 1);
imshow(wheelImage);
title('Original Wheel Image');

% Design a low-pass Butterworth filter
[b, a] = butter(order, Fc/(Fs/2));

% Apply the filter to the image
% Convert the image to double for filtering
filteredWheel = imfilter(double(wheelImage), b, 'replicate');

% Downsample the filtered image
downsampledImage = imresize(filteredWheel, 1/downsampleFactor, 'bilinear');

% Display the filtered wheel image
subplot(2, 2, 2);
imshow(filteredWheel, []);
title('Filtered Wheel Image');

% Display the downsampled image
subplot(2, 2, 3);
imshow(downsampledImage, []);
title('Downsampled Wheel Image');

% Display the frequency response of the filter
subplot(2, 2, 4);
freqz(b, a);
title('Frequency Response of the Antialiasing Filter');
