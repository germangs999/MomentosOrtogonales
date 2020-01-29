%%
%
%

%%
function  features = getTchebiFeatures(patches)

[Y, X, NROWS] = size(patches);
features = zeros(NROWS, Y+X-1); % without mean

for index = 1:NROWS
    im = mat2gray(patches(:,:,index));
    im = im - mean(im(:));
    features(index, :) = getChebyshevGraph(im);
end
