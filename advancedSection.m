%% Some parameters to set - make sure that your code works at image borders!
patchSize = 3;
sigma = 20; % standard deviation (different for each image!)
h = 0.55; %decay parameter
windowSize =5;
if (mod(patchSize,2) == 0)
    patchSize = patchSize + 1;
end
if (mod(windowSize,2) == 0)
    windowSize = windowSize + 1;
end
sigma = sigma/255;
%TODO - Read an image (note that we provide you with smaller ones for
%debug in the subfolder 'debug' int the 'image' folder);
%Also unless you are feeling adventurous, stick with non-colour
%images for now.
%NOTE: for each image, please also read its CORRESPONDING 'clean' or
%reference image. We will need this later to do some analysis
%NOTE2: the noise level is different for each image (it is 20, 10, and 5 as
%indicated in the image file names)

%REPLACE THIS
imageNoisy = imread('images/alleyNoisy_sigma20.png');
imageReference = imread('images/alleyReference.png');
%figure('name', 'Noisy Image'),imshow(imageNoisy);

tic;
%TODO - Implement the non-local means function
filtered = nonLocalMeans(imageNoisy, sigma, h, patchSize, windowSize);
toc

%% Let's show your results!

imageNoisy = im2double(rgb2gray(imageNoisy));
imageReference = im2double(rgb2gray(imageReference));

%Show the denoised image
figure('name', 'NL-Means Denoised Image');
imshow(filtered);

%Show difference image
diff_image = abs(imageReference - filtered);
figure('name', 'Difference Image');
imshow(diff_image / max(max((diff_image))));

disp(['Sigma = ', num2str(sigma*255,3), '; h = ', num2str(h,3), '; patch size = ', num2str(patchSize,2),'; window size = ', num2str(windowSize,2) ]);
%Print some statistics ((Peak) Signal-To-Noise Ratio)
disp('For Noisy Input');
[peakSNR, SNR] = psnr(imageNoisy, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

disp('For Denoised Result');
[peakSNR, SNR] = psnr(filtered, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

%Feel free (if you like only :)) to use some other metrics (Root
%Mean-Square Error (RMSE), Structural Similarity Index (SSI) etc.)