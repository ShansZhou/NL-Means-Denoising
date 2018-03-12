function [ii] = computeIntegralImage(image)

%REPLACE THIS
ii = zeros(size(image));

for r = 1 : size(image,1)
    sumOfRow = 0;
    for c = 1 : size(image,2)
        sumOfRow = sumOfRow + image(r,c);
        if r == 1
            ii(r,c) = sumOfRow;
        else
            ii(r,c) = sumOfRow + ii(r-1,c);
        end
    end
end

end