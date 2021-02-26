function [ vec ] = FeatureExtractor( y , fs )

%mfcc
MFC=mfc(y,fs);

%root_mean_square
r=rms(y);

%zero_crossing_rate
e=length(y)-1;
count=0;
for i=1:e
    if((y(i)<0&&y(i+1)>0)||(y(i)>0&&y(i+1)<0))
        count=count+1;
    end
end
zcr=count/length(y);

%signal energy
E=sum(abs(y).^2);

%spectral_flux
ft=abs(fft(y));
sf=0;
N=(length(ft)-1);
for i=1:N
    temp=(ft(i+1)-ft(i))^2;
    sf=sf+temp;
end

%final_vector_generation
vec=r;
vec=[vec;zcr];
vec=[vec;E];
vec=[vec;sf];
vec=[vec;MFC];

end

