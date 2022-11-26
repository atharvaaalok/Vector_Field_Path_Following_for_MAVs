clear; clc; close all;



k = 0.08;

y_min = -5;
y_max = 5;
nsteps = 100000;
y = linspace(y_min, y_max, nsteps);


expression = (k^2) * (y .^6 ) - 2 * (k^2) * (y .^ 4) - 3 * (y .^ 2) + 1;
expression = - expression;

syms y0
exp = (k^2) * (y0 .^6 ) - 2 * (k^2) * (y0 .^ 4) - 3 * (y0 .^ 2) + 1;
exp = - exp;
eqn = exp == 0;
solutions = solve(eqn, y0);
solution_val = double(solutions);

tol = 1e-2;
ind = find(abs(imag(solution_val)) < tol);
zeros_exp = solution_val(ind);


fig1_comps.fig = figure(1);

grid on;
% grid minor;
set(gca, 'xtick', [y_min:1:y_max]);
set(gca, 'ytick', [-20: 5: 30]);

hold on;
fig1_comps.p1 = plot(y, expression, 'LineWidth', 1.25);
fig1_comps.p2 = plot(zeros_exp, zeros(1, length(zeros_exp)), 'LineStyle', 'none', 'LineWidth', 1, 'Marker', 'o', 'MarkerSize', 8);

xlabel('y');
ylabel('$$\chi$$');

STANDARDIZE_FIGURE(fig1_comps);
SAVE_MY_FIGURE(fig1_comps, 'Equating_Derivatives.png', 'small');












