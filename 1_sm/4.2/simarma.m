function y=simarma(fi,theta,n,s2,seed)
% y=simarma(fi,theta,n,s2) simulates ARMA process, 
% fi vector fi paramaters, theta vector of theta parameters
% n observations 
% s2 WN variance
% if fifth argument seed given, seed is the random generator seed

if nargin==5
   randn('seed',seed);
end

y=filter([1 theta],[1 -fi],randn(1,n+20));

y=y(21:n+20)*sqrt(s2);

