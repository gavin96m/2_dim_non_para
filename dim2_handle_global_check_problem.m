function dim2_handle_check_problem(filename, datafilename, regionsize)
    fullFileName = filename + ".csv";
    data = readmatrix(fullFileName, "Range", 2);
    init_data = data(:, 1:2);
    next_data = data(:, 3:4);

    sigma_init = cov(init_data);
    sigma_next = cov(next_data);

    d = 2;
    n = size(data, 1);
    disp(['Sample data length (n) = ', num2str(n)]);

    h_init = (n^(-1/(d+4))) * sqrt(eig(sigma_init));
    h_next = (n^(-1/(d+4))) * sqrt(eig(sigma_next));

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

    regions = zeros(rows * cols, 4);
    probability = zeros(rows * cols, rows * cols, 2);
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

    i = 15;  % Source region index
    j = 367;  % Target region index

    range_X = regions(i, :);
    range_Y = regions(j, :);
    [min_value, max_value] = global_search(init_data, next_data, range_X, h_next, h_init, range_Y);

    probability(i, j, 1) = min_value;
    probability(i, j, 2) = max_value;

    assignin('base', 'probability', probability);

    file_name = datafilename;
    save([char(file_name) '.mat'], 'probability');
    disp("saved");
end

