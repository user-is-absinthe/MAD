function [c,m,z]=smoothpf(x,grad)
% [c,m,z]=smoothpf(x,grad) polynomial fitting degree grad, 
% c is the vector of polynomial coefficients p(x)=c(1)+c(2)x+c(3)x^2+..
% m the trend vector	
% z the residual x-m (noise)

n=length(x);
for i=0:grad, A(:,i+1)=((1:n).^i)'; end
c=A\x;
m=c(1);
for i=1:grad, m=m+c(i+1)*(1:n).^i; end
m=m';
z=x-m;
