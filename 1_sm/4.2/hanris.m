function [fih, thetah,s2]=hanris(x,p,q)
% [fih, thetah]=hanris(x,p,q) estimates fi and beta according to Hannan-Rissanen
% Brockwell p 154

x=x(:);
n=length(x);
m=min(max(p,q)+10,floor(n/2));
fi=yuwaest(x,m)';
z=filter([1 -fi],1,x);

Z=x(m:n-1);
for j=1:p-1
        Z=[Z x(m-j:n-j-1)];
end
for j=0:q-1
        Z=[Z z(m-j:n-j-1)];
end

beta=Z\x(m+1:n);
fi=beta(1:p)';
theta=beta(p+1:p+q)';

s2=norm(x(m+1:n)-Z*beta(:))^2/(n-m);

fih=fi; thetah=theta;

return % can be deleted or commented away if third step is wanted. 

% Step 3, warning not tested appropriately

m=max(p,q);
x0=filter([-1 fi],1,x(1:m));
zt=filter([1 -fi],[1 theta],x,x0);
v=filter(1,fi,zt);
w=filter(1,-theta,zt);

A=v(m:n-1);
for j=2:p
        A=[A v(m+1-j:n-j)];
end
for j=1:q
        A=[A w(m+1-j:n-j)];
end


beta1=A\zt(m+1:n);
beta=beta+beta1;
fih=beta(1:p);
thetah=beta(p+1:p+q);


