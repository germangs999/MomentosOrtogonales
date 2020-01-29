function [PoliShmaliy_N, PoliShmaliy] = generarPolyShmaliy(N)

%N = Muestras-1;
n = 0:N-1; % x es la variable discreta

PoliShmaliy = zeros(N);

%Polinomio de orden cero
PoliShmaliy(1,:) = (1/(N+1)).*ones(1,N);

%Polinomio de orden uno
PoliShmaliy(2,:) = ((-6.*n)+(2.*(2*(N+1)-1)))./((N+1).*((N+1)+1));

%Iteracion

for p = 2:(N-1)
    
   A = (2.*( ((p^2).*(2*(N+1)-1))  -  (n.*((4*p^2)-1))  ))./(p.*(2.*p-1).*((N+1)+p));
   
   B = ((2*p+1).*((N+1)-p))./((2*p-1).*((N+1)+p));
   
   PoliShmaliy(p+1,:) = A.*PoliShmaliy(p,:) - B.*PoliShmaliy(p-1,:);
    
end    


% figure()
% hold on
% for k = 1:6
% 
%    plot(PoliShmaliy(k,:)) 
% end

% MM=repmat(PoliShmaliy(:,1), [1,Muestras]);
% Poli = PoliShmaliy./MM;
% figure()
% hold on
% for k = 1:10
% plot(Poli(k,:))
% end

%Normalizacion

w = (2.*n)./((N+1).*((N+1)-1));
ww = repmat(w,[N,1]);

%ro = zeros(size(PoliShmaliy,1),1);

for p = 0:(N-1)
    
    ro = ((p+1).*(pochhammer((N+1)-p-1, p)))./((N+1).*pochhammer(N+1,p+1)); 
    %ro_ro(1,p+1) = ro;
    %((p+1).*gamma(N-1)./gamma(N-p-1)) ./ (N.*gamma(N+p+1)./gamma(N));
    C(p+1,:) = sqrt(ww(p+1,:)./ro);
    
end 

%polinomios normalizados

 PoliShmaliy_N =  PoliShmaliy.*C;
% 
% figure()
% plot(0:N-1, ro_ro) 
 
%  figure()
% hold on
% for k = 1:4
% 
%    
% end

end