function [net, acc_train, acc_val] = q3a(epochs)

path = 'group_2';
[class0training, class0validate, class1training, class1validate] = loadimages(path);

training = [class0training class1training];

% shuffle the training set
training = training(:, randperm(size(training, 2))');

training_input = training(1:1024, :);
training_label = training(1025, :);

net = perceptron;
net = configure(net, training_input, training_label);

% initialize the weight and bias
net.b{1} = 1;
net.IW{1, 1} = ones(1, 1024);

net.trainParam.epochs = epochs;
net = train(net, training_input, training_label);

pred_train = net([class0training(1:1024, :) class1training(1:1024, :)]);
acc_train = 1- mean(abs([class0training(1025, :) class1training(1025, :)] - pred_train));

pred_val = net([class0validate(1:1024, :) class1validate(1:1024, :)]);
acc_val = 1- mean(abs([class0validate(1025, :) class1validate(1025, :)] - pred_val));

end


