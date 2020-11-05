clear all;
close all;
clc;

path = './';
two_images = {'adams01.jpg', 'door01.jpg'};
choose =1; %This line gives option to choose
image_file = strcat(path , char(two_images(choose )));
image_data = imread(image_file);
%Select 4 corners from the image
imshow(image_data);
fprintf('Select the corners in clockwise order please.\n');
[X Y] = ginput(4);

%width height and scale are given to keep the proportions of the distortion
%removed images same as the original image. These parameters are to be
%given manually

width=61.5*3 + 50.9;
height=91.5;
scale=4;

x=[1;width*scale;width*scale;1];
y=[1;1;height*scale;height*scale];


distortion_r=zeros(8,8);
distortion_r(1,:)=[X(1),Y(1),1,0,0,0,-1*X(1)*x(1),-1*Y(1)*x(1)];
distortion_r(2,:)=[0,0,0,X(1),Y(1),1,-1*X(1)*y(1),-1*Y(1)*y(1)];
distortion_r(3,:)=[X(2),Y(2),1,0,0,0,-1*X(2)*x(2),-1*Y(2)*x(2)];
distortion_r(4,:)=[0,0,0,X(2),Y(2),1,-1*X(2)*y(2),-1*Y(2)*y(2)];
distortion_r(5,:)=[X(3),Y(3),1,0,0,0,-1*X(3)*x(3),-1*Y(3)*x(3)];
distortion_r(6,:)=[0,0,0,X(3),Y(3),1,-1*X(3)*y(3),-1*Y(3)*y(3)];
distortion_r(7,:)=[X(4),Y(4),1,0,0,0,-1*X(4)*x(4),-1*Y(4)*x(4)];
distortion_r(8,:)=[0,0,0,X(4),Y(4),1,-1*X(4)*y(4),-1*Y(4)*y(4)];
v=[x(1);y(1);x(2);y(2);x(3);y(3);x(4);y(4)];
u=distortion_r\v;

%Reshape U 
U=reshape([u;1],3,3)';
w=U*[X';Y';ones(1,4)];
w=w./(ones(3,1)*w(3,:));

%projective
T=maketform('projective',U');

new_image=imtransform(image_data,T,'XData',[1 width*scale],'YData',[1 height*scale]);

figure,
imshow(new_image)