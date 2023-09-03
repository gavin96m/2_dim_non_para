function test_integra_nonpara()

    % Define a 2D Gaussian distribution
    mu = [0.5;0.5];  % Mean
    Sigma = [0.25, 0.1; 0.1, 0.25];  % Covariance matrix

    % Generate sample data
    X = mvnrnd(mu, Sigma, 100)';
    Y = mvnrnd(mu, Sigma, 100)';

    % Define the bandwidths as the covariance matrices of the sample data
    H = [0.1;0.1];
    h = [0.1;0.1];

    % Define a random fixed point
    x0 = [0.5;0.5];

    % Define the integration region to cover the range of the sample data
    range_Y = [min([X(:); Y(:)]), min([X(:); Y(:)]), max([X(:); Y(:)]), max([X(:); Y(:)])];

    % Call the function
    result = integra_nonpara(x0, X, Y, range_Y, H, h);
    
    % Check the result
    assert(~isnan(result), 'Result is NaN');
    assert(~isinf(result), 'Result is Inf');
    assert(isscalar(result), 'Result is not a scalar');
    
    % Print the result
    disp(result);
end
