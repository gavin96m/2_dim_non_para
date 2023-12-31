%Zhi Zhang, 31st, May, 2023
%This code should cooperate with the function-integra_nonpara(x,X,Y,range_Y,H,h)
%This purpose of this function is to generate the CDF based on the
%non-parametric estimation. The inputs are x,X,Y,H,h. x is the fixed value
%from the conditional variable. X and Y are the sample datas. H and h are
%the bandwidth of sample data Y and X. Here the non-parametric kernel
%function is the Gaussian kernel. cx=cx_vecsimpl=prod(cx_vec,2);
% cx_vecsimpl is prod(cx_vec,2) where cx_vec=(0.5*pi)^(-0.5)*exp( -0.5*( (x-X)./h )^2  ).

% X,Y combine the location of x0;
% cx,cx_vecsimpl is calculate
% Size of X:
%     14    14
% 
% Size of Y:
%     14    14
% 
% Size of cx:
%      1     1
% 
% Size of cx_vecsimpl:
%            1        1000
% 
% Size of sample_Y:
%            2        1000
% 
% Size of H:
%      2     1
% 
% Size of h:
%      2     1

function f = speedup_nonparestim(X, Y, cx, cx_vecsimpl, sample_Y, H, h)
    [n, m] = size(X);
    f = zeros(n, m);

    % disp(n);
    % disp(m);
    % disp("asdf");
    % disp(size(sample_Y));
    for i = 1:n
        for j = 1:m

            y = [X(i, j); Y(i, j)]; 
            % size(y)
            
            y = repmat(y, 1, size(sample_Y, 2));  % replicate y to match the size of sample_Y
            % disp(y);
            
            cy_vec = (2*pi)^(-0.5) * exp(-0.5 * ((y - sample_Y) ./ H).^2);
            % disp("11111");
            % disp(cy_vec);
            % disp(size(cy_vec));
            % disp((2*pi)^(-0.5)*exp([0;-0.125])); %useless
            % disp("22222");
            cy_vecsimpl = prod(cy_vec, 1);
            % disp("cy_vecsimpl");
            % disp(cy_vecsimpl);
            % disp(size(cy_vecsimpl));
            % disp("----");
            f(i, j) = (prod(H)*prod(h))^(-1)*sum(cx_vecsimpl.*cy_vecsimpl)*(prod(h)^(-1)*cx)^(-1);
            % disp("sum");
            % disp(sum(cx_vecsimpl.*cy_vecsimpl));
            % disp(cx_vecsimpl);
            % disp(sum(cx_vecsimpl.*cy_vecsimpl));
            % disp((prod(h)^(-1)*cx)^(-1));

            % disp("f");
            % disp(f(i,j));
        end
    end
end

% % change 
% function f = speedup_nonparestim(x0_X, x0_Y, cx, cx_vecsimpl, sample_Y, H, h)
% %     f = zeros(n, m);
% 
% %     for i = 1:n
% %         for j = 1:m
%     x0 = [x0_X; x0_Y];
%     y = repmat(x0, 1, size(sample_Y, 2));  % replicate y to match the size of sample_Y
%     cy_vec = (2*pi)^(-0.5)*exp(-0.5 * sum(((y - sample_Y) ./ H).^2, 1));
% 
%     cy_vecsimpl = prod(cy_vec, 1);
%     f = (prod(H)*prod(h))^(-1)*sum(cx_vecsimpl.*cy_vecsimpl)*(prod(h)^(-1)*cx)^(-1);
%        
% end
