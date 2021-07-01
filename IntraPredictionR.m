%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This Function Intra_RECONS preforms the Intra ReConstruction,            %
% also known as Spatial Predictiion, in image "im_recons"'s current block,%
%(i,j) of size N. The function implements all modes. Which ever mode has    %
%earlier been selected,That mode's reconsrtuction is performed.           %
%The function returns the reconstructed block                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rim_intra=IntraPredictionR(im_recons,i,j,N)
rows=i;cols=j;
for k=1:2*N
    T(k)=double(im_recons(rows-1,cols+k-1)); %TOP pixels above the block
    L(k)=double(im_recons(rows+k-1,cols-1)); %LEFT pixels before the block
end
LT=im_recons(rows-1,cols-1); % Not used in Mode 1 & Mode 2
for i=1:N
    for j=1:N
        recons(i,j)=round(mean([L(1:N) T(1:N) 4]));  % Mean / DC
    end
end

rim_intra=uint8(recons);
end
