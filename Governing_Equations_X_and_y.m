function dYdt = Governing_Equations_X_and_y(t, Y)

    global V_a W W_angle
    global X_inf k kappa epsilon

    % Get variables
    x = Y(1);
    y = Y(2);
    X = Y(3);
    
    V_g = Obtain_Vg(X);
%     V_g = 14;

    % Calculate derivatives corresponding to each variable
    dxdt = V_g *  cos(X);
    dydt = V_g * sin(X);

    X_d = - X_inf * (2 / pi) * atan(k * y);
    X_tilde = X - X_d;
    dXdt = - X_inf * (2 / pi) * (k / (1 + (k * y)^2)) * V_g * sin(X) - kappa * Chatter_function_choose(X_tilde / epsilon);
    
    % set vector of derivatives
    dYdt = [dxdt; dydt; dXdt];

end


% CHATTER FUNCTION CHOOSE
function Chatter_return = Chatter_function_choose(x)

    a = 1;

    if a == 0
        Chatter_return = sign_func(x);
    elseif a == 1
        Chatter_return = sat_func(x);
    end


end


% SIGN FUNCTION
function sign_return = sign_func(x)

    if x > 0
        sign_return = 1;
    elseif x == 0
        sign_return = 0;
    elseif x < 0
        sign_return = -1;
    end


end


% SAT FUNCTION
function sat_return = sat_func(x)

    if (abs(x) <= 1)
        sat_return = x;
    else
        sat_return = sign(x);
    end


end








