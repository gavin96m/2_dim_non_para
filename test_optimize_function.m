function test_optimize_function()
    % Sample data and parameters
    d = 2;  % system dimension
    n = 100;  % sample data scale
    X = rand(d, n);
    Y = rand(d, n);
    range_Y = [0, 0, 1, 1];
    H = [0.1; 0.1];
    h = [0.1; 0.1];
    sample_Y = rand(d, 1);  % just some random sample for Y

    % Call the optimize_function
    optimized_val = optimize_function(X, Y, range_Y, H, h, sample_Y);

    % Validate the result
    assert(all(~isnan(optimized_val)), 'Optimized value contains NaN');
    assert(size(optimized_val, 1) == d, 'Optimized value has wrong dimension');
    assert(size(optimized_val, 2) == 1, 'Optimized value is not a column vector');
    
    % If all assertions pass, display a success message
    disp('test_optimize_function passed successfully!');
end
