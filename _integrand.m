% clc
% clear all

function result = integrand()
    integrand = @(x) x.^5;
    absTol = 1e-100;
    start_time = tic;
    result = integral(integrand, 0, 10000,"AbsTol",absTol);
    end_time = toc(start_time);

    disp("MATLAB result: " + string(result));
    disp("Execution time: " + string(end_time) + " seconds");
end

