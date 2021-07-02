% This function reconstriucts from ref frame, motion vector and error
function [reconsImageInter]=MotionEstimationR(referenceFrame,motionVector,predictionErr,i,j,N)
    rows=i;cols=j;
    N2=2*N;
    
    x1 = motionVector(1); y1 = motionVector(2); 
    recons(1:N,1:N) = referenceFrame(rows+N+y1:rows+y1+N2-1,cols+N+x1:cols+x1+N2-1)+ predictionErr(1:N,1:N);
    
    reconsImageInter=uint8(recons);
end
