function y=mcleodli(x,h)
% y=mcleodli(x,h) gives Mcleod and Li statistic
% Brockwell page 35

n=length(x);

r=acf(x.^2);

y=n*(n+2)*r(2:h+1).^2*((n-1:-1:n-h)').^(-1);
