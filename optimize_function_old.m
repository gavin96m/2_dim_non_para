% range_X is the initial region
% range_Y is the target region

% function [min_value, max_value] = optimize_function(X, Y, range_X, H, h, range_Y,all_target_regions)
function [min_value, max_value] = optimize_function_old(X, Y, range_X, H, h, range_Y)

    % Nonlinear constraints
%     nonlcon = @(x) prob_constraints(x,X,Y,all_target_regions,H,h);

    % Define the objective function for minimization
    fun_min = @(x) target_function(x, X, Y, range_X, H, h);
    
    % Define the objective function for maximization (by negating the original function)
    fun_max = @(x) -target_function(x, X, Y, range_X, H, h);

  
    
    % Set the bounds
    lb = [range_X(1); range_X(2)]; %[x_min;y_min]
    ub = [range_X(3); range_X(4)]; %[x_max;y_max]

  % Initial guess for x
    x0 = lb;

    % Optimization options
    options = optimoptions('fmincon','Display','off');
    
    % Use fmincon to find the minimum value
    x_min = fmincon(fun_min, x0, [], [], [], [], lb, ub, [], options);
    min_value = target_function(x_min, X, Y, range_Y, H, h);
    
    % Use fmincon to find the maximum value (by searching for the minimum of the negated function)
    x_max = fmincon(fun_max, x0, [], [], [], [], lb, ub, [], options);
    max_value = target_function(x_max, X, Y, range_Y, H, h);
end

function [c, ceq] = prob_constraints(x, X, Y, all_target_regions, H, h)
    total_prob = 0;
    for i = 1:size(all_target_regions,1)
        total_prob = total_prob + target_function(x, X, Y, all_target_regions(i,:), H, h);
    end
    c = total_prob - 1;  % This should be <= 0
    ceq = [];  % No equality constraints
end

function val = target_function(x, X, Y, range_Y, H, h)
    % Get the integral value
    val = integra_nonpara(x, X, Y, range_Y, H, h);
    
    % Combine with normcdf (based on your requirement)
%     val = normcdf(int_val); 
end
