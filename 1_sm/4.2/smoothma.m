function y=smoothma(x,a,plott)
% y=smoothma(x,a) symmetric moving average filter, a is weights for j=0,1,...
% the m-file normalize a, the sum of weights need not be 1
% Brockwell page 26

a=a(:)';
q=length(a)-1;
a=[a(q+1:-1:2) a];
a=a/sum(a);
x1=x(:)';
x1=[x1(1)*ones(1,q+1) x1 x1(length(x1))*ones(1,q+1)];
y=filter(a,1,x1);
y(length(y))=[];
y(1:2*q+1)=[];
%y(length(y)-q-1:length(y));
y=y';
if nargin==3
	hold off;
	plot(x,'o');
	hold on;
	plot(y);
	hold off;
end
