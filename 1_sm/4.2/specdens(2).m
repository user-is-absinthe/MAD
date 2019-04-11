function y=specdens(g,plott)
% y=specdens(g,plott) gives spectral density in 0:0.01:pi for an  ACVF g
% if second argument give, the plot is drawn
% Brockwell page 110

lam=0:0.01:pi;
n=length(g);
c=cos(lam'*(0:n-1));
y=c*g(:)/(2*pi);
if nargin==2, plot(lam',y); end

