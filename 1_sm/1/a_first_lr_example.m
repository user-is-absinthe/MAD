clear all;
load lawdata;
plot(lsat,gpa,'+');
lsline;

rhohat = corr(lsat,gpa);

rhos1000 = bootstrp(1000,'corr',lsat,gpa);
hist(rhos1000,30)
set(get(gca,'Children'),'FaceColor',[.8 .8 1])

ci_normal = bootci(1000,{@corr,lsat,gpa}, 'alpha',0.05, 'type', 'normal');

ci_per = bootci(1000,{@corr,lsat,gpa}, 'alpha',0.05, 'type', 'per');

ci_cper = bootci(1000,{@corr,lsat,gpa}, 'alpha',0.05, 'type', 'cper');

