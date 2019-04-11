function [T, ts,tpt_p]=tptest(x)
% [T, ts]=tptest(x,h) Turning Point Test
% T number turning points. ts test statistic, approx N(0,1) under null hypothesis
% Brockwell page 35

n=length(x);
d1=sign(diff(x));
d=d1(1:n-2).*d1(2:n-1);
T=sum(d==-1);
ts=(T-2*(n-2)/3)/sqrt((16*n-29)/90);
tpt_p = 2*min(1 - normcdf(ts, 0, 1), normcdf(ts, 0, 1));
sprintf('tpCount = %d \ntpStatistic = %d\np-value = %d',T,ts,tpt_p)
