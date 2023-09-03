
% Test example using the provided data
Act = [1, 2];
S_total = [1, 2, 3, 4];
S_targ = [3]; % The set of target states
S_nev = [4]; % The set of never satisfying states
q_ini = 2; % Start from state S_2
k = 3; % Here k=3 means the verification is for a path with 3 steps

% Call the analyze_probability_file function to analyze the result_prob.csv file
[result_min_prob, result_max_prob] = analyze_probability_file(Act, S_total, S_targ, S_nev, q_ini, k, 'result_prob.csv');

% Display the analysis results
disp('Minimum Probabilities:');
disp(result_min_prob');
disp('Maximum Probabilities:');
disp(result_max_prob');
