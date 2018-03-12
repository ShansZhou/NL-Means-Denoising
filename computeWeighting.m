function [result] = computeWeighting(d, h, sigma)
    %Implement weighting function from the slides
    %Be careful to normalise/scale correctly!
    
    %REPLACE THIS
    result = exp(-(max(d^2-2*sigma^2,0)/h^2));
end