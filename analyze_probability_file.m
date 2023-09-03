function [p_max, action_series] = analyze_probability_file(Act, S_total, S_targ, S_nev, q_ini, k, file_name)

    % Read the result_prob.csv file
    data = readmatrix(file_name);
    M_lo = data(:, 1); % First column contains the minimum probabilities
    M_up = data(:, 2); % Second column contains the maximum probabilities
    
    % Reshape M_lo and M_up to the required format
    num_points = size(data, 1);
    num_actions = numel(Act);
    M_lo = reshape(M_lo, num_points, num_actions);
    M_up = reshape(M_up, num_points, num_actions);

    % Call the function to perform model checking
    [p_max, action_series] = maxreachibility_modelcheck(M_lo, M_up, Act, S_total, S_targ, S_nev, q_ini, k);
end
