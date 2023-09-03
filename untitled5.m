% 2 actions
% data 1000
subfolderName = '2_dim_data';
cd(subfolderName);

% generate data for different size
% 1000
filename = "data_1000_2nd_system.csv";
% get_2step(1000,filename);
get_2step_2nd_system(1000,filename)
% handle data
% 10*10
% dim2_handle(filename,5,'result_1000_5.csv');
dim2_handle(filename,10,'result_1000_10_2nd.csv')



cd('..');

disp('Everything is done.');
