function [ k_star, c_star, capital_path, consumption_path, diff_k, diff_c, output_path, investment_path ]= planning_problem_f( c1, sigma, verbose )

% declaration of known parameters and variables
% sigma=1;
beta=0.96;
alpha=0.4;
delta=0.08;
T=100;

% defining functions
ss_capital = @(sigma, beta, alpha, delta) (alpha/(1/beta+delta-1))^(1/(1-alpha));
ss_consumption = @(k_star, alpha, delta) k_star^alpha-delta*k_star;

update_capital = @(kt, ct, alpha, delta) kt^alpha + (1-delta)*kt - ct;
update_consumption = @(kt1, ct, sigma, beta, alpha, delta) ct*(beta*(alpha*kt1^(alpha-1)+1-delta))^(1/sigma);

% calculating values
k_star = ss_capital(sigma, beta, alpha, delta);
c_star = ss_consumption(k_star, alpha, delta);

if verbose == 1
    disp('The steady state value of capital is:')
    disp(k_star)
    disp('The steady state value of consumption is:')
    disp(c_star)
end 

k1 = 0.75*k_star;
% c1 = 1.349;

% creating consumption and capital paths

capital_path = zeros(1,T+1);
capital_path(1) = k1;
consumption_path = zeros(1, T+1);
consumption_path(1) = c1;

for t = 1:T
    kt = capital_path(t);
    ct = consumption_path(t);
    
    kt1 = update_capital(kt, ct, alpha, delta);
    ct1 = update_consumption(kt1, ct, sigma, beta, alpha, delta);
    
    capital_path(t+1) = kt1;
    consumption_path(t+1) = ct1;
end

last_k = capital_path(length(capital_path));
last_c = consumption_path(length(consumption_path));

% disp(last_k)
diff_k = k_star-last_k;
diff_c = c_star-last_c;

output_path = capital_path.^alpha;
investment_path = output_path-consumption_path;

end

