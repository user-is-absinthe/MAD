function y=pergram(x,w,pl)
% y=pergram(x,w,pl) ber„knar periodogram. Om andra argument skal„r
% plottas periodogrammet, om andra argumentet vektor, „r detta 
% f”nster. Om tre argument anges plottas periosogrammet

n=length(x);
la=0:2*pi/n:pi;
%x=x-mean(x);
t=1:n;
ex=exp(-i*la'*t);
y=abs(ex*x(:)).^2/n;
ny=length(y);

if nargin>1 
        a=size(w);
        if max(size(w))==1
                plot(la(2:ny),y(2:ny));
        else
                y(1)=0;
                m=length(w);
                ny=length(y);
                z=[y(ny:-1:2); y];
                w1=[w(m:-1:2) w];
                w1=w1/sum(w1);
                for k=0:ny-m
                        id=z(ny+k-m+1:ny+k+m-1);
                        y(k+1)=w1*id(:);
                        if k<m, y(k+1)=y(k+1)/(1-w1(m-k)); end
                end
                y=y/(2*pi);
                if nargin==3, plot(la,y); end
        end
end

