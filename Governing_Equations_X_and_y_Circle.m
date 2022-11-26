function dYdt = Governing_Equations_X_and_d_Circle(t, Y)

    global V_a W W_angle
    global r k kappa epsilon

    % Get variables
    gamma = Y(1);
    d = Y(2);
    X = Y(3);
    
    V_g = Obtain_Vg(X);
%     V_g = 14;

    % Calculate derivatives corresponding to each variable
    dgammadt = (V_g / d) * sin(X - gamma);
    dddt = V_g * cos(X - gamma);

    X_d = gamma - pi / 2 - atan(k * (d - r) );
    X_tilde = X - X_d;
    d_tilde = d - r;
    beta = k / (1 + (k * d_tilde)^2);
    dXdt = - (V_g / d) * sin(X - gamma) - beta * V_g * cos(X - gamma) - kappa * Chatter_function_choose(X_tilde / epsilon);
    
    % set vector of derivatives
    dYdt = [dgammadt; dddt; dXdt];

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








