% funcion oara ro de s
function ro =  ro_s(s,a,b,c)

A = gamma(a+s+1).*gamma(c+s+1);
B = gamma(s-a+1).*gamma(b-s).*gamma(b+s+1).*gamma(s-c+1);

ro = A./B;

end