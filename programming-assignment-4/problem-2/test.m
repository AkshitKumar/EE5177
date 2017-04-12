% Bounded least squares problem
     % input data
     m = 16; n = 8;
     A = randn(m,n);
     b = randn(m,1);
     bnds = randn(n,2);
     l = min( bnds, [] ,2 );
     u = max( bnds, [], 2 );
     % cvx version
     cvx_begin
         variable x(n)
         minimize(1/2*x'*P*x + q'*x)
         subject to
             l <= x <= u
             G*x <= h
     cvx_end