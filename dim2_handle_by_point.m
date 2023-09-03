% numpoint means Number of rows in each subregion
% For example, 10, which represents a total of 100 points taken from each region
function dim2_handle_by_point(filename,numpoint,datafilename)
    fullFileName = filename + ".csv";
    data = readmatrix(fullFileName,"Range",2);
    init_data = data(:,1:2); 
    next_data = data(:,3:4); 

    sigma_init = cov(init_data);
    sigma_next = cov(next_data);
    
    
    d = 2;
    n = size(data, 1);
    disp(['Sample data length (n) = ', num2str(n)]);
    num_point_per_dim = numpoint;
    total_points = num_point_per_dim^2;
    disp(['each state point = ', num2str(total_points)]);
    


%   
%   h_init = (n^(-1/(d+4)) * std_init.^0.5);
%   h_next = (n^(-1/(d+4)) * std_next.^0.5);
    
    h_init = (n^(-1/(d+4))) * sqrt(eig(sigma_init));
    h_next = (n^(-1/(d+4))) * sqrt(eig(sigma_next));
    
%     disp(['h_init = ' mat2str(h_init)]);
%     disp(['h_next = ' mat2str(h_next)]);
    
    init_data = init_data';
    next_data = next_data';


% range from 0-2
    x_min = 0;
    x_max = 2;
    y_min = 0;
    y_max = 2;
    
% devide into 100 subregions
    rows = 10;
    cols = 10;

    x_step = (x_max - x_min) / cols;
    y_step = (y_max - y_min) / rows;

    regions = zeros(rows * cols,4);
    probability = zeros(rows * cols,rows * cols,2);
    region_idx = 1;

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


    % Outer loop: iterate over each region to uniformly select points

  %     parfor r = 1:size(regions, 1)
    for r = 1:size(regions,1)
        region = regions(r, :);
        
        % Use linspace to uniformly select points
        x_points = linspace(region(1), region(3), num_point_per_dim);
        y_points = linspace(region(2), region(4), num_point_per_dim);
        
        % Temporary storage for parallel processing
        temp_prob = zeros(size(regions, 1), 2);
        
        % Second loop: iterate over the uniformly selected points
        for x = x_points
            for y = y_points
                x0 = [x, y];
                x0 = x0(:);
                
                max_val = -inf;
                min_val = inf;
                
                % Third loop: iterate over all regions for calculation
                for k = 1:size(regions, 1)
                    range_Y = regions(k, :);
                    % Inner loop: call function
%                     disp(size(x0));
%                     disp(size(init_data));
%                     disp(size(next_data));
%                     disp(size(range_Y));
%                     disp(size(h_next));
%                     disp(size(h_init));
                    value = integra_nonpara(x0, init_data, next_data, range_Y, h_next, h_init);
                    max_val = max(max_val, value);
                    min_val = min(min_val, value);

                    % Store the max and min values
                    temp_prob(k, 1) = min_val;
                    temp_prob(k, 2) = max_val;
                end
                
                
            end
        end
        
        % Save the temporary results to the main variable
        probability(r, :, :) = temp_prob;
        
        % Display progress (basic version, without ParforProgMon)
        fprintf('Completed region %d out of %d\n', r, size(regions, 1));
    end
    
    % Close parallel pool if necessary
%     delete(gcp('nocreate'));


    

    assignin('base','probability',probability);

%     file_name = 'result_prob.csv';
    file_name = datafilename+"_point";
    save([char(file_name) '.mat'], 'probability');

    disp("saved");

end