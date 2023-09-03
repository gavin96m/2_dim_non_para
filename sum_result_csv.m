filename = "result_10";
filename = filename + ".csv";

load(filename,'probability');
[num_regions, ~, ~] = size(probability);

sum_probs_min = zeros(num_regions, 1);
sum_probs_max = zeros(num_regions, 1);

for i = 1:num_regions
    sum_probs_min(i) = sum(probability(i,:,1));
    sum_probs_max(i) = sum(probability(i,:,2));
end

combined_matrix_10 = [sum_probs_min, sum_probs_max];
