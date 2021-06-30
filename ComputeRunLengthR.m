function [out_run_length] = ComputeRunLengthR(out_run_length,A,B,imX, imY,n)

for a=1:imX/B
    for b=1:imY/A
        %========================================%
        enc_str=out_run_length(a,b).code;
        enc_len=length(enc_str);
        
        factors_mat=zeros(1,0);
        if enc_len<=(n+1)
            realfact=enc_len;
        else
            for i=2:enc_len-2      
                if(rem(enc_len,i)==0)
                    factors_mat=[factors_mat,i];
                end
            end
            
            for i=1:length(factors_mat)
                flagcntr=0;
                temp_dim=enc_len/factors_mat(i);
                for j=1:temp_dim
                    if strcmp(enc_str(1+(j-1)*factors_mat(i):j*factors_mat(i)),dec2bin(0,factors_mat(i)))==0
                        if j==1
                            flagcntr=flagcntr+1;
                        else
                            if enc_str((j-1)*factors_mat(i))~=enc_str(j*factors_mat(i))
                                flagcntr=flagcntr+1;
                            else
                                break;
                            end
                        end
                    else
                        break;
                    end
                end
                if flagcntr==temp_dim
                    realfact=factors_mat(i);
                    break;
                end
            end
        end
        
        dec_str=zeros(1,0);
        temp_dim=enc_len/realfact;
        for i=1:temp_dim
            count_str=enc_str(1+(i-1)*realfact:(i*realfact)-1);
            countval=bin2dec(count_str);
            for j=1:countval
                dec_str=[dec_str,enc_str(i*realfact)];
            end
        end
        out_run_length(a,b).code=dec_str;
        %========================================%
    end
end
%========================================%
