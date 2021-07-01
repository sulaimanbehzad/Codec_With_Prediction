%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This Function intra_cons does the function of Intra Prediction on a block%
%If Block Size is 4x4, then there are 9 modes defined and if Block size is%
%either 8x8 or 16x16, then there are 4 modes defined by H.264 std. All the%
%modes are implemented seperately below, as  functions. Mode selection is %
%based on which mode results in smaller SAD (Sum of Absolute Difference). %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [intra_image]=IntraPrediction(im_new,i,j,N)
rows=i+N;cols=j+N;
  for k=1:2*N
        T(k)=im_new(rows-1,cols+k-1); %TOP pixels above the block
        L(k)=im_new(rows+k-1,cols-1); %LEFT pixels before the block
  end
  LT=im_new(rows-1,cols-1); 
  for i=1:N
      for j=1:N
          intra_image(i,j)=round(mean([L(1:N) T(1:N) 4]));  % Mean / DC
      end
  end
end
