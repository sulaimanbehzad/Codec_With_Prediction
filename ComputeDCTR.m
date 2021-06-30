function [I_rec] = ComputeDCTR(im_transform_reverce,A,B,imX,imY)
% in function vazife mohasebe DCT ra bar ohde dard
for a=1:imX/B
    for b=1:imY/A
        %===============================================%
        for i=1:B
            for j=1:A
                %=======================================%
                prod=0;
                for k=1:B
                    for l=1:A
                        if k==1
                           temp=double(sqrt(1/2)*im_transform_reverce(a,b).block(k,l))*cos(pi*(k-1)*(2*i-1)/(2*B))*cos(pi*(l-1)*(2*j-1)/(2*A));
                        else
                            temp=double(im_transform_reverce(a,b).block(k,l))*cos(pi*(k-1)*(2*i-1)/(2*B))*cos(pi*(l-1)*(2*j-1)/(2*A));
                        end
                        if l==1
                            temp=temp*sqrt(1/2);
                        end
                        prod=prod+temp;
                    end
                end
                prod=prod*(2/sqrt(A*B));
                I_rec((a-1)*B+i,(b-1)*A+j)=prod;
                %=======================================%
            end
        end
        %===============================================%
    end
end

