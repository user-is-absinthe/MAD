function [fi, theta]=innest(x,p,q,m)
% [fi, theta]=innest(x,p,q,m) innovation algorithm for estimation
% x time series, p, q, AR and A order, 
% m order of innovation algorithm, see Brockwell, need not be given, default value = 17
% see Brockwell page 148, 152


if nargin< 4, m=17; end

C=acvf(x);

C=toeplitz(C); % covariance matrice

th=innov(C,m);

th=th(m,:); 

if q==0
	theta=th(1:p);
	return; 
end

v=th(q+1:q+p)'; % column

A=[];

th1=[zeros(1,p-q) 1 th];

n1=max(0,p-q)+1;

A=[A th1(n1+q:n1+q+p-1)'];

for j=1:p-1
	A=[A th1(n1+q-j-1:n1+q+p-1-j-1)'];
end


fi=(A\v)';


th2=[th(q:-1:1) 1 zeros(1,p)];

%B(:,1)=[1 ; zeros(p-1,1)];

B=[];


for j=0:q-1
	B=[B th2(q-j+1:q-j+p)'];
end;


theta=th(n1:n1+q-1)-fi*B;