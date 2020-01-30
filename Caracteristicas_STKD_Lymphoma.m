    %Implementar la clasificacion a traves de la combinacion de estadisticaos
clear; close all; clc;

carpeta  = 'Lymphoma';
vent = {'vent20', 'vent30', 'vent40','vent50'};
tam  = [20 30 40 50];
D = dir(carpeta);
D = D(3:end); %Todas las carpetas contenidas


load('Lymphoma_ShmaliyMomentos.mat');
load('Lymphoma_TchebiMomentos.mat');
load('Lymphoma_KrawtMomentos.mat');
load('Lymphoma_DHahnMomentos.mat');


etiquetas=[];

for t = 1:size(tam,2)
    
    %Donde se almacenaran las opciones
    op1S = []; op2S = []; op3S = [];
    op4S = []; op5S = []; op6S = []; op7S = [];
    
    op1T = []; op2T = []; op3T = [];
    op4T = []; op5T = []; op6T = []; op7T = [];
    
    op1K = []; op2K = []; op3K = [];
    op4K = []; op5K = []; op6K = []; op7K = [];
    
    op1D = []; op2D = []; op3D = [];
    op4D = []; op5D = []; op6D = []; op7D = [];
    
for carp = 1:size(D,1)
    
    DD = dir([carpeta '\' D(carp).name '\*.tif']);
    
    if t==1
        etiquetas = [etiquetas; repmat(carp-1,size(DD,1),1)];
    end
    
    for noimg = 1:size(DD,1)

            FirmaS = Lymphoma_ShmaliyMomentos.(D(carp).name)(noimg).vent{t};
            Mean_FirmaS = mean(FirmaS);
            STD_FirmaS = std(FirmaS,0,1);
            Kurt_FirmaS = kurtosis(FirmaS);

            FirmaT = Lymphoma_TchebiMomentos.(D(carp).name)(noimg).vent{t};
            Mean_FirmaT = mean(FirmaT);
            STD_FirmaT = std(FirmaT,0,1);
            Kurt_FirmaT = kurtosis(FirmaT);
            
            FirmaK = Lymphoma_KrawtMomentos.(D(carp).name)(noimg).vent{t};
            Mean_FirmaK = mean(FirmaK);
            STD_FirmaK = std(FirmaK,0,1);
            Kurt_FirmaK = kurtosis(FirmaK);
            
            FirmaD = Lymphoma_DHahnMomentos.(D(carp).name)(noimg).vent{t};
            Mean_FirmaD = mean(FirmaD);
            STD_FirmaD = std(FirmaD,0,1);
            Kurt_FirmaD = kurtosis(FirmaD);

            %opciones
            op1S = [op1S; Mean_FirmaS STD_FirmaS Kurt_FirmaS];
            op2S = [op2S; Mean_FirmaS STD_FirmaS];
            op3S = [op3S; Mean_FirmaS Kurt_FirmaS];
            op4S = [op4S; STD_FirmaS Kurt_FirmaS];
            op5S = [op5S; Mean_FirmaS];
            op6S = [op6S; STD_FirmaS];
            op7S = [op7S; Kurt_FirmaS];
            
            op1T = [op1T; Mean_FirmaT STD_FirmaT Kurt_FirmaT];
            op2T = [op2T; Mean_FirmaT STD_FirmaT];
            op3T = [op3T; Mean_FirmaT Kurt_FirmaT];
            op4T = [op4T; STD_FirmaT Kurt_FirmaT];
            op5T = [op5T; Mean_FirmaT];
            op6T = [op6T; STD_FirmaT];
            op7T = [op7T; Kurt_FirmaT];
            
            op1K = [op1K; Mean_FirmaK STD_FirmaK Kurt_FirmaK];
            op2K = [op2K; Mean_FirmaK STD_FirmaK];
            op3K = [op3K; Mean_FirmaK Kurt_FirmaK];
            op4K = [op4K; STD_FirmaK Kurt_FirmaK];
            op5K = [op5K; Mean_FirmaK];
            op6K = [op6K; STD_FirmaK];
            op7K = [op7K; Kurt_FirmaK];
            
            op1D = [op1D; Mean_FirmaD STD_FirmaD Kurt_FirmaD];
            op2D = [op2D; Mean_FirmaD STD_FirmaD];
            op3D = [op3D; Mean_FirmaD Kurt_FirmaD];
            op4D = [op4D; STD_FirmaD Kurt_FirmaD];
            op5D = [op5D; Mean_FirmaD];
            op6D = [op6D; STD_FirmaD];
            op7D = [op7D; Kurt_FirmaD];
            %Caracteristicasop1 = [Caracteristicasop1; op1];
            
    end             
end

CaracteristicasS(1).vent{t}  = op1S;
CaracteristicasS(2).vent{t}  = op2S;
CaracteristicasS(3).vent{t}  = op3S;
CaracteristicasS(4).vent{t}  = op4S;
CaracteristicasS(5).vent{t}  = op5S;
CaracteristicasS(6).vent{t}  = op6S;
CaracteristicasS(7).vent{t}  = op7S;

CaracteristicasT(1).vent{t}  = op1T;
CaracteristicasT(2).vent{t}  = op2T;
CaracteristicasT(3).vent{t}  = op3T;
CaracteristicasT(4).vent{t}  = op4T;
CaracteristicasT(5).vent{t}  = op5T;
CaracteristicasT(6).vent{t}  = op6T;
CaracteristicasT(7).vent{t}  = op7T;

CaracteristicasK(1).vent{t}  = op1K;
CaracteristicasK(2).vent{t}  = op2K;
CaracteristicasK(3).vent{t}  = op3K;
CaracteristicasK(4).vent{t}  = op4K;
CaracteristicasK(5).vent{t}  = op5K;
CaracteristicasK(6).vent{t}  = op6K;
CaracteristicasK(7).vent{t}  = op7K;

CaracteristicasD(1).vent{t}  = op1D;
CaracteristicasD(2).vent{t}  = op2D;
CaracteristicasD(3).vent{t}  = op3D;
CaracteristicasD(4).vent{t}  = op4D;
CaracteristicasD(5).vent{t}  = op5D;
CaracteristicasD(6).vent{t}  = op6D;
CaracteristicasD(7).vent{t}  = op7D;

clear op1S op2S op3S op4S op5S op6S op7S;
clear op1T op2T op3T op4T op5T op6T op7T;
clear op1K op2K op3K op4K op5K op6K op7K;
clear op1D op2D op3D op4D op5D op6D op7D;


end

save('Lymphoma_CaracteristicasS.mat', 'CaracteristicasS', 'etiquetas');
save('Lymphoma_CaracteristicasT.mat', 'CaracteristicasT', 'etiquetas');
save('Lymphoma_CaracteristicasK.mat', 'CaracteristicasK', 'etiquetas');
save('Lymphoma_CaracteristicasD.mat', 'CaracteristicasD', 'etiquetas');