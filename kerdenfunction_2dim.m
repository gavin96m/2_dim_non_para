%%%Zhi Zhang, 06.04.2022, newcastle university, 
%%%This function is used to calculate the estimate density function based
%%%on the nonparametric estimation. 
%%%Compared with function-twodimenofcaseoftwovariable4CKDF_LC.m, this
%%%function can be working for any dimension situation with system y=Ax+w.
%%%Important: in this function, we use the cross-validation bandwidth
%%%selection method to obtain the optimal bandwidth for the kernel density
%%%function.
%%%Illustration of inputs: 
% x is the samples of current state (which should satisfy uniform density distribution), and its value of density function is xf;
% y is the samples of the next state, and normally should satisfy system y=Ax+w; 
% w is the Gaussian white noise, sigma_noise is the variance and mu_noise is the mean of noise; 
% hx_cy and hy_cv is the optimal bandwidth from the cross-validation; 
% x_point and y_point is the point that we want to calculate its value of kernel density function;
function store = kerdenfunction_2dim(x,y,hx_cv,hy_cv,x_point,y_point)
d=length(x(:,1)); %Generate the dimension of our study problem, x should be dxn
n=length(x(1,:));
f1=0;
f2=0;
for i_ker=1:n
    f1=f1+(n*prod(hx_cv)*prod(hy_cv))^(-1)*((2*pi)^(-(0.5)))^(2*d)*...
exp(-(((x_point(1)-x(1,i_ker))/hx_cv(1))^(2))/2)*exp(-(((x_point(2)-x(1,i_ker))/hx_cv(2))^(2))/2)*...
exp(-(((y_point(1)-y(1,i_ker))/hy_cv(1))^(2))/2)*exp(-(((y_point(2)-y(2,i_ker))/hy_cv(2))^(2))/2);
    
    f2=f2+(n*prod(hx_cv))^(-1)*(  ((2*pi)^(-(0.5)))^(d)*...
        exp(-(((x_point(1)-x(1,i_ker))/hx_cv(1))^(2))/2)*exp(-(((x_point(2)-x(1,i_ker))/hx_cv(2))^(2))/2) );
end
store=f1/f2;
end






