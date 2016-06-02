function [res] = sum_a_gam(curr_mode, W21, b_alph)
    [m, n] = size(W21);
    res = zeros(m, 1);
    for j = 1:n
       if (j ~= curr_mode)
           a_gam = W21(:, j);
           res = res + a_gam * (b_alph * a_gam);
       end
    end
end