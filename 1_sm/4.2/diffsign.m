function [S, ts,diff_p]=diffsign(x)
% [S, ts]=diffsign(x,h) Difference Sign Test
% S number of signs. ts test statistics, approx N(0,1) under null hypothesis
% Brockwell page 35


n=length(x);

d=sign(diff(x));

S=sum(d==1);

ts=(S-(n-1)/2)/sqrt((n+1)/12);
diff_p = 2*min(1 - normcdf(ts, 0, 1), normcdf(ts, 0, 1));
sprintf('diffCount = %d\ntpStatistic = %d\np-value = %d',S,ts,diff_p)