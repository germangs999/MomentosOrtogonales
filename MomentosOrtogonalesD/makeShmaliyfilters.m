% Crear los filtros de tamaño N de Tchebichef
function [S, indices] = makeShmaliyfilters(N)

[Tch, Tch1] = generarPolyShmaliy(N);
indices = [];

a = 1:N;
B = repmat(a,[N,1]);
C = B+B';

for k = 1:(N+1)
    [x,y] = find(C==k);
    indices = [indices; x, y];
end    

S = zeros(N,N,size(indices,1));
S1 = zeros(N,N,size(indices,1));

for i = 1:size(indices,1)
   
    S(:,:,i) = Tch(:,indices(i,1)) * (Tch(:,indices(i,2)))';
    S1(:,:,i) = Tch1(:,indices(i,1)) * (Tch1(:,indices(i,2)))';
    
end 

end