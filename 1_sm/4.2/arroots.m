function y=arroots(fi)
% y=arroots(fi) gomputsd the roots of the generating function of
% an AR-process with parameters in the vector fi

y=1./roots([1 -fi]);
