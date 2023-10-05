% H:y h:x
function test_speedup_nonparestim()
    % Inputs
    point_x = [0.5, 0.55]; 
    point_y = [0.3, 0.35];
    cx = 0.2;
    cx_vecsimpl = [0.3, 0.32,0.34]; 
    Y = [0.5,0.4, 0.3;0.2,0.6,0.7];  %sample_Y
    H = [0.4; 0.2];
    h = [0.1; 0.05];
    
    % Call the function
    result = speedup_nonparestim(point_x, point_y, cx, cx_vecsimpl, Y, H, h);
    disp(result);

    disp("---------");
    result = speed(point_x, point_y, cx, cx_vecsimpl, Y, H, h);
    


    % Check the result for NaN and Inf values
    assert(all(~isnan(result(:))), 'Result contains NaN values');
    assert(all(~isinf(result(:))), 'Result contains Inf values');
    
    % Print the result
    disp(result);
end
