% This function computes p-frames
% 
function [motionVector,predictionErr]=MotionEstimation(referenceFrame,curFrame,i,j,N)
rows=i+N-1;cols=j+N-1;
% intialize SAD
    SAD = 1.0e+10;
    for u = -N:N
        for v = -N:N
            sad = curFrame(rows+1:rows+N,cols+1:cols+N)-referenceFrame(rows+u+1:rows+u+N,cols+v+1:cols+v+N); %difference
            sad = sum(abs(sad(:)));
            if sad < SAD            %min SAD
                SAD=sad;
                %Motion Vectors are positions in block, in which SAD is minimum
                x= v; y = u; %Motion Vectors
            end
        end
    end
    motionVector=[x y];
    %p frame from Motion Vector
    pred_im(1:N,1:N)=referenceFrame(rows+y+1:rows+y+N,cols+x+1:cols+x+N);
    
    % Error frame
    predictionErr(1:N,1:N) = curFrame(rows:rows+N-1,cols:cols+N-1)-pred_im(1:N,1:N);
    
end

