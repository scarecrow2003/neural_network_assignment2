function [net, acc_train, acc_val] = q3e(epochs)

path = 'group_2';
[class0training, class0validate, class1training, class1validate] = loadimages(path);

all = [class0training(1:1024, :), class0validate(1:1024, :), class1training(1:1024, :), class1validate(1:1024, :)];
input_mean = mean(all, 2);
input_variance = var(all, 0, 2);

% implicit expansion of arrays with compatible sizes
class0training = [(class0training(1:1024, :) - input_mean)./input_variance; class0training(1025, :)];
class0validate = [(class0validate(1:1024, :) - input_mean)./input_variance; class0validate(1025, :)];
class1training = [(class1training(1:1024, :) - input_mean)./input_variance; class1training(1025, :)];
class1validate = [(class1validate(1:1024, :) - input_mean)./input_variance; class1validate(1025, :)];

training = [class0training class1training];

net = patternnet(10);
net.divideFcn = 'dividetrain';
net.performParam.regularization = 0.23;
net.trainParam.epochs = 100;

acc_train = zeros(epochs, 1);
acc_val = zeros(epochs, 1);

for i = 1:epochs
    % shuffle the training set
    training = training(:, randperm(size(training, 2))');
    
    net = adapt(net, training(1:1024, :), training(1025, :));
    
    pred_train = net([class0training(1:1024, :) class1training(1:1024, :)]);
    acc_train(i) = 1- mean(abs([class0training(1025, :) class1training(1025, :)] - pred_train));

    pred_val = net([class0validate(1:1024, :) class1validate(1:1024, :)]);
    acc_val(i) = 1- mean(abs([class0validate(1025, :) class1validate(1025, :)] - pred_val));

end

hold on;
plot(1:epochs, acc_train);
plot(1:epochs, acc_val);
hold off;

end


