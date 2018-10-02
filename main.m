%%

clear
close all
clc

% INITIAL PARAMETERS
beta=0.96;
alpha=0.4;
delta=0.08;

ss_capital = @(sigma, beta, alpha, delta) (alpha/(1/beta+delta-1))^(1/(1-alpha));

%% 
clc
% FOR SIGMA = 1
disp('============================')
disp('sigma = 1')
disp('============================')

% INITIAL PARAMETERS
sigma = 1;
verbose = 0;

k1 = ss_capital(sigma, beta, alpha, delta)*0.75;
c1_upper = k1^alpha+(1-delta)*k1;

c1 = 0;
interval = [0, c1_upper];

tic

for n = 1:100
    c1 = (interval(1)+interval(2))/2;
    [~, ~, ~, ~, diff_k, ~, ~, ~] = planning_problem_f(c1, sigma, verbose);
    if diff_k < 0 && isreal(diff_k)==1
        interval=[c1, interval(2)];
    elseif diff_k>0 || isreal(diff_k)==0
        interval=[interval(1), c1];
    else
        disp('error')
        disp(diff_k)
    end
    
    if abs(diff_k)<1e-5
        status = sprintf('loop stopped at iteration %d \n', n);
        disp(status)
        break
    end
end

verbose = 1;
[k_star, c_star, capital_path, consumption_path, diff_k, diff_c, output_path, investment_path] = planning_problem_f(c1, sigma, verbose);

% DISPLAY RESULTS
disp('capital convergence status')
disp(abs(diff_k)<1e-5)
disp('consumption convergence status')
disp(abs(diff_c)<1e-5)
format long
disp('final c0')
disp(c1)

toc

% PLOT IT!!!
T=100;
plot_results_f(T, capital_path, consumption_path, output_path, investment_path, k_star, c_star, sigma, 1)

% rename results for latter comparison

capital_path1 = capital_path;
consumption_path1 = consumption_path;
output_path1 = output_path;
investment_path1 = investment_path;

%%
% FOR SIGMA = 2
disp('============================')
disp('sigma = 2')
disp('============================')

% INITIAL PARAMETERS
sigma = 2;
verbose = 0;

k1 = ss_capital(sigma, beta, alpha, delta)*0.75;
c1_upper = k1^alpha+(1-delta)*k1;

c1 = 0;
interval = [0, c1_upper];

tic

for n = 1:50
    c1 = (interval(1)+interval(2))/2;
    [~, ~, ~, ~, diff_k, ~, ~, ~] = planning_problem_f(c1, sigma, verbose);
    if diff_k < 0 && isreal(diff_k)==1
        interval=[c1, interval(2)];
    elseif diff_k>0 || isreal(diff_k)==0
        interval=[interval(1), c1];
    else
        disp('error')
        disp(diff_k)
    end
    
    if abs(diff_k)<1e-5
        status = sprintf('loop stopped at iteration %d \n', n);
        disp(status)
        break
    end
end

verbose = 1;
[k_star, c_star, capital_path, consumption_path, diff_k, diff_c, output_path, investment_path] = planning_problem_f(c1, sigma, verbose);

% DISPLAY RESULTS
disp('capital convergence status')
disp(abs(diff_k)<1e-5)
disp('consumption convergence status')
disp(abs(diff_c)<1e-5)
format long
disp('final c0')
disp(c1)

toc

% PLOT IT!!!
T=100;
plot_results_f(T, capital_path, consumption_path, output_path, investment_path, k_star, c_star, sigma, 2)

% rename results for latter comparison

capital_path2 = capital_path;
consumption_path2 = consumption_path;
output_path2 = output_path;
investment_path2 = investment_path;

%%

% COMPARISON OF BOTH PATHS

% PREPARING DATA
capital_path(1,:) = capital_path1;
capital_path(2,:) = capital_path2;

consumption_path(1,:) = consumption_path1;
consumption_path(2,:) = consumption_path2;

output_path(1,:) = output_path1;
output_path(2,:) = output_path2;

investment_path(1,:) = investment_path1;
investment_path(2,:) = investment_path2;

T=100;
time=1:T+1;

% PLOT IT!!!

figure(3)
set(gcf, 'Position', [50 50 1100, 600], 'Name', 'Both sigmas')

subplot(2,2,1)
hold on
plot(time, capital_path)
xlabel('Time')
ylabel('k_t')
title('Capital paths for both \sigmas')
legend('sigma=1', 'sigma=2', 'Location', 'southeast')
hold off

subplot(2,2,2)
hold on
plot(time, consumption_path)
xlabel('Time')
ylabel('c_t')
title('Consumption paths for both \sigmas')
legend('sigma=1', 'sigma=2', 'Location', 'southeast')
hold off

subplot(2,2,3)
hold on
plot(time, output_path)
xlabel('Time')
ylabel('y_t')
title('Output paths for both \sigmas')
legend('sigma=1', 'sigma=2', 'Location', 'southeast')
hold off

subplot(2,2,4)
hold on
plot(time, investment_path)
xlabel('Time')
ylabel('x_t')
title('Investment paths for both \sigmas')
legend('sigma=1', 'sigma=2', 'Location', 'southeast')
hold off












