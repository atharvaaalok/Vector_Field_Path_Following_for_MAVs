clear; clc; close all;

PS = PLOT_STANDARDS();
%==================================================
% AIRSPEED AND WIND VELOCITY VECTOR

global V_a W W_angle 

V_a = 10;
W = 2;
W_angle = 53 * (pi / 180);
W_x = W * cos(W_angle);
W_y = W * sin(W_angle);


%==================================================
% CONTROLLER CHARACTERISTICS

global X_inf k kappa epsilon

alpha = 1.65;
X_inf = pi / 2;
k = .08;
kappa = pi / 2;
epsilon = 1;


%==================================================
% INITIAL CONDITIONS

x0_list = [-110: 20 :110, -110: 20 :110];
y0_list = [-110: 20 :110, -110: 20 :110];
X0_list = [pi/2 * ones(1, length(y0_list)/2), -pi/ 2 * ones(1, length(y0_list)/2)];


for n = 1: length(y0_list)

    x0 = x0_list(n);
    y0 = y0_list(n);
    X0 = X0_list(n);
    
    Y0 = [x0; y0; X0];
    
    t1 = 0;
    t2 = 30;
    nsteps = 1000;
    tRange = linspace(t1, t2, nsteps);
    
    YSol = ode4(@(t,y) Governing_Equations_X_and_y(t, y), tRange, Y0);
    tSol = tRange;
    
    x{n} = YSol(:, 1);
    y{n} = YSol(:, 2);
    X{n} = YSol(:, 3);

end


%==================================================
% GET EQUATION OF SLIDING SURFACE

y_min = -100;
y_max = 100;
nsteps = 10000;
y_d = linspace(y_min, y_max, nsteps);

X_d_1 = - X_inf * (2 / pi) *  atan(k .* y_d);
X_d_2 = X_inf * (2 / pi) *  atan(k .* y_d);


%==================================================
% PLOT RESULTS

fig1_comps.fig = figure(1);
hold on

for n = 1: length(y0_list)
    % Plot evolution of X and y in X-y space
    fig1_comps.p2(n) = plot(y{n}, X{n}, 'LineWidth', .5, 'Color', PS.Blue4);
end

% Plot sliding surface
fig1_comps.p1 = plot(y_d, X_d_1, 'LineWidth', 2, 'Color', PS.Red1);
fig1_comps.p3 = plot(y_d, X_d_2, 'LineWidth', 2, 'Color', PS.Orange1);


xlabel('y, lateral deviation (m)');
ylabel('$$\chi \mbox{, Course (rad)}$$');

X_min = -pi / 2;
X_max = pi / 2;

xlim([y_min, y_max]);
ylim([X_min, X_max]);

STANDARDIZE_FIGURE(fig1_comps);

SAVE_MY_FIGURE(fig1_comps, 'Overlap.png', 'small');





























