function plotbar(y,x)
% plotbar(y) draws bars above values 0,1,2,... of height y(0), y(1),...
% plotbar(y,x) draws bars above x(1), x(2),....of height y(0), y(1),...

y=y(:)'; % row
n=length(y);
if nargin==1
   x=0:(n-1);
end

y1=[zeros(1,n+1);[y 0]];
x1=[[x 0];[x n]];
plot(x1,y1,'b')
