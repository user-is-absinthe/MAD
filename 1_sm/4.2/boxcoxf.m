function y=boxcoxf(x,lambda)

% y=boxcoxf(x,lambda) Box-Cox function; Brockwell page 186
%


if lambda==0 
  y=log(x); 
else 
  y=(x.^lambda-1)/lambda; 
end



