clear;

epsilon= normrnd(0,1,110,1);%вспомогательный ряд
a=0.5; b=0.5; w=0.9; p=5; q=1; t=1:100;
 
Y1=epsilon(1:100); %y = ? , ? ~ N(0,1)
Y2=a*t'+Y1;
Y3=b*sin(w*t')+Y1;

%AP
Y4 = epsilon;% случайная составляющая
for i = 6:length(Y4) % генерация зависимостей
    for j=1:p
        Y4(i) = a*Y4(i-j) + Y4(i);
    end
end
Y4 = Y4(11:110);%удаляем первые 10 наблюдений

%CC
Y5=epsilon(6:105,1);% случайная составляющая
for i=1:p
    Y5 = Y5+a*epsilon(i:99+i,1);% генерация зависимостей
end

figure;
plot(Y1);
title('Y1');

figure;
plot(Y2);
title('Y2');

figure;
plot(Y3);
title('Y3');

figure;
plot(Y4);
title('Y4');

figure;
plot(Y5);
title('Y5');

Y = [Y1 Y2 Y3 Y4 Y5 ];
%критерий на основе знаков разностей
Ds=zeros(1,5);
ts_Ds=zeros(1,5);
Ds_p = zeros(1,5);

%критерий на основе знаков разностей
Ds=zeros(1,5);
ts_Ds=zeros(1,5);
[Ds(1), ts_Ds(1)]=diffsign(Y1);
[Ds(2), ts_Ds(2)]=diffsign(Y2);
[Ds(3), ts_Ds(3)]=diffsign(Y3);
[Ds(4), ts_Ds(4)]=diffsign(Y4);
[Ds(5), ts_Ds(5)]=diffsign(Y5);
for i=1:5
    normcdf(ts_Ds(i), 0, 1)
 if(0.025<normcdf(ts_Ds(i), 0, 1)&&normcdf(ts_Ds(i), 0, 1)<0.9725)
 else fprintf('Y%i не соответствует уровню значимости',i);
 end
end


%критерий на основе ранговой корреляции
Rt=zeros(1,5);
ts_Rt=zeros(1,5);
Theta=zeros(1,5);
[Rt(1), ts_Rt(1),Theta(1)]=ranktest(Y1);
[Rt(2), ts_Rt(2),Theta(2)]=ranktest(Y2);
[Rt(3), ts_Rt(3),Theta(3)]=ranktest(Y3);
[Rt(4), ts_Rt(4),Theta(4)]=ranktest(Y4);
[Rt(5), ts_Rt(5),Theta(5)]=ranktest(Y5);
for i=1:5
    normcdf(ts_Rt(i), 0, 1)
 if(0.025<normcdf(ts_Rt(i), 0, 1)&&normcdf(ts_Rt(i), 0, 1)<0.9725)
 else  fprintf('Y%i не соответствует уровню значимости',i);
 end
end


%критерий на основе поворотных точек
Tp=zeros(1,5);
ts_Tp=zeros(1,5);
[Tp(1), ts_Tp(1)]=tptest(Y1);
[Tp(2), ts_Tp(2)]=tptest(Y2);
[Tp(3), ts_Tp(3)]=tptest(Y3);
[Tp(4), ts_Tp(4)]=tptest(Y4);
[Tp(5), ts_Tp(5)]=tptest(Y5);
for i=1:5
    normcdf(ts_Tp(i), 0, 1)
 if(0.025<normcdf(ts_Tp(i), 0, 1)&&normcdf(ts_Tp(i), 0, 1)<0.9725)
 else  fprintf('Y%i не соответствует уровню значимости',i);
 end
end



Rt=zeros(1,5);
ts_Rt=zeros(1,5);
Theta=zeros(1,5);
[Rt(1), ts_Rt(1),Theta(1)]=ranktest(Y1);
[Rt(2), ts_Rt(2),Theta(2)]=ranktest(Y2);
[Rt(3), ts_Rt(3),Theta(3)]=ranktest(Y3);
[Rt(4), ts_Rt(4),Theta(4)]=ranktest(Y4);
[Rt(5), ts_Rt(5),Theta(5)]=ranktest(Y5);
for i=1:5
    normcdf(ts_Rt(i), 0, 1)
 if(0.025<normcdf(ts_Rt(i), 0, 1)&&normcdf(ts_Rt(i), 0, 1)<0.9725)
 else  fprintf('Y%i не соответствует уровню значимости',i);
 end
end

% % % % % % % % % % % 
Y1_spec = specdens(acvf(Y1),1);

g = acvf(Y1);
figure;
acf(g,1);
title('Выборочная автокорреляционная функция')

figure;
pacf(g,length(g),1,1);
title('Выборочная частная автокорреляционная функция')
% % % % % % % % % % % % % % % % 

Y1_spec = specdens(acvf(Y2),1);

g = acvf(Y2);
figure;
acf(g,1);
title('Выборочная автокорреляционная функция')

figure;
pacf(g,length(g),1,1);
title('Выборочная частная автокорреляционная функция')
% % % % % % % % % % % % % % % % 
Y1_spec = specdens(acvf(Y3),1);

g = acvf(Y3);
figure;
acf(g,1);
title('Выборочная автокорреляционная функция')

figure;
pacf(g,length(g),1,1);
title('Выборочная частная автокорреляционная функция')
% % % % % % % % % % % % % % % % 
Y1_spec = specdens(acvf(Y4),1);

g = acvf(Y4);
figure;
acf(g,1);
title('Выборочная автокорреляционная функция')

figure;

pacf(g,length(g),1,1);
title('Выборочная частная автокорреляционная функция')
% % % % % % % % % % % % % % % % 
Y1_spec = specdens(acvf(Y5),1);

g = acvf(Y5);
figure;
acf(g,1);
title('Выборочная автокорреляционная функция')

figure;
pacf(g,length(g),1,1);
title('Выборочная частная автокорреляционная функция')
% % % % % % % % % % % % % % % % 
