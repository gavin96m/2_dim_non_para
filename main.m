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


% 5000 by fmincon 6*6
tic
filename = "data_5000";
get_2step(5000,filename);
% handle data
% range 6*6
dim2_handle(filename,'result_5000_fmincon_36',6);

elapsed_time_5000 = toc;
fprintf('Time taken for first block: %f seconds\n', elapsed_time_5000);


% 5000 by fmincon 10*10
tic
filename = "data_5000";
get_2step(5000,filename);
% handle data
% range 6*6
dim2_handle(filename,'result_5000_fmincon_100',10);

elapsed_time_5000 = toc;
fprintf('Time taken for second block: %f seconds\n', elapsed_time_5000);



disp('Everything is done.');
