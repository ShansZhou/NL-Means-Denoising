function [patchSum] = evaluateIntegralImage(ii, row, col, patchSize)
% This function should calculate the sum over the patch centred at row, col
% of size patchSize of the integral image ii

%REPLACE THIS!

offset = (patchSize-1)/2;

%% get SSD with Integral Image

% calculate L1
if (row-offset-1<1 || col-offset-1<1)
    l1 = 0;
else
    l1 = ii(row-offset-1,col-offset-1);
end

% calculate L2
if (row-offset-1<1)
    l2 = 0;
elseif (col+offset>size(ii,2))
    l2 = ii(row-offset-1,size(ii,2));
else
    l2 = ii(row-offset-1,col+offset);
end

% calculate L3
if (col-offset-1<1)
    l3 = 0;
elseif (row+offset>size(ii,1))
    l3 = ii(size(ii,1),col-offset-1);
else
    l3 = ii(row+offset,col-offset-1);
end

% calculate L4
if (row+offset>size(ii,1) && col+offset>size(ii,2))
    l4 = ii(size(ii,1),size(ii,2));
elseif (row+offset>size(ii,1))
    l4 = ii(size(ii,1),col+offset);
elseif (col+offset>size(ii,2))
    l4 = ii(row+offset,size(ii,2));
else
    l4 = ii(row+offset,col+offset);
end

patchSum = l4+l1-l2-l3;

% [maxRow,maxCol] = size(ii);
% offset = (patchSize-1)/2;
% 
% 
% % calculate L3
% if col - offset - 1 < 1
%     l3 = 0;
% elseif  row + offset > maxRow
%     l3 = ii(maxRow,col - offset -1);
% else
%     l3 = ii(row + offset,col - offset - 1);
% end
% 
% % calculate L4
% if row + offset > maxRow && col + offset > maxCol
%     l4 = ii(maxRow,maxCol);
% elseif row + offset > maxRow
%     l4 = ii(maxRow, col + offset);
% elseif col + offset > maxCol
%     l4 = ii(row + offset, maxCol);
% else
%     l4 = ii(row + offset, col + offset);
% end
% 
% % calculate L2
% if row - offset -1 < 1
%     l2 = 0;
% elseif col + offset > maxCol
%     l2 = ii(row - offset - 1, maxCol);
% else
%     l2 = ii(row - offset - 1, col + offset);
% end
% 
% % calculate l1
% if row - offset -1 < 1 || col - offset - 1 <1
%     l1 = 0;
% else
%     l1 = ii(row - offset - 1, col - offset - 1);
% end
%     
% patchSum = l3 - l4 -l2 +l1;        
end


