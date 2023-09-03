% read data from csv file
data = readmatrix('result_prob.csv');

% check if data has the expected size
if size(data, 2) ~= 2
    error('Data has wrong number of columns. Expected 2, got %d.', size(data, 2));
end

% M_lo nmk*nm
% n:num of state 9
% m:num of action 1
% k:step of action 

M_lo = zeros(9, 25);
M_up = zeros(9, 25);
for i = 1:9
    for j = 1:25
        index = (i-1)*25+j;
        M_lo(i,j) = data(index,1); 
        M_up(i,j) = data(index,2);
    end
end

Act=[1];
S_total=[1,2,3,4,5,6,7,8,9];
% S_targ=[3]; % The set of target states
% S_nev=[4];% The set of never satifying states
% q_ini=2;%start from state S_1 
% k=3;%Here k=1, means the verification is located at the initial state
% [p_max,action_series]=maxreachibility_modelcheck(M_lo,M_up,Act,S_total,S_targ,S_nev,q_ini,k);


