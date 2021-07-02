% This function computes I frames
% i and j indicate current macroblock
function [intra_image]=IntraPrediction(im_new,i,j,N)
rows=i+N;cols=j+N;
  for k=1:2*N
        Top(k)=im_new(rows-1,cols+k-1); %TOP pixels above the block
        Left(k)=im_new(rows+k-1,cols-1); %LEFT pixels before the block
  end
  for i=1:N
      for j=1:N
          intra_image(i,j)=round(mean([Left(1:N) Top(1:N) 4]));  % Mean / DC
      end
  end
end
