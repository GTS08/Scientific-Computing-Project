function [val, col_idx, row_blk] = sp_mx2bcrs(A, nb)   
    % Initialize variables
    N = size(A, 1);
    col_idx = [];
    row_blk = [];
    val = [];
    
    % Counter for val
    z = 1;
    
    % Set the first row pointer
    row_blk(end+1) = z;
    for i = 1:nb:N
        % Set the row pointer
        if(~isempty(val))
            row_blk(end+1) = z;
        end
        
        for j = 1:nb:N
            % Get the block
            As = A(i:i+(nb-1),j:j+(nb-1));
            
            % If block is non-zero matrix
            if (nnz(As) ~= 0)
                % Store block in val
                val(:, :, z) = As;
                % Set the column index
                col_idx(end+1) = ceil(j/nb);
                % Increment counter
                z = z + 1;
            end
        end
    end
    
    % Set the last row pointer
    row_blk(end+1) = z;
end
