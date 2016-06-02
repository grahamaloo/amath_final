function [dy] = mainSystem(y, curr_mode, lambda, s_alphas, N2) 
    dy = zeros(2 * N2, 1);
    a_alph = y(1:N2);
    b_alph = y(N2+1:end);
%     dy1 = lambda * ( (s_alphas(curr_mode) - dot(a_alph, b_alph) ) * b_alph - sum_b_gam(curr_mode, W32c, a_alph)); 
%     dy2 = lambda * ( (s_alphas(curr_mode) - dot(a_alph, b_alph) ) * a_alph - sum_a_gam(curr_mode, W21, b_alph));
    dy1 = lambda * ( (s_alphas(curr_mode) - dot(a_alph, b_alph) ) * b_alph);
    dy2 = lambda * ( (s_alphas(curr_mode) - dot(a_alph, b_alph) ) * a_alph);
    dy(1:N2) = dy1;
    dy(N2+1:end) = dy2;
end