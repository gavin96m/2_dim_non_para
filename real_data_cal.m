
function f = y1(x, x_next)
    % Assuming delta, tau, etc. are either global variables or passed as function arguments
    % If they are global variables, declare them inside the function: global delta tau;
    if x(1) < 0.1
        f = sqrt(2) / (delta * sqrt(pi)) * exp(-2 * ((x_next(1) - x(1) - tau * x(4) * cos(x(5))) / delta)^2);
    else
        f = sqrt(2) / (delta * sqrt(pi)) * exp(-2 * ((x_next(1) - x(1) - tau * x(4) * cos(x(5) + x(7))) / delta)^2);
    end
end


function f = y2(x, x_next)

    if x(2) < 0.1
        f = sqrt(2) / (delta * sqrt(pi)) * exp(-2 * ((x_next(2) - x(2) - tau * x(4) * sin(x(5))) / delta)^2);
    else
        f = sqrt(2) / (delta * sqrt(pi)) * exp(-2 * ((x_next(2) - x(2) - tau * x(4) * sin(x(5) + x(7))) / delta)^2);
    end
end

function f = y3(x, x_next)

    f = sqrt(2) / (delta * sqrt(pi)) * exp(-2 * ((x_next(3) - x(3) - tau * 0) / delta)^2);
end

function f = y4(x, x_next)

    f = sqrt(2) / (delta * sqrt(pi)) * exp(-2 * ((x_next(4) - x(4) - tau * 0) / delta)^2);
end


TODO 
567
