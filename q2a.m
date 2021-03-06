function net = q2a(n)

x = -1.6:0.05:1.6;
y = 1.2 * sin(pi * x) - cos(2.4 * pi * x);
xtest = -1.6:0.01:1.6;
ytest = 1.2 * sin(pi * xtest) - cos(2.4 * pi * xtest);

epochs = 10000;
net = feedforwardnet(n, 'trainlm');
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
net = configure(net, x, y);
net.trainParam.lr = 0.01;
net.trainParam.epochs = epochs;
net.trainParam.goal = 1e-8;
net.divideParam.trainRatio = 1;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;

for i = 1:epochs
    display(['Epoch: ', num2str(i)]);
    idx = randperm(length(x)); % shuffle the input
    net = adapt(net, num2cell(x(idx), 1), num2cell(y(idx), 1));
end

yresult = sim(net, xtest);

hold on;
plot(xtest, ytest, 'b+');
plot(xtest, yresult, 'r-');
hold off;

end


