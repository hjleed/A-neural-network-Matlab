function class=NeuroNet(I,T)
no_of_in=16;
no_of_out=4;
no_of_hid=10;
learn_rate=0.1;
node_bias=zeros(1,30);
edge_wt =zeros(30,30);
out=zeros(1,30);
delta=zeros(1,30);

for i=1:30
    node_bias(i)=rand(1)+randi([-1,0]);
end
for i=1:30
    for j=1:30
        edge_wt(i,j)=rand(1)+randi([-1,0]);
    end
end

train1=I(:,1:300);
test1=I(:,301:400);
train2=T(:,1:300);
test2=T(:,301:400);

for epoch=1:1000
for i=1:300
    d27=0;
    d28=0;
    d29=0;
    d30=0;
    if(train2(:,i)==1)
        d27=1;
    elseif(train2(:,i)==2)
        d28=1;    
    elseif(train2(:,i)==3)
        d29=1;
    elseif(train2(:,i)==4)
        d30=1;
       
    end
    for u=1:16
        out(1,u)=1.0/(1.0+exp(-train1(u,i)));
    end
    xp=out;
    for j=17:26
        net=0;
        for k=1:16
            net=net+(out(1,k)*edge_wt(k,j));  
        end
        net=net+node_bias(1,j);
        %disp(net);
        out(1,j)=1.0/(1.0+exp(-net));
              
    end
    for j=27:30
        net=0;
        for k=17:26
            net=net+(out(1,k)*edge_wt(k,j)) ;
        end
        net=net+node_bias(1,j);
        out(1,j)=1.0/(1.0+exp(-net));
    end
    
    delta(1,27)=(d27-out(1,27))*out(1,27)*(1-out(1,27));
    delta(1,28)=(d28-out(1,28))*out(1,28)*(1-out(1,28));
    delta(1,29)=(d29-out(1,29))*out(1,29)*(1-out(1,29));
    delta(1,30)=(d30-out(1,30))*out(1,30)*(1-out(1,30));
    
    for j=27:30
        wet=0;
        bet=0;
        for k=17:26
            wet=learn_rate*delta(1,j)*out(1,k);
            edge_wt(k,j)=wet+edge_wt(k,j);             
        end
        bet=learn_rate*delta(1,j);
        node_bias(1,j)=node_bias(1,j)+bet;        
    end
    for j=17:26        
        det=0;
        for k=27:30
            det=det+(edge_wt(j,k)*delta(1,k));             
        end
        delta(1,j)=det*out(1,j)*(1-out(1,j));        
    end
    for j=17:26
        wet=0;
        bet=0;
        for k=1:16
            wet=learn_rate*delta(1,j)*out(1,k);
            edge_wt(k,j)=wet+edge_wt(k,j);             
        end
        bet=learn_rate*delta(1,j);
        node_bias(1,j)=node_bias(1,j)+bet;        
    end
    
end

end

class=zeros(1,100);
for i=1:100
for u=1:16
    out(1,u)=1.0/(1.0+exp(-test1(u,i)));
end

for j=17:26
    net=0;
    for k=1:16
        net=net+(out(1,k)*edge_wt(k,j));  
    end
    net=net+node_bias(1,j);
    out(1,j)=1.0/(1.0+exp(-net));

end
for j=27:30
    net=0;
    for k=17:26
        net=net+(out(1,k)*edge_wt(k,j)) ;
    end
    net=net+node_bias(1,j);
    out(1,j)=1.0/(1.0+exp(-net));
    
end 
p1=out(1,27);
p2=out(1,28);
p3=out(1,29);
p4=out(1,30);

if((p1>=p2)&&(p1>=p3)&&(p1>=p4))
    result=1;    
elseif((p2>=p1)&&(p2>=p3)&&(p2>=p4))
    result=2;
elseif((p3>=p2)&&(p3>=p1)&&(p3>=p4))
    result=3;    
elseif((p4>=p2)&&(p4>=p3)&&(p4>=p1))
    result=4;
end

class(1,i)=result;
end

end
