function [steps, trajec, z] = q1c()
threhold = 0.0001;
max_step = 10000;
trajec = zeros(max_step, 2);
% initialize random start position
trajec(1, :) = [-0.5, 0.5];
z = zeros(max_step, 1);
for i = 1:max_step
    current_x = trajec(i, 1);
    current_y = trajec(i, 2);
    z(i) = (1 - current_x)^2 + 100 * (current_y - current_x^2)^2;
    if (z(i) <= threhold)
        break;
    end
    grad_x = 2 * current_x - 2 + 400 * current_x * (current_x^2 - current_y);
    grad_y = 200 * (current_y - current_x^2);
    H = [2 + 1200 * current_x^2 - 400 * current_y, -400 * current_x;
        -400 * current_x, 200];
    delta = -inv(H) * [grad_x; grad_y];
    next_x = current_x + delta(1);
    next_y = current_y + delta(2);
    trajec(i+1, :) = [next_x, next_y];
end
steps = i;
trajec = trajec(1:i, :);
z = z(1:i);
hold on;
plot(trajec(1:steps, 1), trajec(1:steps, 2), 'b+');
plot(trajec(1:steps, 1)', trajec(1:steps, 2)');
plot(1:steps, z);
hold off;
end