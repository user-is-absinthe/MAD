function [t,v]=innov(C,N)
% [t, v]=innov(C,N) gives innovation parameters t for covariance matrix C, up to step N
% v estimated variance
% Brockwell page 70

if nargin==1, N=length(C(1,:))-1;end
v(1)=C(1,1);
t(1,1)=C(2,1)/v(1);
v(2)=C(2,2)-t(1,1)^2*v(1);
for n=2:N
        t(n,n)=C(n+1,1)/v(1);
        for k=1:n-1
                tkj=t(k,k:-1:1);
                tnj=t(n,n:-1:n-k+1);
                t(n,n-k)=(C(n+1,k+1)-sum(tkj.*tnj.*v(1:k)))/v(k+1);
        end
        t2=t(n,n:-1:1).*t(n,n:-1:1);
        v(n+1)=C(n+1,n+1)-t2*v';
end
