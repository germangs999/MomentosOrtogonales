% Funcion para Generar la matriz de polinomios de Krawtchouk de un tamaño 
% Muestras y posicionamiento p entre 0 y 1. Entre mas cercano este del 
% límite, p será inestasble y también depende del tamaño Muestras.

function PoliKraw = generarPolyKraw(Muestras, p)

if p<=0 || p>1
    error('Error. p debe estar entre 0 y 1')
end

N = Muestras-1;
x = 0:N; % x es la variable discreta

PoliKraw = zeros(Muestras);

%polinomio orden cero
Ncx1 = (factorial(N))./(factorial(x).*(factorial(N-x))); %opcion 1
%Ncx2 = -(N.*gamma(N))./(x.^2.*gamma(x).*gamma(N - x) - N.*x.*gamma(x).*gamma(N - x)); %opcion 2
weight = Ncx1.*(p.^x).*((1-p).^(N-x));
n = 0;
Ncn1 = (factorial(N))./(factorial(n).*(factorial(N-n)));
%Ncn2 = -(N.*gamma(N))./(n.^2.*gamma(n).*gamma(N - n) - N.*n.*gamma(n).*gamma(N - n));
norm = (((1-p)/p).^n).*(1./Ncn1);
PoliKraw(1,:) = sqrt(weight./norm);

%Polinomio de orden uno
n = 1;
Ncn1 = (factorial(N))./(factorial(n).*(factorial(N-n)));
norm = (((1-p)/p).^n).*(1./Ncn1);
PoliKraw(2,:) = (1-(x./(N.*p))).*(sqrt(weight./norm));

%Iteracion

for n=1:(N-1)
    A = sqrt((p./(1-p)).*((N-n)./(n+1)));
    B = (p./(1-p)).*(sqrt(((N-n).*(N-n+1))./(n.*(n+1))));
    beta1 = ((N.*p)-(2.*n.*p)+n-x)./((N-n).*p);
    beta2 = (n.*(1-p))./((N-n).*p);  
    PoliKraw(n+2,:) = A.*beta1.*PoliKraw(n+1,:) - B.*beta2.*PoliKraw(n,:);
end


end