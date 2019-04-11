clear all;

N = 100;
% Random_Vector = (binornd(50,0.5,[1 N]))';
Random_Vector = [27; 27; 27; 15; 31; 25; 25; 28; 24; 20; 30; 30; 24; 25; 20; 23; 26; 23; 28; 23; 27; 26; 19; 26; 19; 28; 26; 23; 27; 24; 22; 27; 23; 22; 25; 27; 25; 23; 19; 30; 24; 22; 25; 25; 28; 23; 28; 23; 17; 25; 29; 26; 27; 27; 23; 23; 26; 22; 23; 26; 23; 18; 23; 26; 24; 24; 23; 32; 24; 25; 26; 22; 25; 20; 19; 25; 19; 26; 26; 23; 16; 28; 28; 27; 24; 25; 21; 23; 24; 26; 26; 23; 27; 30; 27; 18; 27; 32; 24; 28]
[mu, variance] = binostat(50,0.5);   % подсчет теоретического матожидания и дисперсии
sigma = sqrt(variance);          
X_ = mean(Random_Vector);       
S = std(Random_Vector);
cdfplot(Random_Vector)
hold on 
plot(Random_Vector,normcdf(Random_Vector, X_, S),'r+')
hold off 
alpha = 0.05; 
% 'Критерий Колмогорова-Смирнова. Теоретическая нормальность '
[ks_norm_H_1,ks_norm_P_1,ks_norm_KSSTAT_1,ks_norm_CV_1] = kstest(Random_Vector, [Random_Vector normcdf(Random_Vector,mu, sigma)], alpha);
% 'Критерий Колмогорова-Смирнова. Теоретическая на хи квадрат '
[ks_chi_H_1,ks_chi_P_1,ks_chi_KSSTAT_1,ks_chi_CV_1] = kstest(Random_Vector, [Random_Vector binocdf(Random_Vector, 50,0.5)], alpha);
{Random_Vector binocdf(Random_Vector, X_,0.5), alpha}
nbins = 15;

% 'Критерий ХИ квадрат. Эмпирическая нормальность'
[CHI_norm_H_2,CHI_norm_p_2,CHI_norm_st_2] = chi2gof(Random_Vector,'cdf',{@normcdf,X_,S},'nparams', 2, 'alpha', alpha, 'emin', 0, 'nbins', nbins);
fprintf('Выбранная гипотеза H%d\n', CHI_norm_H_2);
fprintf('Количество областей %d \n', nbins);  
fprintf('Значение статистики %i \n', CHI_norm_st_2.chi2stat);  
fprintf('Количество степеней свободы %d \n', CHI_norm_st_2.df);
fprintf('alpha %i \n', CHI_norm_p_2); 

% 'Критерий ХИ квадрат. Теоретическая на хи квадрат'
[CHI_chi_H_1,CHI_chi_p_1,CHI_chi_st_1] = chi2gof(Random_Vector,'cdf',{@binocdf, 50,0.5},'nparams', 2,'alpha', alpha, 'emin', 0,  'nbins', nbins);
fprintf('Выбранная гипотеза H%d\n', CHI_chi_H_1);
fprintf('Количество областей %d \n', nbins);  
fprintf('Значение статистики %i \n', CHI_chi_st_1.chi2stat);  
fprintf('Количество степеней свободы %d \n', CHI_chi_st_1.df);
fprintf('alpha %i \n', CHI_chi_p_1); 

% 'Критерий ХИ квадрат. Эмпирическая на хи квадрат'
[CHI_chi_H_2,CHI_chi_p_2,CHI_chi_st_2] = chi2gof(Random_Vector,'cdf',{@binocdf,X_,S},'nparams',2, 'alpha', alpha, 'emin', 0, 'nbins', nbins);
fprintf('Выбранная гипотеза H%d\n', CHI_chi_H_2);
fprintf('Количество областей %d \n', nbins);  
fprintf('Значение статистики %i \n', CHI_chi_st_2.chi2stat);  
fprintf('Количество степеней свободы %d \n', CHI_chi_st_2.df);
fprintf('alpha %i \n', CHI_chi_p_2);  


