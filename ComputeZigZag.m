function [out_zigzag] = ComputeZigZag(out_dct, A, B, imX, imY, m, n)

% size(out_dct)
out_zigzag.block = zeros(A, B);
%========================================================%
for a=1:imX/B
    for b=1:imY/A
        %================================================%
        out_zigzag(a,b).block=zeros(1,0);
        som_frequency=2:(B+A);
        counter=1;
        %================================================%
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
                        if out_dct(a,b).block(Ix(p),Iy(p))<0
                            bin_eq=dec2bin(bitxor(2^n-1,abs(out_dct(a,b).block(Ix(p),Iy(p)))),n);
                        else
                            bin_eq=dec2bin(out_dct(a,b).block(Ix(p),Iy(p)),n);
                        end
                        out_zigzag(a,b).block=[out_zigzag(a,b).block,bin_eq(1:m)];
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
                        if out_dct(a,b).block(Ix(p),Iy(p))<0
                            bin_eq=dec2bin(bitxor(2^n-1, abs(out_dct(a,b).block(Ix(p),Iy(p))),n));
                        else
                            bin_eq=dec2bin(out_dct(a,b).block(Ix(p),Iy(p)),n);
                        end
                        out_zigzag(a,b).block=[out_zigzag(a,b).block,bin_eq(1:m)];
                    end
            end
        end
        %================================================%
    end
end
%========================================================%