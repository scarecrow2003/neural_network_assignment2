function [class0training, class0validate, class1training, class1validate] = loadimages(path)

deer ='deer';
ship = 'ship';
n = 500;
class0data = [zeros(1024, n) ; zeros(1, n)]; %last row be the class label 0
class1data = [zeros(1024, n) ; ones(1, n)]; %last row be the class label 1
for k = 1 : n
    class0filename = sprintf('%s/%s/%03d.jpg', path, ship, k-1);
    class1filename = sprintf('%s/%s/%03d.jpg', path, deer, k-1);
    class0data(1:1024, k) = reshape(rgb2gray(imread(class0filename)), [1024, 1]);
    class1data(1:1024, k) = reshape(rgb2gray(imread(class1filename)), [1024, 1]);
end
class0training = class0data(:, 1:450);
class0validate = class0data(:, 451:500);
class1training = class1data(:, 1:450);
class1validate = class1data(:, 451:500);
end