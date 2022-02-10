function Y=mouv135225(X,d)
    
    n=(274.5-112.5)/d;
    a=pi/180;
    L=length(X)/n;
    Y=[0;0;0;0;0;0;0;0];
    X=X';
    
    disp(size(X));
    disp(size(Y));

   C=[1 sqrt(2) 0 sqrt(2) 0; 
   1 1 1 0 sqrt(2);
   1 0 sqrt(2) -1*sqrt(2) 0;
   1 -1 sqrt(2) 0 -sqrt(2);
   1 -sqrt(2) 0 sqrt(2) 0 ;
   1 -1 -1 0 sqrt(2);
   1 0 -sqrt(2) -1*sqrt(2) 0;
   1 1 -1 0 -sqrt(2)];
   
  disp(size(C));

    
    for i=1:n
          Ybis=[1;
             sqrt(2)*cos(a*d*i+a*112.5);
             sqrt(2)*sin(a*d*i+a*112.5);
             sqrt(2)*cos(2*a*d*i+a*112.5);
             sqrt(2)*sin(2*a*d*i+a*112.5)];

        disp(size(Ybis));
          Xbis=X(L*(i-1)+1:L*i);
          Xvis=C*Ybis*Xbis;
          disp(size(Xvis));
          Y=[Y Xvis];  
    end
   
end