%Programa para generar todos los momentos de las imagenes de cada carpeta
clear;
close all;
clc;

%Directorio de las imagenes
dir_clas{1} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Lymphoma\Lymphoma\CLL_1\';
dir_clas{2} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Lymphoma\Lymphoma\FL_1\';
dir_clas{3} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Lymphoma\Lymphoma\MCL_1\';


D = [];
for i = 1:size(dir_clas,2)
   lista =  dir([dir_clas{i} '*.tif']);
   D = [D; lista];
   clear lista;
end  

l=1;
for j=10:10:50
    vent{l} = ['vent' num2str(j)];
    l=l+1;
end

for i=1:size(D,1) %Para todas las imagenes dentro del folder size(D,1)
 
   for tam = 20:10:50 %Para todos los tama�os posibles
       
       I =imread([D(i).folder '\' D(i).name]);

       if size(I,3)>1 %Condicion para que quede en una dimension
           I=rgb2gray(I);
       end
       tic;
       %ShmaliyMomentosVentana = 
       DescShmaliy(i).(vent{tam/10}) = ObtenerShmaliyVentana(I,tam);
       %ShmaliyMomentosVentana;
       toc; 
       [tam i]
   end
end  

save('DescShmaliy_Lymphoma.mat', 'DescShmaliy')

