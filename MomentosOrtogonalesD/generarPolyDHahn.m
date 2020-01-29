% Funcion para Generar la matriz de polinomios DUAL HAHN de un tamaño 
% mUESTRAS y CONSTANTES a, b y c. La inestabilidad llega alrededor de
% Muestras es igual a 50;

function PolidHahn = generarPolyDHahn(N, a,b,c)

% if p<=0 || p>1
%     error('Error. p debe estar entre 0 y 1')
% end

PolidHahn=zeros(N);

s= a:b-1;%N-Muestras+1:N-1+1;

w_0 = sqrt(ro_s(s,a,b,c).*(2.*s+1)./d_n_cuad(a,b,c,0));
w_1 = -((ro_s(s+1,a,b,c).*(s+1-a).*(s+1+b).*(s+1-c))-((ro_s(s,a,b,c)).*(s-a).*(s+b).*(s-c)))./(ro_s(s,a,b,c).*(2.*s+1)).*(sqrt(ro_s(s,a,b,c).*(2.*s+1)./d_n_cuad(a,b,c,1)));

PolidHahn(1,:) = w_0;
PolidHahn(2,:) = w_1;

for n=1:(N-2)
    
    A = (1./(n+1)).*((s.*(s+1))-a.*b + a.*c - b.*c -((b-a-c-1).*(2.*n+1))+(2.*n.^2));
    B = (1./(n+1)).*(a+c+n).*(b-a-n).*(b-c-n);
    nn=n+1;
    D = sqrt((nn)./((a+c+nn).*(b-a-nn).*(b-c-nn)));
    F = sqrt((nn.*(nn-1))./((a+c+nn).*(a+c+nn-1).*(b-a-nn+1).*(b-a-nn).*(b-c-nn+1).*(b-c-nn)));
    
    wn = ((A.*PolidHahn(nn,:)).*D)-((B.*PolidHahn(n,:)).*F);
    PolidHahn(nn+1,:) = wn;        
        

end


end