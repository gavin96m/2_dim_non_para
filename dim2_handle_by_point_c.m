% numpoint means numpoint in each dim
% for example 10 means in each region has 100 points
function dim2_handle_by_point_c(filename,datafilename,regionsize,numpoint)
    data = readmatrix(filename,"Range",2);
    init_data = data(:,1:2); 
    next_data = data(:,3:4); 

    sigma_init = cov(init_data);
    sigma_next = cov(next_data);
    
    
    d = 2;
    n = size(data, 1);
    disp(['Sample data length (n) = ', num2str(n)]);
    disp(['each state point = ', num2str(numpoint), ' * ', num2str(numpoint)]);



%   
%   h_init = (n^(-1/(d+4)) * std_init.^0.5);
%   h_next = (n^(-1/(d+4)) * std_next.^0.5);
    
    h_init = (n^(-1/(d+4))) * sqrt(eig(sigma_init));
    h_next = (n^(-1/(d+4))) * sqrt(eig(sigma_next));
    
%     disp(['h_init = ' mat2str(h_init)]);
%     disp(['h_next = ' mat2str(h_next)]);
    
    init_data = init_data';
    next_data = next_data';



    x_min = 0;
    x_max = 2;
    y_min = 0;
    y_max = 2;
    
    rows = regionsize;
    cols = regionsize;

    x_step = (x_max - x_min) / cols;
    y_step = (y_max - y_min) / rows;

    regions = zeros(rows * cols,4);
    probability = zeros(rows * cols,rows * cols,2);
    region_idx = 1;
    % prob_idx = 1;


    for i = 1:rows
        for j = 1:cols
            x_min_curr = x_min + (j - 1) * x_step;
            x_max_curr = x_min_curr + x_step;
            y_min_curr = y_min + (i - 1) * y_step;
            y_max_curr = y_min_curr + y_step;
            
            regions(region_idx, :) = [x_min_curr, y_min_curr, x_max_curr, y_max_curr];
            
            region_idx = region_idx + 1;
        end
    end
    
    [num_regions, ~] = size(regions);

    fprintf('region number: %d\n', num_regions);


    total_steps = rows * cols;
    
    parfor_progress(rows*cols);
    probability = zeros(rows*cols, num_regions, 2); % Preallocate for efficiency
    parfor idx = 1:(rows*cols) % Combined loop counter for i and j
        
        % Compute i and j from the index
        i = mod(idx-1, rows) + 1;
        j = ceil(idx / rows);
        
        % Initialize the temporary probability storage for this source region
        temp_probability = inf(num_regions, 2); 
        temp_probability(:, 2) = -inf; % Set second column (max value) to negative infinity for initialization
        
        % lower left corner
        x_start = x_min + (i - 1) * x_step;
        y_start = y_min + (j - 1) * y_step;
        
        % upper right corner
        x_end = x_start + x_step;
        y_end = y_start + y_step;
        
        num_points = numpoint;    
        x_points = linspace(x_start, x_end, num_points);
        y_points = linspace(y_start, y_end, num_points);
        
        for k = 1:num_points
            for l = 1:num_points
                x0 = [x_points(k);y_points(l)];
    
                for m = 1:num_regions
                    range_Y = regions(m,:);
                    int_y = integra_nonpara_c(x0,init_data,next_data,range_Y,h_next,h_init);
    
                    % Update the minimum probability
                    temp_probability(m, 1) = min(temp_probability(m, 1), int_y);
    
                    % Update the maximum probability
                    temp_probability(m, 2) = max(temp_probability(m, 2), int_y);
                end
            end
        end
        
        probability(idx,:,:) = temp_probability;
        parfor_progress;
    end



    assignin('base','probability',probability);

%     file_name = 'result_prob.csv';
    file_name = datafilename;

    save([char(file_name) '.mat'], 'probability');
    disp("saved");

end