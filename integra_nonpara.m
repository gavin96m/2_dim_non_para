%Zhi Zhang, 31st, May, 2023
%The purpose of this code is to help Chenyu improve his calulation using
%non-parametric estimation to formal verification based on IMDP. In
%details, our skill is that in our calculation, we want to avoid the
%repeated call of the CDF from non-parametric estimation. Becasue the repeated
%call the CDF from non-parametric estimation will result in the repeated
%call of sample data which is very high dimensional. Some basic information
%need to be known. Firstly, X,Y\in R^{n\time d}are the sample data.The non-parametric
%kernel function is Gaussian kernel. H,h\in R_{+}^{d} are the bandwidth of the
%relevant sample data of Y and X. range_Y means the integration interval
%with respect to y. x is the input which is fixed point for the conditional
%density function f_{Y|X}. 
%range_Y uses the lower-left and upper-right points for regioning.
%[0,0,1,1]


function int_y=integra_nonpara(x0,X,Y,range_Y,H,h)
% n=size(X,2);% the sample data scale
% disp(n);

%d=length(X(1,:));%the dimension of system
% d = size(X,1);


cx_vec=(2*pi)^(-0.5)*exp( -0.5*( (x0-X)./h ).^2  );
cx_vecsimpl=prod(cx_vec,1);
cx=sum(cx_vecsimpl); 

% 
% cx_vec=(0.5*pi)^(-0.5)*exp( -0.5*( (x0-X)./h ).^2  );%where H,h\in R^{1\times d}
% cx_vecsimpl=prod(cx_vec,2);
% cx=ones(1,n)*prod(cx_vec,2);%cx is the real number
% Define the region boundaries from range_Y
x_min = range_Y(1);
x_max = range_Y(3);
y_min = range_Y(2);
y_max = range_Y(4);





int_y = integral2(@(x, y) speedup_nonparestim(x, y, cx, cx_vecsimpl, Y, H, h), x_min, x_max, y_min, y_max);



end




