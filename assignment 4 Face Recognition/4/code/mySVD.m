function [U,S,V] = mySVD(A)
%Function to compute the singular value decomposition of a matrix
    [m,n] = size(A);
    
    %Get eigenvalues and eigenvectors
    [eigvec_u, eigval_u] = eig(A*transpose(A));
    [eigvec_v, eigval_v] = eig(transpose(A)*A);
    
    %Initialize U,V,S
    U_pred = zeros(m,m);
    V_pred = zeros(n,n);
    S_pred = zeros(m,n);
    
    [a, b] = size(eigval_u);
    
    for i = 1:m
        U_pred(:,i) = eigvec_u(:,m-i+1);
    end
    
	for i = 1:n
        V_pred(:,i) = eigvec_v(:,n-i+1);
    end
    
    %Diagonal matrix
    for i = 1:min(m,n);
        S_pred(i,i) = sqrt(eigval_u(a-i+1,a-i+1));
    end
    
    left = U_pred*S_pred;
    right = A*V_pred;
      
    for i = 1:n
        if(transpose(right(:,i))*left(:,i)>=0) 
        else
            U_pred(:,i) = -1*U_pred(:,i);
        end
    end
    
    U = U_pred;
    S = S_pred;
    V = V_pred;
    
    norm(A - U*S*transpose(V))

end