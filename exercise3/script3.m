A = [0,1,1,1;1,0,1,0;1,1,0,0;1,0,0,0];

n = length(A);

k = 4;

adj_walk_matrix = adj_walks(A, k);

all_walks = zeros(n,n);

for i=1:k
    all_walks = all_walks + double(adj_walk_matrix(:,:,i));
end
