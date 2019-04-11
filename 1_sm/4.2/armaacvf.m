function y=armaacvf(fi,theta,N,sigma2)
%armaacvf(fi,theta,N,sigma2) autocovariance function for ARMA-process
% fi vector fi paramaters, theta vector of theta parameters
% N maximum lag
% sigma2, the WN variance, default value is 1
% Brockwell page 88

if isempty(theta), theta=0; end

if isempty(fi), fi=0; end

if nargin<4, sigma2=1; end
fi=fi(:)'; % row
theta=theta(:)'; % row

p=length(fi);
q=length(theta);
%m=max(p,q+1);

if p<q, fi=[fi zeros(1,q-p)];p=q; end

B=hankel([1 -fi]);
A=hankel([-fi(p-1:-1:1) 1]);
A(p+1,:)=zeros(1,p);
A=[zeros(p+1,1) A];
A=A(p+1:-1:1,:);
C=A+B; % C is coefficient matrix, for solvin linear equation page 88

pm= psi_m(fi,theta,q+1);
thetamat=hankel([1 theta]);
v=sigma2*thetamat*pm';
if p<=q-1, v(p+2:q+1)=[]; end
if p>q-1, v=[v; zeros(p-q,1)]; end

x=C\v;

zi=filter([1 -fi],1,x);

y=filter(zeros(1,q+2),[1 -fi 0],zeros(1,N),zi);
