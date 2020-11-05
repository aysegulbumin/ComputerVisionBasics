clear all;
close all;
clc;

PictureA=imread('aysegul.jpeg');
PictureB=imread('sila.jpg');

PictureA=imresize(PictureA,[256,256]);
PictureB=imresize(PictureB,[256,256]);


%scale UP
dt = 0.5;
df = 1.0/(dt);

FigureA=fft2(PictureA)*dt;
FigureA_abs=abs(FigureA);
FP=atan2(imag(FigureA),real(FigureA));
FB=exp(j*FP);

FigureA_Magnitude=real(ifft2(FigureA_abs)*df);
FigureA_Phase=real(ifft2(FB)*df);

M=real(ifft2(FigureA_abs));
FigureA_Phase=real(ifft2(FB));

FigureA_Magnitude = repelem(FigureA_Magnitude,5,5);
FigureA_Phase = repelem(FigureA_Phase,5,5);

FigureA_Magnitude=im2uint8(mat2gray(FigureA_Magnitude));
FigureA_Phase=im2uint8(mat2gray(FigureA_Phase));

%PLOT the Picture A
figure,subplot(131),imshow(PictureA,[   ]);

subplot(132),imshow(FigureA_Magnitude, [0 25]);
stitle=sprintf('Magnitude Only');
title(stitle);

subplot(133),imshow(FigureA_Phase,[75  175]);
stitle=sprintf('Phase Only');
title(stitle);



% Friend's Picture B
FigureB=fft2(PictureB);
FigureB_abs=abs(FigureB);
GP=atan2(imag(FigureB),real(FigureB));
GB=exp(j*GP);
FigureB_Magnitude=real(ifft2(FigureB_abs));
FigureB_Phase=real(ifft2(GB));

GMmax=max(max(FigureB_Magnitude));
GMmin=min(min(FigureB_Magnitude));
%fprintf('GMmin, GMmax: %f %f \n',GMmin,GMmax);
%Scale UP
FigureB_Magnitude = repelem(FigureB_Magnitude,5,5);
FigureB_Phase = repelem(FigureB_Phase,5,5);

FigureB_Magnitude=im2uint8(mat2gray(FigureB_Magnitude));
FigureB_Phase=im2uint8(mat2gray(FigureB_Phase));

%PLOT Figure B
figure,subplot(131),imshow(PictureB,[   ]);

subplot(132),imshow(FigureB_Magnitude, [0 25]);
stitle=sprintf('Magnitude Only');
title(stitle);

subplot(133),imshow(FigureB_Phase,[75  175]);
stitle=sprintf('Phase Only');
title(stitle);


%PART B
%Reconstruct
F1=FigureA_abs.*GB;  
G1=FigureB_abs.*FB;  
g1=real(ifft2(G1));
mine1s=im2uint8(mat2gray(g1));


%figure,plot(imhist(mine1s));
f1=real(ifft2(F1));
friend1s=im2uint8(mat2gray(f1));
%figure,plot(imhist(friend1s));


figure,subplot(223),imshow(PictureB,[   ]); 
subplot(224),imshow(friend1s, [ ]);
stitle=sprintf('Magnitude Different, Phase Same');
title(stitle);
subplot(221),imshow(PictureA,[  ]);
subplot(222),imshow(mine1s,[ ]);
stitle=sprintf('Magnitude Different, Phase Same');
title(stitle);