function [I_Trsfrm] = ComputeDCT(img, A, B, imX, imY)
% This function computes the DCT coefficients
I_Trsfrm.block = zeros(A,B);
normalization_matrix=[
    16 11 10 16 24 40 51 61
    12 12 14 19 26 58 60 55
    14 13 16 24 40 57 69 56
    14 17 22 29 51 87 80 62
    18 22 37 56 68 109 103 77
    24 35 55 64 81 104 113 92
    49 64 78 87 103 121 120 101
    72 92 95 98 112 100 103 99];
for a=1:imX/B
    for b=1:imY/A
        for k=1:B
            for l=1:A
                prod=0;
                for i=1:B
                    for j=1:A
                        prod=prod+double(img(B*(a-1)+i,A*(b-1)+j))*cos(pi*(k-1)*(2*i-1)/(2*B))*cos(pi*(l-1)*(2*j-1)/(2*A));
                    end
                end
                
                 if l==1
                    prod=prod*sqrt(1/A);
                else
                    prod=prod*sqrt(2/A);
                end
                
                if k==1
                    prod=prod*sqrt(1/B);
                    else
                    prod=prod*sqrt(2/B);
                end
                
               
                
                I_Trsfrm(a,b).block(k,l)=prod;
            end
        end
        
        I_Trsfrm(a,b).block=round(I_Trsfrm(a,b).block./normalization_matrix);
    end
end
