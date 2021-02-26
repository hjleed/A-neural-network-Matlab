function [ MFC ] = mfc(y,fs)
 x=int64(length(y)/2);
 z=int64(length(y)/4);
 y1=y(z:z+x);
 fra=int64(0.025*fs);
 MFC1=zeros(12,1);
 MFC=zeros(12,1);
 u=1;
 H=zeros(20,551);
 f=zeros(22,1);
 c=zeros(22,1);
 f(1)=300;
 f(22)=8000;
 t1=1125*log(1+(300/700));
 t2=1125*log(1+(8000/700));
 c(1)=t1;
 c(22)=t2;
 t3=(t2-t1)/21; 
 for i=1:20
    t4=t1+t3;
    c(i+1)=t4;
    f(i+1)=700*(exp(t4/1125)-1);
    t1=t4;
 end
 f1 = linspace( 300, 8000, 551 );
 for m = 1:20     
    for k=1:551
        if(f1(k)>=f(m)&f1(k)<=f(m+1))
            H(m,k) = (f1(k)-f(m))/(f(m+1)-f(m));
        elseif(f1(k)>=f(m+1)&f1(k)<=f(m+2))
            H(m,k) = (f(m+2)-f1(k))/(f(m+2)-f(m+1));
        end
        
    end
 end 
 for l=1:600
    y2=y1(u:fra);
    hw=hamming(length(y2));
    for i=1:551
        y3(i)=y2(i)*hw(i);
    end    
    y4=fft(y3);
    for i=1:551
        y5(i)=(1/551)*(abs(y4(i)^2));
    end
    
 
    p1=H*(y5');
    p2=log(p1);
    p3=dct(p2);
    MFC1=[MFC1,p3(2:13,1)];
    u=u+551;
    fra=fra+551;
 end
 for i=1:12
     MFC(i,1)=mean(MFC1(i,:));
 end 
 

 