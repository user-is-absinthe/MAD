clear;

image_fname = 'pic.jpg';
% �������� �����������
Image = imread(strcat(image_fname));
img = double(Image);
[M, N, k] = size(img);

X = reshape(img, M * N, 3 );
maxk = 10; % ����������� �� ������������ ���������� ��������� �����
logL = zeros(1, maxk);
BIC = zeros(1, maxk);
AIC = zeros(1, maxk);
obj = cell(1, maxk);

for k = 1:maxk
    disp(fprintf('������ ���������� ����� ������������� �� %d ���������...',k))
    obj{k} = gmdistribution.fit(X, k, 'Options', statset('MaxIter', 250), 'Regularize', 10^-7); 
    logL(k) = -obj{k}.NlogL;
    BIC(k) = obj{k}.BIC;   
    AIC(k) = obj{k}.AIC;
end

figure;
plot(logL, 'k');
title('������ �������� ��������� ������� �������������');
figure;
plot(AIC, 'k');
title('AIC');
figure;
plot(BIC, 'k');
title('BIC');

classes_count = min(max(1, input('������� ���������� �������: ')), maxk);
ver = posterior(obj{classes_count}, X); % ������������� ����������� ��������� � �������
class = zeros(M * N, 1);

for i = 1:M * N
    [a, b] = max(ver(i,:));
    class(i, 1) = b;
end

Y = ones(M, N, 3);
labels_color_map = jet(classes_count);

for i = 1: M
    for j = 1: N
        label = class((j - 1) * size(img, 1) + i);
        Y(i, j, 1:end) = labels_color_map(label, 1:end);
    end
end

imwrite(Y, strcat('result_', image_fname));
figure;
imshow(Y);

for class_num = 1 : classes_count
    figure;
    hist(X(find(class==class_num), :));
    title(sprintf('����������� ��� %i ��������', class_num));
end

figure;
hold on

% ��������� �������� ���������� ��� �������� �������� � ����������
% ��������� ����� � ������� �������� ������
ci_per = [];

for k = 1:6
    f = @(x)log(gmdistribution.fit(x,k+1,'Options',statset('MaxIter',150), 'Regularize', 10^-7).NlogL/gmdistribution.fit(x,k,'Options',statset('MaxIter',150), 'Regularize', 10^-7).NlogL);
    ci_per = [ci_per bootci(30, {f, X}, 'alpha', 0.05, 'type', 'cper')];
    disp(k);
end

% ����� �������� �������� ���������� S (� ����� ������
% ������� f), ���������� � ������� �������� ������(� ���������� boot), �
% �������� ����������� ���������� �� ������������� �������� ������
for i = 1:6
    data(i) = log(obj{i+1}.NlogL/obj{i}.NlogL);
end

figure
hold on
plot(data,'-k');
plot(ci_per(1,:),'--r')
plot(ci_per(2,:),'--r')
title('������ ���������� S, ���������� �������� ������� � �� �������');
figure
hist(X);
title('����������� �������������');
