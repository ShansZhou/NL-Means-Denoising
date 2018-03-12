function [offsetsRows, offsetsCols, distances] = templateMatchingNaive(row, col,...
    patchSize, searchWindowSize,image)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)
% offsetsRows(1) = -1;
% offsetsCols(1) = -1;
% distances(1) = 0.125;

% The distance is simply the SSD over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

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
maxRow = size(image,1);
maxCol = size(image,2);
for index = 1: counter -1
    
    windowInImageRow = offsetsRows(index) + row;
    windowInImageCol = offsetsCols(index) + col;

    sum = 0;
    for offsetRow = - (patchSize-1)/2 :(patchSize-1)/2
        for offsetCol = - (patchSize-1)/2 : (patchSize-1)/2 
          
            originalPatchInImageRow = row + offsetRow;
            originalPatchInImageCol = col + offsetCol;
            
            if originalPatchInImageRow < 1 || originalPatchInImageRow > maxRow ...
                    || originalPatchInImageCol < 1 || originalPatchInImageCol > maxCol
                pixelInOriginalPatch = 0;
            else
                pixelInOriginalPatch = image(originalPatchInImageRow, originalPatchInImageCol);
            end
            
            offsetPatchInImageRow = windowInImageRow + offsetRow;
            offsetPatchInImageCol = windowInImageCol + offsetCol;          
            if offsetPatchInImageRow < 1 || offsetPatchInImageRow > maxRow...
                    ||offsetPatchInImageCol < 1 || offsetPatchInImageCol > maxCol
                pixelInOffsetPatch = 0;
            else
                pixelInOffsetPatch = image(offsetPatchInImageRow,offsetPatchInImageCol);
            end 
               
            sum = sum+    (pixelInOriginalPatch - pixelInOffsetPatch)^2;
                
        end
    end
    
    distances(index) = sum;
    
    
end


