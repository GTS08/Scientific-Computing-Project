rng default;

n=500;
A = randn(n);
xsol = rand(n,1);
b = A*xsol;

tol = 10^(-6);
maxit = 4*n;

% Problem 1
disp('------------------------------------------------------------------');
disp('PCG');
tic
[x1, flag1, relres1, iter1, resvec1] = pcg(A,b,tol,maxit);
toc

% Figure 1
semilogy (0:length(resvec1)-1, resvec1/norm(b), 'bo-'); hold on;


% Problem 2
m = 100;
disp('------------------------------------------------------------------');
disp('GMRES with restart size = m');
tic
[x2,flag2,relres2,iter2,resvec2] = gmres(A,b,m,tol,maxit);
toc

% Figure 2
semilogy (0:length(resvec2)-1, resvec2/norm(b), 'rx-'); hold on;


% Problem 3
disp('------------------------------------------------------------------');
disp('GMRES with restart size = n');
tic
[x3,flag3,relres3,iter3,resvec3] = gmres(A,b,n,tol,maxit);
toc

% Figure 3
semilogy (0:length(resvec3)-1, resvec3/norm(b), 'g*-'); hold on;

disp('------------------------------------------------------------------');
disp('A\b');
tic
x = A\b;
toc
disp('------------------------------------------------------------------');

ylabel('Relative Error');
xlabel('Iterations');

legend({'x1','x2', 'x3'},'Location','Northeast');
