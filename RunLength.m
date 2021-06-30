function [outputRunLength] = RunLength(imZigZag, A, B, imX, imY)
size(imZigZag)
for a=1:imX/B
    for b=1:imY/A
        
        cnt=0;
        run=zeros(1,0);
        temp=imZigZag(a,b).block(1);
        j=1;
        blockSize=length(imZigZag(a,b).block);
        for i=1:blockSize
            if imZigZag(a,b).block(i)==temp
                cnt=cnt+1;
            else
                run.count(j)=cnt;
                run.temp(j)=temp;
                j=j+1;
                temp=imZigZag(a,b).block(i);
                cnt=1;
            end
            if i==blockSize
                run.count(j)=cnt;
                run.temp(j)=temp;
            end
        end 
        
        dimension=length(run.count);  
        maxVal=max(run.count); 
        codeLength=log2(maxVal)+1;
        codeLength=floor(codeLength);
        
        outputRunLength(a,b).code=zeros(1,0);
        for i=1:dimension
            outputRunLength(a,b).code=[outputRunLength(a,b).code,dec2bin(run.count(i),codeLength),run.temp(i)];
        end
    end
end