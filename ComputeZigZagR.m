function [out_zigzag_reverse] = ComputeZigZagR(out_run_length_reverse,A,B,imX,imY,m,n)
% in hmoon matrisi hast k dar dtc baraye normalize krdn estefade krdim 
normalization_matrix=[
    16 11 10 16 24 40 51 61
    12 12 14 19 26 58 60 55
    14 13 16 24 40 57 69 56
    14 17 22 29 51 87 80 62
    18 22 37 56 68 109 103 77
    24 35 55 64 81 104 113 92
    49 64 78 87 103 121 120 101
    72 92 95 98 112 100 103 99];

out_zigzag_reverse.block=zeros(B,A);
%=====================================================%
for a=1:imX/B
    for b=1:imY/A
        %=============================================%
        bpp=length(out_run_length_reverse(a,b).code)/(A*B);  
        bpp_diff=n-bpp; 
        som_frequency=2:(A+B);
        counter=1;
        Ic=1;
        %=============================================%
        for i=1:length(som_frequency)
            if i<=((length(som_frequency)+1)/2)
                if rem(i,2)~=0
                    Ix=counter:som_frequency(i)-counter;
                else
                    Ix=som_frequency(i)-counter:-1:counter;
                end
                    index_len=length(Ix);
                    Iy=Ix(index_len:-1:1); 
                    for p=1:index_len
                        decm_eq=bin2dec([out_run_length_reverse(a,b).code(1+m*(Ic-1):m*Ic),dec2bin(0,bpp_diff)]);
                        if decm_eq>(2^(n-1))-1
                            decm_eq=decm_eq-(2^n-1);
                        end
                        out_zigzag_reverse(a,b).block(Ix(p),Iy(p))=decm_eq;
                       Ic=Ic+1;
                    end
            else
                counter=counter+1;
                if rem(i,2)~=0
                    Ix=counter:som_frequency(i)-counter;
                else
                    Ix=som_frequency(i)-counter:-1:counter;
                end
                    index_len=length(Ix);
                    Iy=Ix(index_len:-1:1); 
                    for p=1:index_len
                        decm_eq=bin2dec([out_run_length_reverse(a,b).code(1+m*(Ic-1):m*Ic),dec2bin(0,bpp_diff)]);
                        if decm_eq>(2^(n-1))-1
                            decm_eq=decm_eq-(2^n-1);
                        end
                        out_zigzag_reverse(a,b).block(Ix(p),Iy(p))=decm_eq;
                        Ic=Ic+1;
                    end
            end
        end
        %=============================================%
    end
end
%=====================================================%
% dar in ja az hmaan matrsi bala dar jahat akse normalize estefade mikonim
for a=1:imX/B
    for b=1:imY/A
        out_zigzag_reverse(a,b).block=(out_zigzag_reverse(a,b).block).*normalization_matrix;
    end
end

