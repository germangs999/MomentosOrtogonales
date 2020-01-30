%%Utilizar los polinomios de Shmaliy, Tchebi, Krawt, DHAHN para generar 
%%vectores de características útiles para la clasificación de la base de
%%datos Lymphoma

clear; close all; clc;
%Agregar la carpeta que contiene todas las funciones para calcular los
%polinomios y los momentos al path
addpath MomentosOrtogonales

%Leer los datos
carpeta  = 'Lymphoma';
vent = {'vent20', 'vent30', 'vent40','vent50'};
D = dir(carpeta);
%Todas las carpetas contenidas (3 carpetas por cada clase)
D = D(3:end); 

for carp = 1:size(D,1) %Analizar cada carpeta
   %Listado de las imágenes contenidas en las carpetas 
   DD = dir([carpeta '\' D(carp).name '\*.tif']); 
   
   for noimg = 1:size(DD,1) %Analizar cada imagen
      
      %Leer la imagen 
      Img = imread([carpeta '\' D(carp).name '\' DD(noimg).name]);
      %Si la imagen es a color, cambiarla a escala de grises
      if size(Img,3) > 1
          Img = rgb2gray(Img);
      end
      
      %%%%%Calcular los momentos de cada ventana dentro de laimagen
      tam  = [20 30 40 50]; % diferentes tamaños de ventana
      
      tic;
      for t = 1:size(tam,2) %Tamaño de la ventana
          %Primero la clase y el numero de imagen, tamaño de ventana  
          Lymphoma_TchebiMomentos.(D(carp).name)(noimg).vent{t} = single(ObtenerTchebiVentana(Img,tam(t)));
          Lymphoma_KrawtMomentos.(D(carp).name)(noimg).vent{t} = single(ObtenerKrawtVentana(Img,tam(t),0.5,0.5));
          Lymphoma_ShmaliyMomentos.(D(carp).name)(noimg).vent{t} = single(ObtenerShmaliyVentana(Img,tam(t)));
          Lymphoma_DHahnMomentos.(D(carp).name)(noimg).vent{t} = single(ObtenerDHahnVentana(Img,tam(t),0,tam(t),0));
      end
      toc;
      
   end
save('Lymphoma_TchebiMomentos.mat', 'Lymphoma_TchebiMomentos');
save('Lymphoma_KrawtMomentos.mat', 'Lymphoma_KrawtMomentos');
save('Lymphoma_ShmaliyMomentos.mat', 'Lymphoma_ShmaliyMomentos');
save('Lymphoma_DHahnMomentos.mat', 'Lymphoma_DHahnMomentos');
end