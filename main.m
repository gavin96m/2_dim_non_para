% data 5*10^4
% x,y [0-2]
% reigon 6*6
% subfolderName = '2_dim_data';
% cd(subfolderName);


% % 5000 by point
% tic;
% filename = "data_5000";
% get_2step(5000,filename);
% % handle data
% % range -> 10*10
% % point -> 10 * 10
% dim2_handle_by_point(filename,10,'result_5000_point_100_100');
% elapsed_time_5000 = toc;
% fprintf('Time taken for first block: %f seconds\n', elapsed_time_5000);


% tic
% filename = "data_2000_2nd";
% get_2step_2nd(2000,filename);
% % handle data
% dim2_handle(filename,'result_2000_fmincon_25_2nd',5);
% 
% elapsed_time_2000 = toc;
% fprintf('Time taken for first block: %f seconds\n', elapsed_time_2000);
% 
% 
% tic
% filename = "data_1000_2nd";
% get_2step_2nd(1000,filename);
% % handle data
% dim2_handle(filename,'result_1000_fmincon_25_2nd',5);
% 
% elapsed_time_1000 = toc;
% fprintf('Time taken for first block: %f seconds\n', elapsed_time_1000);
% 
% 
% tic
% filename = "data_1000_2nd";
% get_2step_2nd(1000,filename);
% % handle data
% dim2_handle(filename,'result_1000_fmincon_400_2nd',20);
% 
% elapsed_time_1000 = toc;
% fprintf('Time taken for first block: %f seconds\n', elapsed_time_1000);
% 
% 
% 
% tic
% filename = "data_2000_2nd";
% get_2step_2nd(2000,filename);
% % handle data
% dim2_handle(filename,'result_2000_fmincon_400_2nd',20);
% 
% elapsed_time_2000 = toc;
% fprintf('Time taken for first block: %f seconds\n', elapsed_time_2000);

tic
filename = "data_2000";
get_2step(2000,filename);
dim2_handle_check_problem(filename,'result_2000_fmincon_400_check',20);

elapsed_time_2000 = toc;

% fprintf('Time taken for first block: %f seconds\n', elapsed_time_2000);






disp('Everything is done.');
