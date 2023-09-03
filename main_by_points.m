% 1
tic;
filename = "data_5";
get_2step(5,filename);

% handle data
dim2_handle_by_point(filename,3,'result_5');
elapsed_time_5 = toc;
fprintf('Time taken for zero block: %f seconds\n', elapsed_time_5);

% 5000
tic;
filename = "data_5000";
get_2step(5000,filename);

% handle data
dim2_handle_by_point(filename,10,'result_5000');
elapsed_time_5000 = toc;
fprintf('Time taken for first block: %f seconds\n', elapsed_time_5000);


% 50000
tic;
filename = "data_50000";
get_2step(50000,filename);

% handle data
dim2_handle_by_point(filename,10,'result_50000');
elapsed_time_50000 = toc;
fprintf('Time taken for second block: %f seconds\n', elapsed_time_50000);


disp('Everything is done.');
