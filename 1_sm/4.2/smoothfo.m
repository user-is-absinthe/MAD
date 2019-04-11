function y=smoothfo(x,f,plott)

% y=smoothfu(x,f,plott) smoothing by eliminsting fourierfreq > f*pi
% x time series, f se above
% if thirs argument plott is given (arbitrary number) plot is drawn

n=length(x);
a=fft(x);
b=round(f*n/2);
a1=[a(1:b+1); zeros(n-2*b-1,1); a(n-b+1:n)];
y=real(ifft(a1));
if nargin==3
	plot(x,'o'); 
	hold on ;
	plot(y); 
	hold off; 
end


