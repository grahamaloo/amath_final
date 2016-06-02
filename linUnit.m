function [obj] = linUnit(inputSize, outputSize)
    initScale = sqrt(2);
    
    M1 = randn(inputSize);
    M2 = randn(outputSize);
    
    n_min = min(outputSize, inputSize);
    
    [Q1, R1] = qr(M1);
    [Q2, R2] = qr(M2);
    
    obj = Q1(:,1:n_min) * Q2(1:n_min,:) * initScale;
    
end