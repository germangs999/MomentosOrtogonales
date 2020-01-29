function  features = getKrawtFeatures(patches, p1,p2)

[Y, X, NROWS] = size(patches); %Tamaño de la imagen
features = zeros(NROWS, Y+X-1); % Tamaño del vector de características
im = mat2gray(patches); %La imagen la pasamos a mat2gra (0...1)
im = im - mean(im(:)); %Le quitamos el promedio

%% Calcular los polinomios de Krawtchouk
[num_rows,num_cols] = size(im);
Km = generarPolyKraw(num_rows,p1); %MAtriz para x
Kn = generarPolyKraw(num_cols,p2); % Matriz para y
Kmn = Km*im*Kn'; %Proyeccion sobre la imagen

Kmn_mirror = fliplr(Kmn);
num_diags = (num_rows + num_cols - 1);

for k=-(num_diags-1)/2:1:(num_diags-1)/2
    aux2(1,k + ((num_diags-1)/2) + 1) = sum(abs(diag(Kmn_mirror,k)));
end
features = fliplr(aux2);

end
