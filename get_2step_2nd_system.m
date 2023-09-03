function get_2step_2nd_system(n,filename)
    fileID = fopen(filename, 'w');
    fprintf(fileID, 'init_x,init_y,next_x,next_y\n');

    A = [0.8, 0.5; 0.0, 0.5];
    channel_size = n + 1;
    height = 2;
    width = 1;
    mu = 0;
%     sigma = 0.1;
    sigma = 1;
    
    for i = 1:n
        noise_matrix = normrnd(mu, sigma, [channel_size, height, width]);
        
        x_init = init_sample();
        n_noise = reshape(noise_matrix(i, :, :), 1, []);

        [x_init, x_next] = get_next(x_init, n_noise, A);
%         if i == 1
%             disp(x_init);
%             disp(x_next);
%         end
%         fprintf(fileID, '%f,%f\n', x_next(1), x_next(2));
        data = [x_init',x_next'];
        fprintf(fileID, '%f,%f,%f,%f\n', data);
    end
    fclose(fileID);
    disp(['Sample data generated. n = ', num2str(n)]);

end

function [x_init, x_next] = get_next(init_data, n_noise, A)
    x_init = init_data;
    x_next = A * init_data + n_noise';
end

function x_init = init_sample()
    x_init = [rand() * 1, rand() * 1]';
end
