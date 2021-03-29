function adj_walk_matrix = adj_walks(A, k)
    n = length(A);
    
    adj_walk_matrix = tenzeros(n,n,k);
    
    for i=1:k
        adj_walk_matrix(:,:,i) = A^i;
    end
end
