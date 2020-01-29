clear; close all; clc;

Tiempo = zeros(3,100,1000);

%Shmaliy

for t=1:1000
    for N = 2:100
        tstart = tic;
        PoliShmaliy_N = generarPolyShmaliy_tiempo(N);
        Tiempo(1,N,t) = toc(tstart);
    end
end

%Krawt

for t = 1:1000
    for N = 2:100
        tstart = tic;
        PoliKraw = generarPolyKraw(N, 0.5);
        Tiempo(3,N,t) = toc(tstart);

    end
end

%Tchebi
for t=1:1000
    for N = 2:100
        tstart = tic;
        PoliTchebi = computePolyMatrix(N);
        Tiempo(2,N,t) = toc(tstart);

    end
end



%% Tiempo

TiempoPromedio = mean(Tiempo,3);
plot(1:100,TiempoPromedio)

save('Tiempo.mat', 'Tiempo', 'TiempoPromedio')