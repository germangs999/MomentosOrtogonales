function moment = getChebyshevGraph(im, T)

if nargin < 2
    T = computeChebMomentMukundan(im);
end

% T = T.*T;

[num_rows, num_cols] = size(T);
T_mirror = computeMirrorImage(T); % Es igual hacer fliplr(T)
num_diags = (num_rows + num_cols - 1);
for k=-(num_diags-1)/2:1:(num_diags-1)/2
    aux2(1,k + ((num_diags-1)/2) + 1) = sum(abs(diag(T_mirror,k)));
end
moment = computeMirrorImage(aux2);
% Elimina la componente continua
moment = moment(1:length(moment));
clear aux2;