function [y,se2]=predarma(x,fi,theta,s2,h)
% [y se2]=predarma(x,fi,theta,s2,h) predicts x, h steps forward
% y the predicted value of x_{n+h}
% fi vector fi paramaters, theta vector of theta parameters
% s2 white noise variance
% se2 mean squared error

x=x(:)'; % row
n=length(x);
g=armaacvf(fi,theta,n+h);
C=toeplitz(g,g);

Gn=C(1:n,1:n);
gnh=C(n+h,1:n);

a=gnh*inv(Gn);
y=a*x';

if h>1
   C(n+1:n+h-1,:)=[];
   C(:,n+1:n+h-1)=[];
end

se2=s2*[-a 1]*C*[-a 1]';
