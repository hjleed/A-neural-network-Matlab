 f1 = dir(fullfile('data\genres\pop', '*.au'));
 f2 = dir(fullfile('data\genres\jazz', '*.au'));
 f3 = dir(fullfile('data\genres\classical', '*.au'));
 f4 = dir(fullfile('data\genres\metal', '*.au'));
 
 [y,fs]= auread('data\genres\pop\pop.00000.au');
 mf=FeatureExtractor(y,fs);
 x=mf;
 t=[1;0;0;0];
 [y,fs]= auread('data\genres\jazz\jazz.00000.au');
 r=FeatureExtractor(y,fs);
 x=[x,r];
 t3=[0;1;0;0];
 t=[t,t3];
 [y,fs]= auread('data\genres\classical\classical.00000.au');
 r=FeatureExtractor(y,fs);
 x=[x,r];
 t3=[0;0;1;0];
 t=[t,t3];
 [y,fs]= auread('data\genres\metal\metal.00000.au');
 r=FeatureExtractor(y,fs);
 x=[x,r];
 t3=[0;0;0;1];
 t=[t,t3];
 
for i=2:100
     str1 = strcat('data\genres\pop\', f1(i).name);     
     [y1,fs1]=auread(str1);
     str2 = strcat('data\genres\jazz\', f2(i).name);
     [y2,fs2]=auread(str2);
     str3 = strcat('data\genres\classical\', f3(i).name);     
     [y3,fs3]=auread(str3);
     str4 = strcat('data\genres\metal\', f4(i).name);
     [y4,fs4]=auread(str4);    
     
     
     r1=FeatureExtractor(y1,fs1);
     r2=FeatureExtractor(y2,fs2);
     r3=FeatureExtractor(y3,fs3);
     r4=FeatureExtractor(y4,fs4);
     
     x=[x,r1]
     t1=[1;0;0;0];
     t=[t,t1];
     x=[x,r2];
     t2=[0;1;0;0];
     t=[t,t2];
     x=[x,r3]
     t3=[0;0;1;0];
     t=[t,t3];
     x=[x,r4];
     t4=[0;0;0;1];
     t=[t,t4];
 end

net = patternnet(20);
[net,tr] = train(net,x,t);

T = helperFunc(t);
class = NeuroNet(x,T);
c = confusionmat(T(:,301:400),class);
