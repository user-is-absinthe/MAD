function r=acf2(x,y,plott,limits)

% r=acf2(x,y,plott,limits) calculates the cross-correlation function rho(x(t+h),y(t)) 
% The first row contains rho(x(t+h),y(t)) for h=0,1,...,n-1
% the second row contains rho(x(t+h),y(t)) for h=0,-1,-2,...,-n+1
% if third argument is given (arbitrary number), a plot is drawn
% for h=-n+1,-n+2,...,0,1,2,...,n-1
% if forth argument limits given (arbitrary number) limits +-1.96/sqrt(n) is drawn
% n=minimum of length of x and y
% Brockwell p 229

n=min(length(x),length(y));

r=acvf2(x,y);

r=r*n/(std(x)*std(y)*(n-1));

if nargin>=3
   y1=[zeros(1,2*n-1);[r(2,n :-1:2) r(1,:) ]];
	x1=[-n+1:n-1];
   plot([x1;x1],y1,'b')
end

if nargin==4
   hold on;
   plot([-n+1 n-1],1.96/sqrt(n)*ones(1,2),':b',[-n+1 n-1],-ones(1,2)*1.96/sqrt(n),':b');
   hold off;
end


