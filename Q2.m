clear all;
close all;
clc;
P = [5 400 500 20; 100 300 490 20; 1 1 1 5];
A = P(:,1:3);

C = null(P);
C = C/C(4);Ct = C(1:3);

upperleft = [5 400 500; 100 300 490; 1 1 1];
[R K]= qr(upperleft);




% normalize
%R = R/R(3,3);
%K = K/K(3,3);

R=abs(R)
K=abs(K)


img = imread('SeminarSelfie.jpg');
img = img(:,:, 1); 

imwrite(uint8(img),'SeminarSelfieGray.jpg');


[height, width, channel] = size(img);

imgout = zeros(height, width, channel);

%K = R;
f = 120;
for i = 1:height
	for j = 1:width
	        X_cam = [width/2-j height/2-i  2*f 1]';
	        x_img = K*[eye(3,3) zeros(3,1)]*X_cam;
	        curj = max(1,min(width,round(x_img(1)/x_img(3))));
	        curi = max(1,min(height,round(x_img(2)/x_img(3)))); 
		%[curi curj]        
		imgout(curi,curj,:) = img(i,j,:);        
	end
end


imgout = flipdim(imgout,1);

imgout = flipdim(imgout,2);



imwrite(uint8(imgout),'Result.jpg');
%imshow(uint8(imgout));
%hold on;

% plot the origin of sensor plane

%plot(width,height,'bo','linewidth',3);

% plot the intersection of principle axis and sensor plane

%plot(width-round(K(1,3)),height-round(K(2,3)),'ro','linewidth',3);

en_img2 = medfilt2(imgout);
imwrite(uint8(en_img2),'Filtered.jpg');
imshow(uint8(en_img2));
hold on;

plot(width,height,'bo','linewidth',3);

% plot the intersection of principle axis and sensor plane

plot(width-round(K(1,3)),height-round(K(2,3)),'ro','linewidth',3);

%imshow(uint8(en_img2));
%hold on;


imgout=single(imgout);
Vq = interp2(imgout,'linear');
figure
imshow(uint8(Vq));
title('Linear Interpolation');
imwrite(uint8(Vq),'LinearInterpolated.jpg');
