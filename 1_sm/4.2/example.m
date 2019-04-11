clear;

zz = [
315963,00
316643,00
203471,00
207833,00
355672,00
257786,00
354884,00
271402,00
182622,00
69498,00
184950,00
203404,00
418389,00
516964,00
482212,00
217611,00
88758,00
105517,00
177376,00
237988,00
179221,00
110596,00
140754,00
304794,00
542095,00
237855,00
226009,00
285292,00
272981,00
291594,00
195385,00
252574,00
111118,00
228426,00
167997,00
188723,00
173525,00
157739,00
140513,00
205253,00
130429,00
198071,00
288885,00
315083,00
224567,00
216453,00
249300,00
226794,00
261561,00
267067,00
390573,00
351314,00
429805,00
412447,00
398680,00
424420,00
471568,00
293660,00
364991,00
394251,00
438043,00
266788,00
223849,00
491677,00
464814,00
510677,00
512284,00
522786,00
751321,00
667849,00
590381,00
557542,00
531539,00
475782,00
500749,00
557439,00
336028,00
346644,00
296893,00
302827,00
295116,00
329642,00
399596,00
415236,00
462325,00
486296,00
502225,00
473203,00
350329,00
288699,00
246094,00
249228,00
408842,00
429121,00
202055,00
234410,00
416811,00
737196,00
269506,00
368150,00
315193,00
317667,00
345001,00
343181,00
314863,00
289476,00
411914,00
559027,00
658747,00
633237,00
495852,00
406285,00
372981,00
376646,00
374425,00
401549,00
341930,00
294652,00
173595,00
139308,00
177364,00
440393,00
525250,00
325305,00
329519,00
293207,00
377559,00
539596,00
581981,00
517138,00
443783,00
354574,00
281660,00
298308,00
437163,00
562880,00
376961,00
461385,00
543476,00
523603,00
583689,00
655287,00
613276,00
740660,00
542975,00

]

timeSeries = zz(:,1)

plot(timeSeries)
boxcox_timeSeries = boxcoxf(timeSeries, 0);
plot(boxcox_timeSeries)

y = boxcox_timeSeries
xi = 0:1:144;
xi = xi'
N = 2; % степень
coeff1 = polyfit(xi,y, N);
y2 = 0;
for k=0:N
    y2 = y2 + coeff1(N-k+1) * xi.^k;
end
hold on; plot(xi, y2, 'r');
%Проверка гипотез о случайности ряда
[tpcount, tpstat,tp_p] = tptest(boxcox_timeSeries);
[rankcount, rankstat,rank_p] = ranktest(boxcox_timeSeries);
[diffcount, diffstat,diff_p] = diffsign(boxcox_timeSeries);
% аппроксимация тренда с использованием полинома второй степени
[elec_c,elec_m,elec_z] = smoothpf(boxcox_timeSeries,2);
figure;
plot(boxcox_timeSeries);
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
[tpcount, tpstat, tp_p] = tptest(elecSeason);
[rankcount, rankstat, rank_p] = ranktest(elecSeason);
[diffcount, diffstat, diff_p] = diffsign(elecSeason);

% графики функций автокорреляции, частной автокорреляции
g_1 = acvf(elecSeason);
acf(g_1,true);
pacf(g_1,length(g_1),true,true);
 
% Оценка параметров модели
[fi, theta, s2] = mlest6(elecSeason, 17, 9);
s2x = var(elecSeason);
q =  1 - s2/s2x ;
pred_len = 15;
Y = [];
for i = 1:pred_len
    [Y(i),se2] = predarma(elecSeason, fi , theta, s2,i);
end
n = length(timeSeries);
hold on 
plot(1:n, timeSeries(1:n), 'k');
plot(n - pred_len:n,exp([ log(timeSeries(n - pred_len)) Y + elec_S(1:pred_len)' + polyval(elec_c(3:-1:1,1),(n - pred_len + 1):n) ]) , 'r--');
