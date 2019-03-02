function [net, acc_train, acc_val] = train_seq(n)
n=10
x = [ones(1, 65); (-1.6:0.05:1.6)];
y = 1.2 * sin(pi * x(2, :)) - cos(2.4 * pi * x(2, :));

net = patternnet(n);
net.trainparam.lr = 0.01;
net.trainparam.epochs = 1000;
for i = 1 : 1000
    [net, a, e, pf] = adapt(net, num2cell(x, 1), num2cell(y, 1));
end

xtest = [ones(1, 321); (-1.6:0.01:1.6)];
ytest = net(xtest);

hold on;
plot(x, y);
plot(xtest, ytest);
hold off;