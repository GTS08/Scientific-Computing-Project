% Get 1st matrix
A1 = ssget('HB/sherman2').A;

% Set the block
nb1 = 40;

% Calculate bcrs values
[val1, col_idx1, row_blk1] = sp_mx2bcrs(A1, nb1);

% Get a y
y1n = A1(:,1);

% Get a x
x1 = A1(:,2);

% Calculate y = y + Ax normally
y1n = y1n + A1*x1;

% Get the same y as before
y1b = A1(:,1);

% Calculate y = y + Ax with sp_mx2bcrs function
[y1b] = spmv_bcrs(y1b, val1, col_idx1, row_blk1, x1);

% Calculate relative error
rerr1 = norm(y1n - y1b,'fro') / norm(y1n,'fro');


% Get 2nd matrix
A2 = ssget('ML_Graph/Plants_10NN').A;

% Set the block
nb2 = 80;

% Calculate bcrs values
[val2, col_idx2, row_blk2] = sp_mx2bcrs(A2, nb2);

% Get a y
y2n = A2(:,1);

% Get a x
x2 = A2(:,2);

% Calculate y = y + Ax normally
y2n = y2n + A2*x2;

% Get the same y as before
y2b = A2(:,1);

% Calculate y = y + Ax with sp_mx2bcrs function
[y2b] = spmv_bcrs(y2b, val2, col_idx2, row_blk2, x2);

% Calculate relative error
rerr2 = norm(y2n - y2b,'fro') / norm(y2n,'fro');
