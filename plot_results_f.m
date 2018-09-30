function [  ] = plot_results_f( T, capital_path, consumption_path, output_path, investment_path, k_star, c_star, sigma, fig_num)

time = 1:T+1;

figure(fig_num)
set(gcf, 'Name', sprintf('sigma = %d', sigma))
set(gcf, 'Position', [50, 50, 1000, 500])
subplot(2,2,1);
hold on
plot(time, capital_path, 'magenta', 'LineWidth', 2)
plot(time, ones(1, T+1)*k_star, 'color', 'black');
xlabel('Time')
ylabel('k_t')
tit = sprintf('Capital path for sigma = %d', round(sigma));
title(tit)
hold off

subplot(2,2,2);
hold on
plot(time, consumption_path, 'LineWidth', 2)
plot(time, ones(1, T+1)*c_star, 'color', 'black');
xlabel('Time')
ylabel('c_t')
tit = sprintf('Consumption path for sigma = %d', round(sigma));
title(tit)
hold off

subplot(2,2,3);
hold on
plot(time, output_path, 'color', 'red')
xlabel('Time')
ylabel('y_t')
tit = sprintf('Output path for sigma = %d', round(sigma));
title(tit)
hold off

subplot(2,2,4);
hold on
plot(time, investment_path, 'color', 'green')
xlabel('Time')
ylabel('x_t')
tit = sprintf('Investment path for sigma = %d', round(sigma));
title(tit)
hold off

end

