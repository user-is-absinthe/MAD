function y=specarma(fi,theta,s2,plott)
% y=specarma(fi,theta,s2,plott) gives spectral density of an ARMA process
% in points lambda=0:.01:pi
% fi, theta the vectors of parameters
% s2 the WN variance
% The plot is drawn if a fourth argument is given (arbitrary number)
% Brockwell page 130

la=0:0.01:pi;
z=exp(-i*la);
t=1;
f=1;

for k=1:length(theta)
        t=t+theta(k)*z.^k;
end
        
for k=1:length(fi)
        f=f-fi(k)*z.^k;
end

y=s2*(abs(t)./abs(f)).^2/(2*pi);

if nargin==4, plot(la,y);end
