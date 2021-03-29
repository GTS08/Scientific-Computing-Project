function [y] = spmv_bcrs(y, val, col_idx, row_blk, x)
    % Calculate n 
    n = length(row_blk) - 1;
    
    % Calculate the step for the main loop
    p = length(val(:,:,1));
    
    % Main Loop
    for i = 1:p:n*p
        % Calculate k1, k2 for col_idx
        k1 = row_blk(ceil(i/p));
        k2 = row_blk(ceil(i/p+1))-1;
        
        % Index for x
        index = col_idx(k1:k2);
        
        % Reset the sum of matrices products
        sum_prod = zeros(p, 1);
        
        % Calculate the sum of matrices products
        for j = 1:length(index)
            % Sum of matrices products
            sum_prod = sum_prod + val(:,:,k1+(j-1))*x(index(j)*p-(p-1): index(j)*p);
        end
        
        % Add y to sum_prod
        y(i:i+(p-1)) = y(i:i+(p-1)) + sum_prod;
    end
end
