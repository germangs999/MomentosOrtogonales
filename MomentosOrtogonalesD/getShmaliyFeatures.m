function  features = getShmaliyFeatures(patches,ShmaliyPoli)

[Y, X, NROWS] = size(patches); %Tamaño de la imagen
features = zeros(NROWS, Y+X-1); % Tamaño del vector de características
im = mat2gray(patches); %La imagen la pasamos a mat2gra (0...1)
im = im - mean(im(:)); %Le quitamos el promedio

%% Calcular los polinomios de Krawtchouk
[num_rows,num_cols] = size(im);
Sm = ShmaliyPoli(num_rows).vec;%enerarPolyShmaliy(num_rows); %MAtriz para x
Sn = ShmaliyPoli(num_cols).vec;%generarPolyShmaliy(num_cols); % Matriz para y
Smn = Sm*im*Sn'; %Proyeccion sobre la imagen

Smn_mirror = fliplr(Smn);
num_diags = (num_rows + num_cols - 1);

for k=-(num_diags-1)/2:1:(num_diags-1)/2
    aux2(1,k + ((num_diags-1)/2) + 1) = sum(abs(diag(Smn_mirror,k)));
end
features = fliplr(aux2);

end


% %%GeneraR los momentos para 10 20 30 40 y 50
% 
% for k = 1:50
%     [ShmaliyPoli(k).vec, ~] = generarPolyShmaliy(k);
%     
% end
% 
% save('ShmaliyPoli.mat', 'ShmaliyPoli')