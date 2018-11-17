% param1 - первая характеристика для анализа зависимости;
% param2 - вторая характеристика для анализа зависимости;
% n - мощность бутстреп выборки;
param1 = Displacement;
param2 = Acceleration;
n = 100;
% Построение графика зависимости:
figure(1)
plot(param1, param2, '+')
lsline
xlabel('Displacement')
ylabel('Acceleration')
% Вычисляем коэффициент корреляции:
rhohat = corr(param1, param2, 'rows', 'pairwise')

% Построим бутстреп выборку:
rhos = bootstrp(n,@(x,y)corr(x,y,'rows', 'pairwise'),param1,param2);

% Построим гистограмму бутстреп выборки:
figure(2)
hist(rhos,25)
set(get(gca, 'Children'), 'Facecolor', [.9 .9 1])

% Построим доверительный интервал для оценки коэффициента корреляции 
% с доверительной вероятностью 0,75:
ci_normal = bootci(n, {@(x,y)corr(x,y,'rows', 'pairwise'),param1,param2}, 'alpha', 0.25, 'type' , 'normal')
ci_per = bootci(n, {@(x,y)corr(x,y,'rows', 'pairwise'),param1,param2}, 'alpha', 0.25, 'type', 'per')
ci_cper = bootci(n, {@(x,y)corr(x,y,'rows', 'pairwise'),param1,param2}, 'alpha', 0.25, 'type' , 'cper')

% Укажем их на графике зависимости:
figure(3)
plot(param1, param2, '+')
lsline
hold on
plot(x,ci_normal(1)*x)
xlabel('Displacement')
ylabel('Acceleration')

% Подсчитаем выборочные моменты m2, m3,m4:
m1 = moment(rhos,1)
m2 = moment(rhos,2)
m3 = moment(rhos,3)
m4 = moment(rhos,4)

% Подсчитаем коэффициент ассиметрии и коэффициент эксцесса:
betta1 = (m3^2)/(m2^3)
betta2 = m4/(m2^2)
kappa = betta1*(betta2+3)^2/(4*(betta2-3*betta1-6)*(4*betta2-3*betta1))

mu1 = mean(rhos(:,1))
var1 = std(rhos(:,1))

% Наложим на диаграмму график нормального распределения:
figure(4)
hist(rhos,25);
set(get(gca, 'Children'), 'Facecolor', [.9 .9 1]);
hold on;
x = (-0.66:0.0001:-0.46);
Y = normpdf(x,mu1,var1);
plot(x,Y,'r');