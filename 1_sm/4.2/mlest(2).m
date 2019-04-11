function [fi,theta,s2,C,FPE,AICC]=mlest(x,p,q)
% [fi, theta,s2,C,FPE,AICC]=mlest(x,p,q) gives maximum-likelihood estimates 
% of parameters in an ARMA(p,q)-process
% x is the observed time series
% fi is the estimated vector of parameters fi
% theta is the estimated vector of parameters theta
% s2 the estimated sigma^2 variance (noise variance)
% C estimated covarians matris of the random vector [fi, theta], thus the
% diagonal gives the estimated variances of the estimated parameters
% FPE is Akaikes FPE (Brockwell p 167)
% AICC is Akaikes AICC (Brockwell p 159, 169)
% The function require the Identification Toolbox, (included in KTHs license)

x=x(:); %column
n=length(x);

a=armax(x,[p,q]);
fi=-a(3,1:p);
theta=a(3,p+1:p+q);
s2=a(1,1);
C=a(4:3+p+q,1:p+q);
FPE=a(2,1);

g=armaacvf(fi,theta,n);
f=g(2)/g(1);
v(1)=g(1);
v(2)=g(1)*(1-f^2);
for k=3:n                               % Durbin-Levinson
        fn=(g(k)-f*g(k-1:-1:2)')/v(k-1);
        f=f-fn*f(length(f):-1:1);
        f=[f fn];
        v(k)=v(k-1)*(1-fn^2);
end

l=log(s2)+log(prod(v))/n;

AICC=n*(l+log(2*pi)+1+2*(p+q+1)/(n-p-q-2));

