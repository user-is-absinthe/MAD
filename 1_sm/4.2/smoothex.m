function y=smoothex(x,a,plott)
% y=smoothex(x,a,plott) exponential smoothing with factor a
% if third argument plott (arbitrary nubmer) is given, a plot is drawn
% Brockwell p 26

y=filter(a,[1 a-1],x, (1-a)*x(1));

if nargin==3
	plot(y)
	hold on;
	plot(x,'o')
	hold off;
end

