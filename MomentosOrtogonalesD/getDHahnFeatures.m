function  features = getDHahnFeatures(patches, a,b,c)

[Y, X, NROWS] = size(patches); %Tamaño de la imagen
features = zeros(NROWS, Y+X-1); % Tamaño del vector de características
im = mat2gray(patches); %La imagen la pasamos a mat2gra (0...1)
im = im - mean(im(:)); %Le quitamos el promedio

%% Calcular los polinomios de Krawtchouk
[num_rows,num_cols] = size(im);
DHm = generarPolyDHahn(num_rows,a,b,c); %MAtriz para x
DHn = generarPolyDHahn(num_cols,a,b,c); % Matriz para y
DHmn = DHm*im*DHn'; %Proyeccion sobre la imagen

DHmn_mirror = fliplr(DHmn);
num_diags = (num_rows + num_cols - 1);

for k=-(num_diags-1)/2:1:(num_diags-1)/2
    aux2(1,k + ((num_diags-1)/2) + 1) = sum(abs(diag(DHmn_mirror,k)));
end
features = fliplr(aux2);

end