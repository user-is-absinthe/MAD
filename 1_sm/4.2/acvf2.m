function g=acvf2(x,y,plott)

% g=acvf2(x,y) calculates the cross covariance function C(x(t+h),y(t)) 
% x, y two time series
% The first row contains C(x(t+h),y(t)) for h=0,1,...,n-1
% the second row contains C(x(t+h),y(t)) for h=0,-1,-2,...,-n+1
% if third argument is given (arbitrary number), a plot is drawn
% for h=-n+1,-n+2,...,0,1,2,...,n-1
% n=minimum of length of x and y
% Brockwell p 229


n=min(length(x),length(y));
x=x(1:n);
y=y(1:n);

x=x(:)'-mean(x);
y=y(:)'-mean(y);

g1 = filter(y(n:-1:1),1,x);
g(1,:) = g1(n:-1:1)/n;

g2 = filter(x(n:-1:1),1,y);
g(2,:) = g2(n:-1:1)/n;



if nargin==3
   y1=[zeros(1,2*n-1);[g(2, n:-1:2) g(1,:) ]];
	x1=[-n+1:n-1];
   plot([x1;x1],y1,'b')
end


