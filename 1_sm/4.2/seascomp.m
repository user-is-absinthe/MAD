function [d,s]=seascomp(x,p)

% [d,s]=seascomp(x,p) estimates seasonal component, 
% x data, p season period
% d deseasonilized data, s seasonal component
% Brockwell page 30 

x=x(:);
n=length(x);
q=floor(p/2);
a=ones(1,q+1);
if q==p/2, a(q+1)=0.5; end
m=smoothma(x,a);
m=m(1:n);

for k=1:q,
        w(k)=mean(x(k+p:p:n-q)-m(k+p:p:n-q));
end;

for k=q+1:p
        w(k)=mean(x(k:p:n-q)-m(k:p:n-q));
end;

s1=w'-mean(w);
s=s1;
for k=1:(n/p+1)
        s=[s;s1];
end
s=s(1:n);
d=x-s;
