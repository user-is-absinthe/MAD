% n9: Weight – Horsepower

clear;

load carbig;

% del_from_HSPWR = [];
% for i = 1 : length(Horsepower)
%     if isnan(Horsepower(i)) %== NaN
%        del_from_HSPWR = [del_from_HSPWR, i];
%     end
% end
% 
% i = length(del_from_HSPWR);
% while i > 0
%     Horsepower(del_from_HSPWR(i)) = [];
% end
% 
% del_from_WEIGTH = [];
% for i = 1 : length(Weight)
%     if isnan(Weight(i)) %== NaN
%        del_from_WEIGTH = [del_from_WEIGTH, i];
%     end
% end

good_hrspwr = [];
good_weight = [];

for i = 1 : length(Horsepower)
   if and(not(isnan(Horsepower(i))), not(isnan(Weight(i))))
       good_hrspwr = [good_hrspwr, Horsepower(i)];
       good_weight = [good_weight, Weight(i)];
   end
end

plot(good_weight, good_hrspwr, '.');
lsline;

rhohat = corr(good_weight, good_hrspwr);

rhos1000 = bootstrp(1000, 'corr', good_weight, good_hrspwr);

hist(rhos1000,30);
set(get(gca,'Children'),'FaceColor',[.8 .8 1])

