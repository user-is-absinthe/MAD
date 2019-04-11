function y=linfilt(f,Psiplus,Psiminus)
% y=linfilt(f,Psiplus,Psiminus) gives spectral density of a linear filter Psi 
% Psiplus are filter coefficient for j>=0 
% Psiminus vector of filter coefficient for j=-1, -2,  ...
% f given in the interval [0, pi] in equidistant points
% Brockwell page 127

la=0:pi/(length(f)-1):pi;
z=exp(-i*la);

t=0;

for k=1:length(Psiplus)
        t=t+Psiplus(k)*z.^(k-1);
end

for k=1:length(Psiminus)
        t=t+Psiminus(k)*z.^(-k);
end

y=f.*abs(t.^2);
