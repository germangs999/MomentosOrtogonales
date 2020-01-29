 function PoliShmaliy = generarPolyShmaliy_tiempo(N)

%N = Muestras-1;
n = 0:N-1; % x es la variable discreta

%Normalizacion

% w = (2.*n)./((N+1).*((N+1)-1));
% ww = repmat(w,[N,1]);

PoliShmaliy = zeros(N);

%Polinomio de orden cero
PoliShmaliy(1,:) = (1/(N+1)).*ones(1,N);

%Polinomio de orden uno
PoliShmaliy(2,:) = ((-6.*n)+(2.*(2*(N+1)-1)))./((N+1).*((N+1)+1));

% for p = 0:1
%     
%     ro = ((p+1).*(pochhammer((N+1)-p-1, p)))./((N+1).*pochhammer(N+1,p+1)); 
%     %ro_ro(1,p+1) = ro;
%     %((p+1).*gamma(N-1)./gamma(N-p-1)) ./ (N.*gamma(N+p+1)./gamma(N));
%     C= sqrt(ww(p+1,:)./ro);
%     PoliShmaliy_N(p+1,:) =  PoliShmaliy(p+1,:).*C;
% end 

%Iteracion

for p = 2:(N-1)
    
   A = (2.*( ((p^2).*(2*(N+1)-1))  -  (n.*((4*p^2)-1))  ))./(p.*(2.*p-1).*((N+1)+p));
   
   B = ((2*p+1).*((N+1)-p))./((2*p-1).*((N+1)+p));
   
   PoliShmaliy(p+1,:) = A.*PoliShmaliy(p,:) - B.*PoliShmaliy(p-1,:);
   
%    ro = ((p+1).*(pochhammer((N+1)-p-1, p)))./((N+1).*pochhammer(N+1,p+1)); 
% 
%    C= sqrt(ww(p+1,:)./ro);
%    PoliShmaliy_N(p+1,:) =  PoliShmaliy(p+1,:).*C; 
end    


%ro = zeros(size(PoliShmaliy,1),1);

% for p = 0:(N-1)
%     
%     ro = ((p+1).*(pochhammer((N+1)-p-1, p)))./((N+1).*pochhammer(N+1,p+1)); 
%     %ro_ro(1,p+1) = ro;
%     %((p+1).*gamma(N-1)./gamma(N-p-1)) ./ (N.*gamma(N+p+1)./gamma(N));
%     C(p+1,:) = sqrt(ww(p+1,:)./ro);
%     
% end 
% 
% %polinomios normalizados
% 
%  PoliShmaliy_N =  PoliShmaliy.*C;


end