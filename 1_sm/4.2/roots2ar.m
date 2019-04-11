function y=root2ar(r)
% y=root2ar(r) gives the coefficients fi:s for an AR-process with
% characteristic roots in vector r

y=poly(1./r);
y=-y(2:length(y));