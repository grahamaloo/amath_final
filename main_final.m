clearvars; close all; clc

% initializing constant system variables
t1 = 0:1000;
lambda = 0.5 * exp(-3);
u0 = 1 * exp(-6);
N1 = 32; % N1 also = P for simplicity
N2 = 32;
N3 = 1000; 


% W21 = linUnit(N2, N1); % used for more complex modeling
% W32 = linUnit(N3, N2);


SIG31 = sig31(0.1, 6, N3, N1); %input-output correlation matrix
[U, S, V] = svd(SIG31);
s_alphas = diag(S); %the singular vals aka correlation modes
R = orth(rand(N2, N2)); %arbitrary orthogonal matrix

%%%%arbitrary diagonal matrices%%%%
Da = zeros(N3, N2);
Da_els = diag(rand(N2,1));
Da(1:N2,1:N2) = Da_els;

Db = zeros(N2, N1);
Db_els = diag(rand(N1, 1));
Db(1:N1, 1:N1) = Db_els; %trivial in this case since N1 = N2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%constructing for easy  case (a^alph and b^alph prop 2 r^alph)
W32 = U * Da * R';
W21 = R * diag(rand(N1, 1)) * V';
%%%%%%%%%%%%%%%%%

W32c = conj(W32); 

modes = 1:3:size(s_alphas, 1); % selecting a subset of the modes

%plot analytical (theoretical) curve
for mode = modes
  s = s_alphas(mode);
  uf1 = zeros(1001, 1);
  for t = t1
    uf1(t + 1) = uf_function(lambda, s, u0, t);
  end

plot(t1, uf1)
hold on
end
title('analytic curve with a few modes selected');

%plot dynamics
for mode = modes
%     mode = 5;
    figure;
    Y0 = zeros(N2 * 2,1); %store them in one big vector, the a's and b's are
                          %handled differently in the 'mainSystem' function
    Y0(1:N2) = W21(:, mode); %select only for the mode we're considering
    Y0(N2+1:end) = W32c(mode, :)';
    [tcurr, ycurr] = ode45(@(t,y) (mainSystem(y, mode, lambda, s_alphas, N2)), t1, Y0);
    plot(tcurr, ycurr(:,1:N2), 'b'); % a's
    hold on
    plot(tcurr, ycurr(:,N2+1:end), 'r'); % b's
    title(strcat('Dynamics with mode: ', int2str(mode)))
end




