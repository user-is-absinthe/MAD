function [y, se2]=prdarima(x,fi,d,theta,h,s2,md)
% [y se2]=prdarima(x,fi,d,theta,h,s2,md) predicts x, h steps forward
% y the predicted value x_{n+h}
% se2 mean squared error 
% fi vector fi paramaters, theta vector of theta parameters
% d difference parameter 
% md mean of differenced series, 0 default value
% s2 white noise variance
% Brockwell p 197

x=x(:)'; % row

n=length(x);
g=armaacvf(fi,theta,n+h);

Cy=toeplitz(g,g);

%jf=cumprod(1:d);
%df=cumprod(d:-1:1);

dj=[-1 1];
df=dj;
for j=1:d-1
   dj=conv(dj,df); %(df./jf).*(-1).^(1:d);
end

A=tril(toeplitz([dj(d:-1:1) 1 zeros(1,n+h-d-1)]));

Ainv=inv(A);

C=Ainv*Cy*Ainv';

Gn=C(1:n,1:n);
gnh=C(n+h,1:n);

a=gnh*inv(Gn);

m=0;
if nargin==7
   m=md; %mean(diffd(x,d));
   mx=-Ainv*m*ones(n+h,1);
   x=x-mx(1:n)';
   m=mx(n+h);
end


y=a*x'+m; 

if h>1
   C(n+1:n+h-1,:)=[];
   C(:,n+1:n+h-1)=[];
end

se2=s2*[-a 1]*C*[-a 1 ]';
