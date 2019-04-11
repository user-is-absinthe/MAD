function invertbl(theta)
% invertbl(theta) test if an ARMA-process with MA-parameter vector theta is invertable
% Brockwell p 84

k=roots([1 theta]); % roots to theta(1/z)

if all(abs(k)<1)
        sprintf('Invertable')
else
        sprintf('Not invertable')
end
