n = 500;

tol = 10^(-6);
maxit = 4*n;

% Problem 1
A1 = spdiags([1:n]',[0],n,n);
xsol1 = ones(n,1);
b1 = A1*xsol1;

[x1, flag1, relres1, iter1, resvec1] = pcg(A1,b1,tol,maxit);

% Figure 1
semilogy (0:length(resvec1)-1, resvec1/norm(b1), 'bo-'); hold on;


% Problem 2
A2 = spdiags([linspace(1,2,n/2)';linspace(1000,1001,n/2)'],[0],n,n);
xsol2 = ones(n,1);
b2 = A2*xsol2;

[x2, flag2, relres2, iter2, resvec2] = pcg(A2,b2,tol,maxit);

% Figure 2
semilogy (0:length(resvec2)-1, resvec2/norm(b2), 'rx-'); hold on;


ylabel('Relative Error');
xlabel('Iterations');

legend({'x1', 'x2'},'Location','Northeast');
