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

global r k kappa epsilon

alpha = 1.65;
r = 60;
k = 0.5;
kappa = pi / 2;
epsilon = 1;


%==================================================
% INITIAL CONDITIONS

N = 20;
gamma0_list = linspace(0, 2 * pi, N);
d0_list = ones(1, length(gamma0_list)) * 100;
X0_list = [pi/2 * ones(1, length(d0_list)/2), -pi/ 2 * ones(1, length(d0_list)/2)];


for n = 1: length(d0_list)

    gamma0 = gamma0_list(n);
    d0 = d0_list(n);
    X0 = X0_list(n);
    
    Y0 = [gamma0; d0; X0];
    
    t1 = 0;
    t2 = 30;
    nsteps = 1000;
    tRange = linspace(t1, t2, nsteps);
    
    YSol = ode4(@(t,y) Governing_Equations_X_and_y_Circle(t, y), tRange, Y0);
    tSol = tRange;
    
    gamma{n} = YSol(:, 1);
    d{n} = YSol(:, 2);
    X{n} = YSol(:, 3);

end


%==================================================
% GET EQUATION OF SLIDING SURFACE

gamma_d = linspace(0, 2 * pi, 100);

x_d = r * cos(gamma_d);
y_d = r * sin(gamma_d);


%==================================================
% PLOT RESULTS

fig1_comps.fig = figure(1);
hold on
axis equal

for n = 1: length(d0_list)
    % Plot evolution of X and y in X-y space
    x = d{n} .* cos(gamma{n});
    y = d{n} .* sin(gamma{n});
    fig1_comps.p3(n) = plot(x, y, 'LineWidth', .5, 'Color', PS.Blue4);
end

% for n = 1: length(d0_list)
%     % Plot evolution of X and y in X-y space
%     fig1_comps.p2(n) = plot(d{n}, X{n}, 'LineWidth', .5, 'Color', PS.Blue4);
% end

% Plot sliding surface
fig1_comps.p1 = plot(x_d, y_d, 'LineWidth', 2, 'Color', PS.Red1);

xlabel('x (m)');
ylabel('y (m)');

x_min = -120;
x_max = 120;

y_min = -120;
y_max = 120;

xlim([x_min, x_max]);
ylim([y_min, y_max]);

STANDARDIZE_FIGURE(fig1_comps);

SAVE_MY_FIGURE(fig1_comps, 'Orbit_Path_IC_plots.png', 'small');


fig2_comps.fig = figure(2);
hold on

for n = 1: length(d0_list)
    
    fig2_comps.p(n) = plot(tRange, d{n}, 'LineWidth', 1.25, 'Color', PS.Blue1);

end

xlabel('t (s)');
ylabel('d, distance from origin (m)');

y_min = 0;
y_max = 120;

ylim([y_min, y_max]);

STANDARDIZE_FIGURE(fig2_comps);

SAVE_MY_FIGURE(fig2_comps, 'Main_Circle_1.png', 'small');



fig3_comps.fig = figure(3);
hold on

for n = 1: length(d0_list)
    
    fig3_comps.p(n) = plot(tRange, X{n}, 'LineWidth', 1.25, 'Color', PS.Blue1);

end

xlabel('t (s)');
ylabel('$$\chi \mbox{, Course (rad)}$$');

STANDARDIZE_FIGURE(fig3_comps);

SAVE_MY_FIGURE(fig3_comps, 'Main_Circle_2.png', 'small');





























