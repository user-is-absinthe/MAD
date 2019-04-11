function causal(fi)
% causal(fi) tests if an ARMA-process with AR-parametrers fi (vector) is causal

k=roots([1 -fi]); % finds the roots to fi(1/z)

if all(abs(k)<1)
        sprintf('Causal process')
else
        sprintf('Not a causal process')
end
