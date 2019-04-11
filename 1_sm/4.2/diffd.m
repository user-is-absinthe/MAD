function y = diffd(x,d)
% diffd(x,d) gives  differences with lag d; x(k+d)-x(k), k=1,2,..., 
% Brockwell page 31

n=length(x);
if nargin == 1
	d = 1;
end
y = x(d+1:n) - x(1:n-d);

