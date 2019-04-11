clear;

zz = [
259,00
177,00
246,00
230,00
211,00
353,00
157,00
26,00
271,00
360,00
205,00
272,00
221,00
295,00
281,00
405,00
149,00
143,00
116,00
43,00
99,00
161,00
105,00
66,00
49,00
18,00
30,00
5,00
8,00
4,00
1,00
19,00
41,00
168,00
66,00
121,00
207,00
173,00
208,00
284,00
278,00
240,00
197,00
141,00
228,00
196,00
161,00
210,00
265,00
119,00
131,00
359,00
208,00
142,00
382,00
640,00
900,00
832,00
349,00
318,00
340,00
448,00
274,00
269,00
410,00
429,00
348,00
362,00
174,00
538,00
738,00
541,00
504,00
695,00
1320,00
715,00
84,00
158,00
144,00
255,00
228,00
131,00
291,00
122,00
119,00
207,00
164,00
53,00
160,00
168,00
141,00
370,00
184,00
321,00
168,00
99,00
184,00
126,00
327,00
173,00
182,00
159,00
244,00
238,00
155,00
281,00
200,00
263,00
214,00
123,00
251,00
226,00
170,00
167,00
210,00
172,00
188,00
165,00
198,00
327,00
346,00
229,00
188,00
256,00
494,00
689,00
730,00
767,00
448,00
219,00
];

timeSeries = zz(:,1);

plot(timeSeries)
boxcox_timeSeries = boxcoxf(timeSeries, 0);
plot(boxcox_timeSeries)

y = boxcox_timeSeries;
xi = 0:1:129;
xi = xi';
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
% disp(tpcount(0), tpstat, tp_p)
% disp(rankcount, rankstat, rank_p)
% disp(diffcount, diffstat, diff_p)
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
