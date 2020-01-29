%Programa para generar todos los momentos de las imagenes de cada carpeta
clear;
close all;
clc;

%Directorio de las imagenes
dir_clas{1} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Hela\hela\actin\';
dir_clas{2} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Hela\hela\dna\';
dir_clas{3} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Hela\hela\endosome\';
dir_clas{4} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Hela\hela\er\';
dir_clas{5} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Hela\hela\golgia\';
dir_clas{6} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Hela\hela\golgpp\';
dir_clas{7} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Hela\hela\lysosome\';
dir_clas{8} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Hela\hela\microtubules\';
dir_clas{9} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Hela\hela\mitochondria\';
dir_clas{10} = 'C:\Users\German2\OneDrive\AplicacionTexton_FINAL\Hela\hela\nucleolus\';


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
 
   for tam = 20:10:50 %Para todos los tamaños posibles
       
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

save('DescShmaliy_Hela.mat', 'DescShmaliy')

