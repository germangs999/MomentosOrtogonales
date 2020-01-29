    function [ShmaliyMomentosVentana] = ObtenerShmaliyVentana(ImMascara,tam)
    N=tam/2;
    I_segm2 = ImMascara;
    for n = 1:size(ImMascara,3)
            
            I = I_segm2(1:(floor(size(I_segm2,1)/N))*N, 1:(floor(size(I_segm2,2)/N))*N, n); %Reescalar aún más para que el mat2cell no falle
            block_0 = mat2cell(I, repmat(N, [1, floor(size(I,1)/N)]), repmat(N, [1, floor(size(I,2)/N)]));%Separando las imágenes
            
            %Bloques móviles 
    
                l = 1;
                for k = 2:size(block_0,1)
                for m = 2:size(block_0,2)
                        bloque = [block_0{k-1,m-1} block_0{k-1,m}; block_0{k,m-1} block_0{k,m}];
                        Shmaliy_vectores(l,:) = getShmaliyFeatures(double(bloque));
                        l = l+1;
                end
                end
                
             
               ShmaliyMomentosVentana = Shmaliy_vectores;
               %TchebiMomentosSinCeros = quitarceros(TchebiMomentosVentana, porcentaje); 
    end

end