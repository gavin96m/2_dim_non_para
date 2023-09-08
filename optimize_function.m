function [min_value, max_value] = optimize_function(X, Y, range_X, H, h, range_Y)

    % Set the bounds
    lb = [range_X(1); range_X(2)]; %[x_min;y_min]
    ub = [range_X(3); range_X(4)]; %[x_max;y_max]

    % Define the objective function for minimization
    fun_min = @(x) target_function(x, X, Y, range_X, H, h);
    
    % Define the objective function for maximization (by negating the original function)
    fun_max = @(x) -target_function(x, X, Y, range_X, H, h);

    % Optimization options
    options = optimoptions('fmincon','Display','off');
    
    N = 100;  % Number of times we want to run the local search
    all_min_values = inf(N, 1);
    all_max_values = -inf(N, 1);

    for i = 1:N
        % Choose a random initial guess within the bounds
        fprintf('Now at %f times\n', i);
        x0 = lb + (ub - lb) .* rand(2, 1);

        % Use fmincon to find the minimum value
        x_min = fmincon(fun_min, x0, [], [], [], [], lb, ub, [], options);
        all_min_values(i) = target_function(x_min, X, Y, range_Y, H, h);
    
        % Use fmincon to find the maximum value (by searching for the minimum of the negated function)
        x_max = fmincon(fun_max, x0, [], [], [], [], lb, ub, [], options);
        all_max_values(i) = target_function(x_max, X, Y, range_Y, H, h);
    end

    min_value = min(all_min_values);
    max_value = max(all_max_values);

end


function val = target_function(x, X, Y, range_Y, H, h)
    % Get the integral value
    val = integra_nonpara(x, X, Y, range_Y, H, h);
    
    % Combine with normcdf (based on your requirement)
%     val = normcdf(int_val); 
end
