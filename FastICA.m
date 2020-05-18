function Z = FastICA( X )

% Centralize 
[M,T]=size(X);  
average=mean(X')';  
for i=1:M
    X(i,:)=X(i,:)-average(i)*ones(1,T);
end

% Whitening
Cx=cov(X',1); 
[eigvector,eigvalue]=eig(Cx);  
W=eigvalue^(-1/2)*eigvector';  
Z=W*X;   

% Itreation setting
Maxcount=100000;  % Max iteration number
Critical=0.00001;  
m=M;
W=rand(m);
for n=1:m
    WP=W(:,n);  
    count=0;
    LastWP=zeros(m,1);
    W(:,n)=W(:,n)/norm(W(:,n));
    while abs(WP-LastWP)&abs(WP+LastWP)>Critical
        count=count+1;  
        LastWP=WP;
        % Update Wn+1
        for i=1:m
            WP(i)=mean(Z(i,:).*(tanh((LastWP)'*Z)))-(mean(1-(tanh((LastWP))'*Z).^2)).*LastWP(i);
        end
        WPP=zeros(m,1);
        % Use Gram-Schmidt-like decorrelation
        for j=1:n-1
            WPP=WPP+(WP'*W(:,j))*W(:,j);
        end
        WP=WP-WPP;
        WP=WP/(norm(WP));
        if count==Maxcount
            return
        end
    end
    W(:,n)=WP;
end
Z=W'*Z;
end
