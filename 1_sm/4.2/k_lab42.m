elec = load('elec.tsm');
plot(elec)
elec = boxcoxf(elec,0);
plot(elec)
%Проверка гипотез о случайности ряда
[tpcount, tpstat,tp_p] = tptest(elec);
[rankcount, rankstat,rank_p] = ranktest(elec);
[diffcount, diffstat,diff_p] = diffsign(elec);
% аппроксимация тренда с использованием полинома второй степени
[elec_c,elec_m,elec_z] = smoothpf(elec,2);
figure;
plot(elec);
hold on;
plot(elec_m);
figure;
plot(elec_z);

% графики функций спектра
elec_spec = specdens(acvf(elec_z),true);
[max_spec, max_spec_ind] = max(elec_spec);
T = 2*pi*100/max_spec_ind;

% Выделение сезонной составляющей
[elecSeason, elec_S] = seascomp(elec_z,round(T));
plot(elec_S);
plot(elecSeason);

%Проверка гипотез о случайности очищенного ряда
[tpcount, tpstat,tp_p] = tptest(elecSeason);
[rankcount, rankstat,rank_p] = ranktest(elecSeason);
[diffcount, diffstat,diff_p] = diffsign(elecSeason);

% графики функций автокорреляции, частной автокорреляции
g_1 = acvf(elecSeason);
acf(g_1,true);
pacf(g_1,length(g_1),true,true);

% Оценка параметров модели
[fi, theta, s2] = mlest6(elecSeason, 2, 25);
s2x = var(elecSeason);
q =  1 - s2/s2x ;
for i = 1:12
    [Y(i),se2] = predarma(elecSeason, fi , theta, s2,i);
end;
elec = load('elec.tsm');
n = length(elec);
hold on 
plot(1:n, elec(1:n), 'k');
plot(n:(n+12),exp([ log(elec(n)) Y + elec_S(1:12)' + polyval(elec_c(3:-1:1,1),(n+1):(n+12)) ]) , 'k--');

