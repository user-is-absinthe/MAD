function [c,z]=smoothpf(x,grad,plott)
% [c,z]=smoothpf(x,grad,plott) polynomial fitting degree grad, coefficients in c, 
% z estimated noise. 
%if third argument, plot is drawn of data and fitted polynomial 

n=length(x);
for i=0:grad, A(:,i+1)=((1:n).^i)'; end
c=A\x;
f=c(1);
for i=1:grad, f=f+c(i+1)*(1:n).^i; end
f=f';
z=x-f;
if nargin==3
   hold off; plot(x,'o');hold on; plot(z); hold off
end

