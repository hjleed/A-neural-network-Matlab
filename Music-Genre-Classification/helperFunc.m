function [ X ] = helperFunc (t)
N=length(t);
X=zeros(1,400);
for i=1:N
    if(t(1,i)==1)
        X(1,i)=1;
    
    elseif(t(2,i)==1)
        X(1,i)=2;
 
    elseif(t(3,i)==1)
        X(1,i)=3;
  
    elseif(t(4,i)==1)
        X(1,i)=4;      

    end
end    