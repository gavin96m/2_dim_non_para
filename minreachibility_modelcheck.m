%Zhi Zhang, 13.06.2023, Newcastle University. 
%This code is used to the IMDP verification for two-dimensional case 
%without considering the rewards and costs.

%1. The inputs M_lo, M_up are two matrices, which entries are the lower and upper bound of 
%transition probability under different motions a_1, a_2, a_3,...,a_k i.e., Act={a_1,a_2,a_3,...,a_k}. 
%****Important: Matrix M_lo should be the form: nmk x nm. If the state does not have some actions
%just keep the row of the specific action whole zero.

%2. In addition, we also need to reorder the partition (the matrix form for two dimension, 
%cubic form for three dimension) into the order similar with S1, S2,...,Sn, i.e., Sta={S1,S2,...}.

%3. The satisfication set phi also should be the input, so that at each step we
%need to check whether each state in S_total can satisfy the satification.
%For example, We should input the original whole states set S_total, the
%target set S_targ which satisfies the specific specification, the releted
%unwanted set which can be deduced from S_total and S_targ. Important
%notice (for the satisfication set): Here we just consider the model
%checking problem, hence in this code the satification set is the value
%range of states of the considering system. S_nev is S_total/(S_targ
%union S_ini), S_quest=S_total/(S_targ union S_nev). S_ini is the initial
%set of our problem. In this code, we only consider the one initial point
%q_ini. *****The above S_total, S_targ, S_nev, S_quest are all vector (i.e., mnx1), since our
%problem is two-dimensional and we will rearrange the matrix into a vector by the reshape(A',1,[]). 
%****Here, S_total is including all states, and the set of all reordering
%states from partition。 Thus, S_total is a vector. The same as S_targ and
%S_nev.
%****Important: If we want to use this code, we need to reorder the
%partitioned state space (for example, for two dimension, the partitioned state space is
%a matrix. For one dimension, it is a point set). S_total should be the
%form {s_1,s_2,...,s_mn}

%****action series: is the action required to achieve the minimum
%probability at different steps. Thus, action_series is kx1 vector.
%****q_ini: is the initial state, which here will label as the real number
%k means the finite steps of the path initiating from the S_ini to S_targ
%within k steps.
function [p_min,action_series]=minreachibility_modelcheck(M_lo,M_up,Act,S_total,S_targ,S_nev,q_ini,k)
eplis=10^(-5);
numb_Act=size(Act,2);%For each state, the number of the actions.
[row,col]=size(S_total);%obtaining the size of S_total
midd_store=zeros(row,col);%for storing the middle probabiltiy during the calculation of lower bound 
%The fixed point calculation of the probability.****In our case, row=1 and
%col should be same size of states.
action_series=zeros(1,k);% kx1 vector
if k==1%The iteration step k==1 %****Here k=1, means the verification is located at the initial state
       %Hence, whether this state is in the satisfying region will decide
       %the probability
    if min(abs(q_ini-S_targ),[],'all')<=eplis% q_ini is in S_targ
        p_min=1;
    else %q_ini is not in S_targ
        p_min=0;
    end
else%The iteration step k>1
    
    if min(abs(q_ini-S_targ),[],'all')<=eplis
        p_min=1;      
    elseif min(abs(q_ini-S_nev),[],'all')<=eplis
        p_min=0;   
    else%q_ini \in S_quest
    
        for  ik=1:k
            if ik==1
                for i_row=1:row
                    for i_col=1:col
                        point_targ=S_total(i_row,i_col);
                        if min(abs(point_targ-S_targ),[],'all')<=eplis %means that the label of one of the states has
                            %closing distance to the S_targ which is set inclues
                            %the label of desried states
                            midd_store(i_row,i_col)=1;
                        else
                            midd_store(i_row,i_col)=0;
                        end
                    end
                end
                buff0=midd_store;
            elseif ik>1 && ik<k%ik>1
                
                for i_row=1:row
                    for i_col=1:col
                        point_targ=S_total(i_row,i_col);%I have to check all the points
                        if min(abs(point_targ-S_targ),[],'all')<=eplis
                            buff0(i_row,i_col)=1;
                            continue
                        elseif min(abs(point_targ-S_nev),[],'all')<=eplis
                            buff0(i_row,i_col)=0;
                            continue
                            %                     elseif min(abs(point_targ-S_quest),[],'all')<=eplis && ik==0
                            %                         buff0(i_row,i_col)=0;
                            %                     elseif min(abs(point_targ-S_quest),[],'all')<=eplis && ik>0
                            %                         %This step always has many problems, should ensure
                            %                         %there is no questions.
                            %                         buff0(i_row,i_col)=midd_store(i_row,i_col)+ midd_store(i_row,i_col);%? This should be modified logically
                        else
                            %If the above cannot be satisfied
                            %reordering based on the O-minimising
                            [buff1,index]=sort(buff0);%since the midd_store is a vector,
                            %****buff1 is the reordered vector statify the ascending with
                            %respect to the probability of target satisfication. Index is
                            %the order of elements of buff0. ****Important: the buff0 is
                            %the minimul transient probility of last step.
                            transipro_lo_poin=M_lo(((i_col-1)*numb_Act+1):i_col*numb_Act,:);%the lower trasient probabilities initiated from point_targ to next point of
                            transipro_up_poin=M_up(((i_col-1)*numb_Act+1):i_col*numb_Act,:);%the upper trasient probabilities initiated from point_targ to next point of
                            MiddP_min = o_minimising (transipro_lo_poin,transipro_up_poin,index,numb_Act);%The middle probability vector to
                            %allocate the upper and lower probability to relevant
                            %transition initated from state-point_targ
                            %% For this part, I need to overcome a problem about some rows with whole zero elements
                            Find1_whole0=max(transipro_lo_poin,[],2);
                            %                Find2_whole0=max(transipro_up_poin,[],2);
                            for i_zero=1:numb_Act
                                if Find1_whole0(i_zero)==0
                                    MiddP_min(i_zero,:)=1.5*ones(1,col);%This line means replacing
                                    %the whole zero elements in a row by very large value
                                end
                            end
                            %%%%
                            
                            [Pro_min,action]=min(MiddP_min*buff1');%Pro_min is the minimum probability and action is the relevant action
                            %%put Pro_min into the buff0
                            buff0(i_row,i_col)=Pro_min;
                            action_series(k-ik+1)=action;%storing the action into the action_series (stratgy)
                            
                        end
                        
                    end
                end
            else% ik==k, at the final step, we just only consider the initial state,
                %and ****the q_ini is the state satisfy q_ini\in S_quest and k>0
                
                %If the above cannot be satisfied
                %reordering based on the O-minimising
                [buff1,index]=sort(buff0);%since the midd_store is a vector,
                %****buff1 is the reordered vector statify the ascending with
                %respect to the probability of target satisfication. Index is
                %the order of elements of buff0. ****Important: the buff0 is
                %the minimul transient probility of last step.
                transipro_lo_poin=M_lo(((q_ini-1)*numb_Act+1):q_ini*numb_Act,:);%the lower trasient probabilities initiated from point_targ to next point of
                transipro_up_poin=M_up(((q_ini-1)*numb_Act+1):q_ini*numb_Act,:);%the upper trasient probabilities initiated from point_targ to next point of
                MiddP_min = o_minimising (transipro_lo_poin,transipro_up_poin,index,numb_Act);%The middle probability vector to
                %allocate the upper and lower probability to relevant
                %transition initated from state-point_targ
                %% For this part, I need to overcome a problem about some rows with whole zero elements, which means that 
                %%%%for some states, it cannot take some specific actions
                %%%%and there is not action options for these states
                Find1_whole0=max(transipro_lo_poin,[],2);
%                Find2_whole0=max(transipro_up_poin,[],2);
                for i_zero=1:numb_Act
                    if Find1_whole0(i_zero)==0
                        MiddP_min(i_zero,:)=1.5*ones(1,col);%This line means replacing 
                                   %the whole zero elements in a row by very large value
                    end
                end
                %%%%
                
                [Pro_min,action]=min(MiddP_min*buff1');%Pro_min is the minimum probability and action is the relevant action
                p_min=Pro_min;
                action_series(k-ik+1)=action;%storing the action into the action_series (stratgy)
                
            end
        end
        
    end
end



