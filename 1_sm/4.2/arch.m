function y=arch(a,n)
% simulates ARCH-process
% a=[a(0) a(1) a(2) ... a(p)] parameters of the process, p the order
% n number of simulated data

a=a(:)';
na=length(a);
p=na-1;
z=randn(1,n+p+20);
y=zeros(p,1);

for j=1:n+p+20
   s2=a(1)+a(2:na)*(y(j:p+j-1).^2);
   y(p+j)=sqrt(s2)*randn(1);
end

y=y(p+20:n+p+19);

y=y(:)'; % row
