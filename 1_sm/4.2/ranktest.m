function [P, ts,rank_p]=ranktest(x)
% [P, ts]=ranktest(x) rank test, P number of pairs x_j>x_i, j>i, 
% ts is the test statistic |P-mu_P|/sigma_p
% Brockwell page 36

n=length(x);

P=0;

for i=2:n
	P=P+sum(x(1:i-1)<x(i));
end
%Theta=(4*P/(n*(n-1))-1);%/sqrt(2*(2*n+5)/(90*n*(n-1)));
ts=(P-n*(n-1)/4)/sqrt(n*(n-1)*(2*n+5)/72);
rank_p = 2*min(1 - normcdf(ts, 0, 1), normcdf(ts, 0, 1));
sprintf('rankCount = %d\ntpStatistic = %d\np-value = %d',P,ts,rank_p)