function [offsetsRows, offsetsCols, distances] = templateMatchingIntegralImage(row,...
    col,patchSize, searchWindowSize, image)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsX(1) = -1;
% offsetsY(1) = -1;
% distances(1) = 0.125;

% The distance is simply the SSD over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

% This time, use the integral image method!
% NOTE: Use the 'computeIntegralImage' function developed earlier to
% calculate your integral images
% NOTE: Use the 'evaluateIntegralImage' function to calculate patch sums

%REPLACE THIS
offsetsRows = zeros(searchWindowSize^2,1);
offsetsCols = zeros(searchWindowSize^2,1);
distances = zeros(searchWindowSize^2,1);

%% calculate offsetsRows and offsetsCols
counter = 1;
for r = -(searchWindowSize-1)/2 :(searchWindowSize-1)/2 
    for c = -(searchWindowSize-1)/2 : (searchWindowSize-1)/2 
        offsetsRows(counter) = r;
        offsetsCols(counter) = c;
        counter= counter+1;  
    end
end

%% calculate distances
%patchSum = evaluateIntegralImage(image_ii, row, col, patchSize);
%disp(patchSum);
for index = 1: counter -1
  
%     windowInImageRow = offsetsRows(index) + row;
%     windowInImageCol = offsetsCols(index) + col; 
%     
%     patchSumOfWindow = evaluateIntegralImage(image_ii, windowInImageRow, windowInImageCol, patchSize);
%     %disp(patchSumOfWindow);
%     
%     distances(index) = (patchSumOfWindow - patchSum)^2;
    
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
    ii_metricSSD = computeIntegralImage(metricSSD);
    distances(index) = evaluateIntegralImage(ii_metricSSD, row, col, patchSize);
end






end