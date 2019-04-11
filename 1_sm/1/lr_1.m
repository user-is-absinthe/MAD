% вариант 9
clear;
load carbig;

good_Acceleration = []; % первая характеристика
good_Horsepower = []; % вторая характеристика
n = 1000; % размер бутстреп выборки; 100

good = 0;
for i = 1 : length(Horsepower)
   if and(not(isnan(Horsepower(i))), not(isnan(Weight(i))))
       good_Acceleration = [good_Acceleration, Acceleration(i)];
       good_Horsepower = [good_Horsepower, Horsepower(i)];
       good = good + 1;
   end
end
good_Acceleration = good_Acceleration';
good_Horsepower = good_Horsepower';
bad = length(Horsepower) - good;

% постороение графика
figure(1)
plot(good_Acceleration, good_Horsepower, '+')
lsline
xlabel('Acceleration')
ylabel('Horsepower')

% Вычисляем коэффициент корреляции:
rhohat = corr(good_Acceleration, good_Horsepower, 'rows', 'pairwise');

% Построим бутстреп выборку:
rhos = bootstrp(n,@(x,y)corr(x,y,'rows', 'pairwise'),good_Acceleration,good_Horsepower); % n = 500

% Построим гистограмму бутстреп выборки:
figure(2)
hist(rhos,25)
set(get(gca, 'Children'), 'Facecolor', [.9 .9 1])

% Построим доверительный интервал для оценки коэффициента корреляции 
% с доверительной вероятностью 0,75:
prohability = 1 - 0.75;
ci_normal = bootci(n, {@(x,y)corr(x,y,'rows', 'pairwise'),good_Acceleration,good_Horsepower}, 'alpha', prohability, 'type' , 'normal');
ci_per = bootci(n, {@(x,y)corr(x,y,'rows', 'pairwise'),good_Acceleration,good_Horsepower}, 'alpha', prohability, 'type', 'per');
ci_cper = bootci(n, {@(x,y)corr(x,y,'rows', 'pairwise'),good_Acceleration,good_Horsepower}, 'alpha', prohability, 'type' , 'cper');

% Укажем их на графике зависимости:
figure(3)
plot(good_Acceleration, good_Horsepower, '+')
lsline
hold on
x = (-0.66:0.0001:-0.46);
plot(x,ci_normal(1)*x)
xlabel('Acceleration')
ylabel('Horsepower')

% Подсчитаем выборочные моменты m2, m3,m4:
m1 = moment(rhos,1);
m2 = moment(rhos,2);
m3 = moment(rhos,3);
m4 = moment(rhos,4);

% Подсчитаем коэффициент ассиметрии и коэффициент эксцесса:
betta1 = (m3^2)/(m2^3);
betta2 = m4/(m2^2);
kappa = betta1*(betta2+3)^2/(4*(betta2-3*betta1-6)*(4*betta2-3*betta1));
mu1 = mean(rhos(:,1));
var1 = std(rhos(:,1));

% Наложим на диаграмму график нормального распределения:
figure(4)
histfit(rhos, 25);
% hist(rhos,25);
% set(get(gca, 'Children'), 'Facecolor', [.9 .9 1]);
% hold on;
% x = (-0.76:0.0001:-0.617);
% % Y = normpdf(x,mu1,var1);
% Y = normpdf(x, 0, sqrt(1));
% plot(x,Y,'r');
