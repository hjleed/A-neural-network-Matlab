

clear; 

File='Features.grt';

fid = fopen(File);
tline = fgetl(fid);
check=0;
while (check ==0)
% while ischar(tline)
    
    tline = fgetl(fid);
    if(strfind(tline, 'NumDimensions:'));
        t = textscan(tline, '%s %d');
        Dim=t{2};
        disp(Dim);
    end
    if(strfind(tline,'TotalNumExamples:'))
         t = textscan(tline, '%s %d');
         Nsam=t{2};
         disp(Nsam);
    end
    
    if(strfind(tline,'NumberOfClasses:'))
         t = textscan(tline, '%s %d');
         Nclss=t{2};
         disp(Nclss);
    end
    if(strfind(tline, 'Data:'));  check=1; end
% end
end

lbls=zeros(Nclss,Nsam);
feat=zeros(Dim,Nsam);
FormatString = ['%d' repmat('%f',1,Dim)];  

for k=1:Nsam
    tline = fgetl(fid);
    InputText = textscan(tline,FormatString);
    lbls(InputText{1},k)=1;
    for ld=1:Dim
        feat(ld,k)=InputText{ld+1};
    end
    
end
fclose(fid);

net = patternnet(20);
[net,tr] = train(net,feat,lbls);


