function y=psi(fi,theta,n) 
% y=psi(fi,theta,n) gives psi parameters in an  ARMA-process
% fi, theta, parameter vectors, n number of parameters
% Brockwell p 83

y=filter(1,[1 -fi],[1 theta zeros(1,n-length(theta)-1)]);
