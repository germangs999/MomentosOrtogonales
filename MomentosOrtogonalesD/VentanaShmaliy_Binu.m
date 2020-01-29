%Programa para generar todos los momentos de las imagenes de cada carpeta
clear;
close all;
clc;

dir_bin = 'binucleate/binucleate/';
dir_nbin = 'binucleate/non_binu/';

%Todos los nombres de las imagenes en D.name
D1=dir([dir_bin '*.tif']);
D2=dir([dir_nbin '*.tif']);

D = [D1; D2];

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

save('DescShmaliy.mat', 'DescShmaliy')

