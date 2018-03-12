function [result] = nonLocalMeans(img, sigma, h, patchSize, windowSize)

%REPLACE THIS

image = im2double(rgb2gray(img));
result = zeros(size(image));
offsetsRows = zeros(windowSize^2,1);
offsetsCols = zeros(windowSize^2,1);
distances = zeros(windowSize^2,1);

%% calculate offsetsRows and offsetsCols
counter = 1;
for r = -(windowSize-1)/2 :(windowSize-1)/2 
    for c = -(windowSize-1)/2 : (windowSize-1)/2 
        offsetsRows(counter) = r;
        offsetsCols(counter) = c;
        counter= counter+1;  
    end
end

%% calculate distances metrics
ii_metricSSD{windowSize^2} = 0;
for index = 1: counter -1

    img = zeros(size(image));
    for r = 1:size(image,1)
        for c = 1:size(image,2)
            if (r+offsetsRows(index)<1 || r+offsetsRows(index)>size(image,1)...
                    || c+offsetsCols(index)<1 || c+offsetsCols(index)>size(image,2))
                img(r,c) = image(r,c);
            else
                img(r,c) = image(r,c) - image(r+offsetsRows(index),c+offsetsCols(index));
            end
        end
    end
    metricSSD = (img).^2;
    ii_metricSSD{index} = computeIntegralImage(metricSSD);
            
end
% assignin('base','ii_metricSSD',ii_metricSSD{1});
%% calculate denoised pixel 

for r = 1:size(image,1)
    for c = 1:size(image,2)
        sumOfweightedPixel =0 ;
        sumOfWeight = 0;
        for index = 1:counter-1 
            
            distances(index) = evaluateIntegralImage(ii_metricSSD{index}, r, c, patchSize);   
            %assignin('base','ddd',distances(index));
            weight = computeWeighting(distances(index),h,sigma);
            
            sumOfWeight = sumOfWeight + weight;
            
            if r+offsetsRows(index)<1 || r+offsetsRows(index)>size(image,1)...
                || c+offsetsCols(index)<1 || c+offsetsCols(index)>size(image,2)
                sumOfweightedPixel =sumOfweightedPixel+ 0;
            else
                sumOfweightedPixel = sumOfweightedPixel + image(r+offsetsRows(index),c+offsetsCols(index)) * weight;
            end  
        end
        
        
        denoisedPixel = sumOfweightedPixel / sumOfWeight ;
        result(r,c) = denoisedPixel;
        
        
    end
end
%assignin('base','result',result);




end