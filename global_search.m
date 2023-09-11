function [min_value, max_value] = global_search(X, Y, range_X, H, h, range_Y)

    % Set the bounds
    lb = [range_X(1); range_X(2)]; %[x_min;y_min]
    ub = [range_X(3); range_X(4)]; %[x_max;y_max]

    % Define the objective function for minimization
    fun_min = @(x) target_function(x, X, Y, range_X, H, h);
    
    % Define the objective function for maximization (by negating the original function)
    fun_max = @(x) -fun_min(x);

    % Define the optimization problem
    problem_min = createOptimProblem('fmincon', 'objective', fun_min, ...
        'x0', (lb+ub)/2, 'lb', lb, 'ub', ub);
    
    problem_max = createOptimProblem('fmincon', 'objective', fun_max, ...
        'x0', (lb+ub)/2, 'lb', lb, 'ub', ub);

    % Create a GlobalSearch object
    gs = GlobalSearch('Display', 'off');

    % Run GlobalSearch
    [x_min, min_value] = run(gs, problem_min);
    [~, max_neg_value] = run(gs, problem_max);

    max_value = -max_neg_value;
    

end

function val = target_function(x, X, Y, range_Y, H, h)
    % Get the integral value
    val = integra_nonpara(x, X, Y, range_Y, H, h);
    % Combine with normcdf (based on your requirement)
    % val = normcdf(int_val); 
end
