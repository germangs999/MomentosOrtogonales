function dn_cuad = d_n_cuad(a, b, c, n)
    %n es el grado del poliomio

    A = gamma(a+c+n+1);
    B = factorial(n).*factorial(b-a-n-1).*gamma(b-c-n);
    dn_cuad = A./B;

end