function y=ljungbox(x,h)
% y=boxljung(x,h) gives Box Ljung statistics
% Brockwell page 35

n=length(x);

r=acf(x);

y=n*(n+2)*r(2:h+1).^2*((n-1:-1:n-h)').^(-1);
