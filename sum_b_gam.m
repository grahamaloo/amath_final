% sums all 'b' connectivity modes except the current mode in consideration
function [res] = sum_b_gam(curr_mode, W32c, a_alph)
    [m, n] = size(W32c);
    res = zeros(1, n);
    for j = 1:m
       if (j ~= curr_mode)
           b_gam = W32c(j, :);
           res = res + (b_gam * (a_alph * b_gam) );
       end
    end
    res = res';
end