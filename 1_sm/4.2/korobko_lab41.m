% generate series
 a = .5; b = .5; omega = .9; p = 5; q = 1;  size = 100;
yFirst = normrnd(0,1,1,size); % mu sigma size MxN 
ySecond = a*(1:size) + normrnd(0,1,1,size);
yThird = b*sin(omega*(1:size)) + normrnd(0,1,1,size);
% AR model
aAR = normrnd(0,.1,1,5);  % random coeff for AR model
yFourth = zeros(1,100);
yFourth(1) = normrnd(0,1);
yFourth(2) = aAR(1)*yFourth(1) + normrnd(0,1);
yFourth(3) = aAR(1:2)*yFourth(1:2)' + normrnd(0,1);
yFourth(4) = aAR(1:3)*yFourth(1:3)' + normrnd(0,1);
yFourth(5) = aAR(1:4)*yFourth(1:4)' + normrnd(0,1);
for i = 6:100 
    yFourth(i) = aAR(1:p)*yFourth((i-p):(i-1))' + normrnd(0,1);
end
yFourth = simarma(aAR,0,100,.1);
% MA model
aMA = normrnd(0,1); % random coeff for MA model
yFive = zeros(1,100);
yFive(1) = normrnd(0,1);
for i = 2:100
    yFive(i) = aMA*yFive(i-q) + normrnd(0,1);
end
% plot series
plot(yFirst);
plot(ySecond);
plot(yThird);
plot(yFourth);
plot(yFive);

% Check criterias
[tpcount_1, tpstat_1] = tptest(yFirst);
[tpcount_2, tpstat_2] = tptest(ySecond);
[tpcount_3, tpstat_3] = tptest(yThird);
[tpcount_4, tpstat_4] = tptest(yFourth);
[tpcount_5, tpstat_5] = tptest(yFive);

[diffcount_1, diffstat_1] = diffsign(yFirst);
[diffcount_2, diffstat_2] = diffsign(ySecond);
[diffcount_3, diffstat_3] = diffsign(yThird);
[diffcount_4, diffstat_4] = diffsign(yFourth);
[diffcount_5, diffstat_5] = diffsign(yFive);

[rankcount_1, rankstat_1] = ranktest(yFirst);
[rankcount_2, rankstat_2] = ranktest(ySecond);
[rankcount_3, rankstat_3] = ranktest(yThird);
[rankcount_4, rankstat_4] = ranktest(yFourth);
[rankcount_5, rankstat_5] = ranktest(yFive);

% Autocorrelation functions
acvfFirst = acvf(yFirst);
acf(acvfFirst,true);
acvfSecond = acvf(ySecond);
acf(acvfSecond,true);
acvfThird = acvf(yThird);
acf(acvfThird,true);
acvfFourth = acvf(yFourth);
acf(acvfFourth,true);
acvfFive = acvf(yFive);
acf(acvfFive,true);

% Spectral Density
specFirst = specdens(acvfFirst,true);
specSecond = specdens(acvfSecond,true);
[max_spec, max_spec_ind] = max(specSecond);
T = 2*pi*100/max_spec_ind;
specThird = specdens(acvfThird,true);
specFourth = specdens(acvfFourth,true);
specFive = specdens(acvfFive,true);

% Partial Autocorrelation functions
pacf(acvfFirst,length(acvfFirst),true,true);
pacf(acvfSecond,length(acvfSecond),true,true);
pacf(acvfThird,length(acvfThird),true,true);
pacf(acvfFourth,length(acvfFourth),true,true);
pacf(acvfFive,length(acvfFive),true,true);
