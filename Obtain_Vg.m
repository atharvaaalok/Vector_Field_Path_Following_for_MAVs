function V_g = Obtain_Vg(X)

    global V_a W W_angle

    W_x = W * cos(W_angle);
    W_y = W * sin(W_angle);


    term_a = W_x * cos(X) + W_y * sin(X);
    term_b = (W_x * cos(X) + W_y * sin(X))^2 + (V_a^2 - W^2);
    V_g = (term_a) + sqrt(term_b);
    
%     psi = acos((V_g * cos(X) - W_x) / V_a);


end