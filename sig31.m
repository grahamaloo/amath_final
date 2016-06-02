function [SIG31] = sig31(flip, levels, N3, N1)
    % P = N1 for simplicity
    SIG31 = zeros(N3, N1);
    Ys = zeros(N3, N1);
    Xs = diag(ones(N1, 1));
    for n = 1:N1
       ytemp = outputs(flip, levels);
       Ys(n,:) = ytemp;     
%        y = outputs(flip, levels);
%        x = zeros(N1, 1);
%        x(n) = 1;  
    end
    for m = 1:N1
       SIG31 = SIG31 + Ys(:,m) * Xs(m,:); 
    end
end