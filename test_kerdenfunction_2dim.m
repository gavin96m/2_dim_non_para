function test_kerdenfunction_2dim()

    d = 2; 
    n = 100; 
    
    mu = [0.5; 0.5];
    Sigma = [0.25, 0.1; 0.1, 0.25];
    X = mvnrnd(mu, Sigma, n)';
    Y = mvnrnd(mu, Sigma, n)';
    
    hx_cv = [0.1; 0.1];
    hy_cv = [0.1; 0.1];
    
    x_point = [0.5; 0.5];
    y_point = [0.5; 0.5];

    result = kerdenfunction_2dim(X, Y, hx_cv, hy_cv, x_point, y_point);

    assert(~isnan(result), 'Result is NaN');
    assert(~isinf(result), 'Result is Inf');
    assert(isscalar(result), 'Result is not a scalar');

    fprintf('Test result: %f\n', result);
end
