function P = band_stats(mxid, p)  
    if (isscalar(mxid) || isstring(mxid))
        A = ssget(mxid).A;
    elseif (ismatrix(mxid))
        A = mxid;
    else
        error('Please provide a valid mxid.');
    end
    
    % Initialize variables
    
    N = size(A, 1);
    k = zeros(1, p);
    P = zeros(p+1, 2);
    
    % Calculate k array
    for i = 1:(p+1)
        k(i) = 2 * (i-1) + 1;
    end
    
    % Check if p is non-negative
    if (p < 0)
        error('The provided p should be non-negative.');
    end
    
    % Check if p is too big for the provided matrix
    if (k(end)*2 + 1 > N)
        error('The provided p is too big for this matrix.');
    end
    
    % Main loop
    for i = 1:length(k)
        if (k(i) == 1)
            % Initialize Ak with the main diagonal of A
            Ak = diag(diag(A));
            % Above main diagonal
                
            % Get the diagonal position
            diagPos = k(i);
            % Get the diagonal
            Bin = diag(A, diagPos)';
            % Add zeros at the start of the diagonal
            Bin = [zeros(1, max(0, N-numel(Bin))), Bin]';
            % Place the diagonal to Ak
            Ak = spdiags(Bin,diagPos,Ak);
            
            % Below main diagonal
            
            % Get the diagonal position
            diagPos = -diagPos;
            % Get the diagonal
            Bin = diag(A, diagPos)';
            % Add zeros at the end of the diagonal
            Bin(N) = 0;
            % Reverse Bin
            Bin = Bin';
            % Place the diagonal to Ak
            Ak = spdiags(Bin,diagPos,Ak);
            
        else
            % Add the necessary diagonals to Ak based on k
            for j = 1:2
                % Above main diagonal
                
                % Get the diagonal position
                diagPos = (k(i)+1) - j;
                % Get the diagonal
                Bin = diag(A, diagPos)';
                % Add zeros at the start of the diagonal
                Bin = [zeros(1, max(0, N-numel(Bin))), Bin]';
                % Place the diagonal to Ak
                Ak = spdiags(Bin,diagPos,Ak);
                
                % Below main diagonal
                
                % Get the diagonal position
                diagPos = -diagPos;
                % Get the diagonal
                Bin = diag(A, diagPos)';
                % Add zeros at the end of the diagonal
                Bin(N) = 0;
                % Reverse Bin
                Bin = Bin';
                % Place the diagonal to Ak
                Ak = spdiags(Bin,diagPos,Ak);
            end
        end
        % Calculate rnnz
        rnnz = nnz(Ak) / nnz(A);
        % Calculate rerr
        rerr = norm(A - Ak,'fro') / norm(A,'fro');
        % Store rnnz and rerr to P
        P(i, :) = [rnnz rerr];
    end
end
