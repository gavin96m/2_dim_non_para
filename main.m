% data 5*10^4
% x,y [0-2]
% reigon 6*6
% subfolderName = '2_dim_data';
% cd(subfolderName);

% 
% tic
% filename = "data_10";
% get_2step(10,filename);
% dim2_handle(filename,'result_10_fmincon_25_new',5);
% elapsed_time_10 = toc;
% fprintf('Time taken for zero block: %f seconds\n', elapsed_time_10);


% tic
% filename = "data_1000";
% get_2step(1000,filename);
% dim2_handle(filename,'result_1000_fmincon_25_new',5);
% elapsed_time_1000 = toc;
% fprintf('Time taken for zero block: %f seconds\n', elapsed_time_1000);

% 
% 
% 
tic
filename = "data_2000";
get_2step(2000,filename);
dim2_handle(filename,'result_2000_fmincon_25_new',5);
elapsed_time_2000 = toc;
fprintf('Time taken for first block: %f seconds\n', elapsed_time_2000);
% 
% 
% 
% tic
% filename = "data_1000";
% get_2step(1000,filename);
% dim2_handle(filename,'result_1000_fmincon_400_new',20);
% elapsed_time_1000 = toc;
% fprintf('Time taken for first block: %f seconds\n', elapsed_time_1000);
% 
% tic
% filename = "data_2000";
% get_2step(2000,filename);
% dim2_handle(filename,'result_2000_fmincon_400_new',20);
% elapsed_time_2000 = toc;
% fprintf('Time taken for third block: %f seconds\n', elapsed_time_2000);
% 
% % 2nd
% 
% tic
% filename = "data_1000_2nd";
% get_2step_2nd(1000,filename);
% dim2_handle(filename,'result_1000_fmincon_25_2nd_new',5);
% elapsed_time_1000 = toc;
% fprintf('Time taken for fourth block: %f seconds\n', elapsed_time_1000);
% 
% tic
% filename = "data_1000_2nd";
% get_2step_2nd(1000,filename);
% dim2_handle(filename,'result_1000_fmincon_400_2nd_new',20);
% elapsed_time_1000 = toc;
% fprintf('Time taken for fivth block: %f seconds\n', elapsed_time_1000);
% 
% tic
% filename = "data_2000_2nd";
% get_2step_2nd(2000,filename);
% dim2_handle(filename,'result_2000_fmincon_25_2nd_new',5);
% elapsed_time_2000 = toc;
% fprintf('Time taken for sixth block: %f seconds\n', elapsed_time_2000);
% 
% 
% tic
% filename = "data_2000_2nd";
% get_2step_2nd(2000,filename);
% dim2_handle(filename,'result_2000_fmincon_400_2nd_new',20);
% elapsed_time_2000 = toc;
% fprintf('Time taken for seventh block: %f seconds\n', elapsed_time_2000);
% 


disp('Everything is done.');
