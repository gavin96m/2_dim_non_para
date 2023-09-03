%Zhi Zhang, 20,07,2023, Newcastle University
%This code is for O-maximising, and is to fix the allocation of the upper and lower transient
%probability with respect to the transient initated from a state q to the
%rest of states so that the maximum of formula
%\sum_{i=1}^{r_o-1}\hat{P}(q,o_i)+\sum_{i=r_o+1}^{|Q|}\breva{P}(q,o_{i})
%****Important: P_max is the vector consisted of the allocated lower and
%upper transient probability. a is the action which can achieve the maximum
%value of the above equation.


function P_max = o_maximising (transipro_lo_poin,transipro_up_poin,index,numb_Act)
%r_o This is counter used to the iteration to obtain value r_o which 
%can achieve min \sum_{i=1}^{r_o-1}\hat{P}(q,o_i)+\sum_{i=r_o+1}^{|Q|}\breva{P}(q,o_{i})
%r_o varies from 1 to |Q|, where |Q|=max(index)
%****buff=zeros(numb_Act,max(index));%for storing the value under different r_o
L_index=max(index);
transi_order_lo=zeros(numb_Act,L_index);
transi_order_up=zeros(numb_Act,L_index);
judge1=zeros(numb_Act,1);
%This part is to order the lower and upper probabiltiy of transient as the
%arrangement from index
for i=1:L_index
transi_order_lo(:,i)=transipro_lo_poin(:,index(i));
transi_order_up(:,i)=transipro_up_poin(:,index(i));
end
%Main part of O-maximising
for r_o=1:max(index)
    if r_o==1
        %Firstly, calculating the P(q,O_{r_o})
        judge1=transi_order_lo(:,2:max(index))*ones(L_index-1,1);%This is used to make comparison with other iterations
        P_ro=1-judge1; %judge 1 is a vector
        for i_pro=1:numb_Act
            if P_ro(i_pro)<0 %if the P_ro too small, we let it equal to 0
                P_ro(i_pro)=0;
            elseif P_ro(i_pro)>transi_order_up(i_pro,r_o)
                P_ro(i_pro)=transi_order_up(i_pro,r_o);
            end
        end
        buff=[P_ro,transi_order_lo(:,2:max(index))];
    
    elseif r_o>1 && r_o<L_index
        judge2=judge1; %The judgement conditon of the last step
        judge1=transi_order_up(:,1:r_o-1)*ones(r_o-1,1)+transi_order_lo(:,r_o+1:L_index)*ones(L_index-r_o,1);
        P_ro=1-judge1;
        for i_pro=1:numb_Act
            if P_ro(i_pro)<0 %if the P_ro too small, we let it equal to 0
                P_ro(i_pro)=0;
            elseif P_ro(i_pro)>transi_order_up(i_pro,r_o)
                P_ro(i_pro)=transi_order_up(i_pro,r_o);
            end
        end
        %Comparison of each dimension between judge1 and judge2
        for i_judge=1:numb_Act
            if judge1(i_judge)>judge2(i_judge) %if this iteration is larger than the last iteration
                buff(i_judge,:)=[transi_order_up(i_judge,1:r_o-1),P_ro(i_judge),transi_order_lo(i_judge,r_o+1:L_index)];
            else %judge1<=judge2 keep the same as the last iteration
                judge1(i_judge)=judge2(i_judge);
            end
        end
    else %r)o==L_index
        judge2=judge1; %The judgement conditon of the last step
        judge1=transi_order_up(:,1:r_o-1)*ones(r_o-1,1);%
        P_ro=1-judge1;
        for i_pro=1:numb_Act
            if P_ro(i_pro)<0 %if the P_ro too small, we let it equal to 0
                P_ro(i_pro)=0;
            elseif P_ro(i_pro)>transi_order_up(i_pro,r_o)
                P_ro(i_pro)=transi_order_up(i_pro,r_o);
            end
        end
        %Comparison of each dimension between judge1 and judge2
        for i_judge=1:numb_Act
            if judge1(i_judge)>judge2(i_judge) %if this iteration is larger than the last iteration
                buff(i_judge,:)=[transi_order_up(i_judge,1:r_o-1),P_ro(i_judge)];
            else %judge1<=judge2 keep the same as the last iteration
                judge1(i_judge)=judge2(i_judge);
            end
        end
    end
    
end
P_max=buff;

%%%test example, which is used to illustrate this function can select the
%%%vector according to o-minimising

%This case have four states q0,q1,q2,q3
% M_lo=[0,0.05,0,0;0,0,0,0;0,012,0.15,0.57;0,0,0.5,0.44;...
%       0,0,1,0;0.98,0,0,0;0,0,0,1;0,0,0,0];%16x4 matrix
% M_up=[0.05,1,0,0;0,0,0,0;0,0.23,0.2,0.62;0,0,0.56,0.5;...
%       0,0,1,0;1,0,0.05,0;0,0,0,1;0,0,0,0];%16x4 matrix
% Given the first step vector buff0=[0,0,1,0], [buff1,index]=sort(buff0),
% and numb_Act=2. Here we consider the process starting from q1.

%Detals of Code 
%transipro_lo_poin=[0,0.12,0.15,0.57;0,0,0.5,0.44];
%transipro_up_poin=[0,0.23,0.2,0.62;0,0,0.56,0.5];
%buff0=[0,0,1,0];
%[buff1,index]=sort(buff0);
%P_min = o_maximising (transipro_lo_poin,transipro_up_poin,index,numb_Act);



