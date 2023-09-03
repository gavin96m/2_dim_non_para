function dim2_handle(filename,datafilename,regionsize)
    fullFileName = filename + ".csv";
    data = readmatrix(fullFileName,"Range",2);
    init_data = data(:,1:2); 
    next_data = data(:,3:4); 

    sigma_init = cov(init_data);
    sigma_next = cov(next_data);
    
    
    d = 2;
    n = size(data, 1);
    disp(['Sample data length (n) = ', num2str(n)]);
%     disp(['each state point = ', num2str(numpoint), ' * ', num2str(numpoint)]);



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
    prob_idx = 1;
    all_target_regions = [x_min,y_min,x_max,y_max];

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

%     total_iterations = num_regions^2;
%     counter = 0;
    

                        
%   range_X: init region
%   range_Y: target region 
%     for i = 1:num_regions
%         range_X = regions(i,:);
%         for j = 1:num_regions
%             range_Y = regions(j,:);
%             [min_value,max_value] = optimize_function(init_data,next_data,range_X,h_next,h_init,range_Y);
%             
%             probability(i,j,1) = min_value;
%             probability(i,j,2) = max_value; 
% 
%             counter = counter + 1;
%             progress_percentage = (counter / total_iterations) * 100;
%             fprintf('progress：%.2f%%\n', progress_percentage); 
% 
% 
%         end
%     end

    parfor_progress(num_regions); 
    
    parfor i = 1:num_regions
        range_X = regions(i,:);
        temp_probability = zeros(num_regions, 2); 
        for j = 1:num_regions
            range_Y = regions(j,:);
            [min_value, max_value] = optimize_function(init_data, next_data, range_X, h_next, h_init, range_Y);
    
            temp_probability(j, 1) = min_value;
            temp_probability(j, 2) = max_value;
        end
        probability(i, :, :) = temp_probability; 
        parfor_progress(); 
    end

    

    assignin('base','probability',probability);

%     file_name = 'result_prob.csv';
    file_name = datafilename;
    save([char(file_name) '.mat'], 'probability');

    disp("saved");

end