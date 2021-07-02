% This function reconstructs from I frames
function reconsImage=IntraPredictionR(im_recons,i,j,N)
rows=i+N; cols=j+N;
for k=1:2*N
    Top(k)=double(im_recons(rows-1,cols+k-1)); %TOP pixels above the block
    Left(k)=double(im_recons(rows+k-1,cols-1)); %LEFT pixels before the block
end
for i=1:N
    for j=1:N
        recons(i,j)=round(mean([Left(1:N) Top(1:N) 4]));  % Mean / DC
    end
end

reconsImage=uint8(recons);
end
