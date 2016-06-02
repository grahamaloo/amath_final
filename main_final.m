clearvars; close all; clc

t1 = 0:1000;
lambda = 0.5 * exp(-3);
u0 = 1 * exp(-6);
N1 = 32; % N1 also = P for simplicity
N2 = 32;
N3 = 1000; 


%W21 = linUnit(N2, 16);
%W32 = linUnit(16, N2);


SIG31 = sig31(0.1, 6, N3, N1);
[U, S, V] = svd(SIG31);
s_alphas = diag(S);
R = orth(rand(N2, N2));

Da = zeros(N3, N2);
Da_els = diag(rand(N2,1));
Da(1:N2,1:N2) = Da_els;

Db = zeros(N2, N1);
Db_els = diag(rand(N1, 1));
Db(1:N1, 1:N1) = Db_els; %trivial in this case since N1 = N2

W32 = U * Da * R';
W21 = R * diag(rand(N1, 1)) * V';

W32c = conj(W32);

for s = s_alphas'
  uf1 = zeros(1001, 1);
  for t = t1
    uf1(t + 1) = uf_function(lambda, s, u0, t);
  end

plot(t1, uf1)
hold on
end
modes = 1:4:size(s_alphas, 1);
for mode = modes
%     mode = 5;
    figure;
    Y0 = zeros(N2 * 2,1);
    Y0(1:N2) = W21(:, mode);
    Y0(N2+1:end) = W32c(mode, :)';
    [tcurr, ycurr] = ode45(@(t,y) (mainSystem(y, mode, lambda, s_alphas, N2)), t1, Y0);
    plot(tcurr, ycurr);
    
end




