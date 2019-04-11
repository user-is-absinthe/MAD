function [y, sigma]=archsim(a0,a1,y0, n)
% [y, sigma] = archsim(a0, a1, y0, n), simulate an ARCH(1) process
% a0, a1 are parameters in ARCH(1) process
% y0 is value of the process at time t=0.
% n is length of sample
% y vector with the values of the simulated ARCH(1) process
% sigma vector with the values of the volatility process
% (sigma_t)^2 = a0+a1*(X_{t-1})^2.
z = randn(1,n);
y=[y0];
sigma = [0];

for i=2:n
sigma = [sigma sqrt(a0+a1*y(i-1)^2)];
y=[y sigma(i)*z(i)];
end
