function [fi,theta,s2,C,FPE,AIC]=mlest(x,p,q)
% [fi, theta,s2,C,FPE,AIC]=mlest(x,p,q) gives maximum-likelihood estimates 
% of parameters in an ARMA(p,q)-process
% x is the observed time series
% fi is the estimated vector of parameters fi
% theta is the estimated vector of parameters theta
% s2 the estimated sigma^2 variance (noise variance)
% C estimated variances of the estimates in the random vector [fi, theta]
% FPE is Akaikes FPE (Brockwell p 167)
% AIC is Akaikes AIC (Brockwell p 169-171)
% The function require the Identification Toolbox, (included in KTHs license)

x=x(:); %column
n=length(x);

model=armax(x,[p q]);

fi=get(model,'a');
theta=get(model,'c');
s2=get(model,'noisevar');
C=get(model,'cov');

info=get(model,'estim');
FPE=fpe(model);
AIC=aic(model);
