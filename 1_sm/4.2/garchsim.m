function [y, sigma]=garchsim(a0,a1,b, y0, sigma0, n,seed)
% [y, sigma] = garchsim(a0, a1, b, y0, sigma0, n,seed), 
% simulate a GARCH(1) process
% a0, a1, b are parameters in GARCH(1) process
% y0 is value of the process at time t=0
% sigma0 is volatility at time t=0
% n is length of sample
% n is random number seed
% y vector with the values of the simulated GARCH(1) process
% sigma vector with the values of the volatility process
% (sigma_t)^2 = a0+a1*(X_{t-1})^2 + b*(sigma_{t-1})^2.

if narginn==7
  randn('seed',seed);
end



z = randn(1,n);
y=[y0];
sigma = [sigma0];
for i=2:n
sigma = [sigma sqrt(a0+a1*y(i-1)^2+b*sigma(i-1)^2)];
y=[y sigma(i)*z(i)];
end
