% data 5*10^4
% x,y [0-2]




% tic
% filename  = "data_1000";
% get_2step(1000,filename);
% dim2_handle_by_point(filename,'result_1000_by_point_25_100',5,10);
% elapsed_time_1000 = toc;
% fprintf('Time taken for first block: %f seconds\n', elapsed_time_1000);
% tic
filename = "data_2000";
get_2step(2000,filename);
dim2_handle_by_point(filename,'result_2000_by_point_400_100',20,10);
elapsed_time_2000 = toc;
fprintf('Time taken for first block: %f seconds\n', elapsed_time_2000);

% tic
% filename = "data_2000_a2";
% get_2step_2nd(2000,filename);
% dim2_handle_by_point(filename,'result_2000_a2_by_point_25_100',5,10);
% elapsed_time_2000 = toc;
% fprintf('Time taken for second block: %f seconds\n', elapsed_time_2000);
% 
% tic
% filename = "data_2000_a2";
% get_2step_2nd(2000,filename);
% dim2_handle_by_point(filename,'result_2000_a2_by_point_400_100',20,10);
% elapsed_time_2000 = toc;
% fprintf('Time taken for third block: %f seconds\n', elapsed_time_2000);


disp('Everything is done.');
