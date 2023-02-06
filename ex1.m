%{
Digital Image Processing Exercises 2021-22
Author:Vasileios Terzoglou, AEM:9737
%}


clc
clear all
close all

%%
%part 1.1
I1 = imread('TestIm1.png');
figure('windowstate','maximized')
imshow(I1)
title("Original image","interpreter","latex");

theta1 = 35;
I2 = myImgRotation(I1,theta1);
figure('windowstate','maximized')
imshow(I2);
title("My image rotation using bilinear interpolation for $\theta_1$ = "+num2str(theta1)+"$^{\circ}$",'interpreter','latex');

theta2 = 222;
I3 = myImgRotation(I1,theta2);
figure('windowstate','maximized')
imshow(I3);
title("My image rotation using bilinear interpolation for $\theta_2$ = "+num2str(theta2)+"$^{\circ}$",'interpreter','latex');


%%
%part1.2
close all
I1c = I1;
I1 = I1(:,:,2);

p1 = 100;
p2 = 100;
P1 = [p1,p2];
N1 = size(I1,1);
N2 = size(I1,2);
[u1,u2] = fwd(P1,theta1,N1,N2);
U1 = [u1,u2];
d1 = myLocalDescriptor(I2,U1,5,20,1,8);
figure()
stem(d1)
title("My local descriptor for the pixel p = ["+num2str(p1)+","+num2str(p2)+"] after rotating by $\theta_1$ = "+num2str(theta1)+"$^{\circ}$",'interpreter','latex');
xlabel("Vector index","Interpreter","latex");

[u3,u4] = fwd(P1,theta2,N1,N2);
U2 = [u3,u4];
d2 = myLocalDescriptor(I3,U2,5,20,1,8);
figure()
stem(d2)
title("My local descriptor for the pixel p = ["+num2str(p1)+","+num2str(p2)+"] after rotating by $\theta_2$ = "+num2str(theta2)+"$^{\circ}$",'interpreter','latex');
xlabel("Vector index","Interpreter","latex");

q1 = [200,200];
q2 = [202,202];
d3 = myLocalDescriptor(I1,q1,5,20,1,8);
figure();
stem(d3)
title("My local descriptor for the pixel p = ["+num2str(q1(1))+","+num2str(q1(2))+"]",'interpreter','latex');
xlabel("Vector index","Interpreter","latex");

d4 = myLocalDescriptor(I1,q2,5,20,1,8);
figure();
stem(d4)
title("My local descriptor for the pixel p = ["+num2str(q2(1))+","+num2str(q2(2))+"]",'interpreter','latex');
xlabel("Vector index","Interpreter","latex");


d5 = myLocalDescriptorUpgrade(I2,U1,5,20,1,4);
figure()
stem(d5)
title("My \emph{upgraded} local descriptor for the pixel p = ["+num2str(p1)+","+num2str(p2)+"] after rotating by $\theta_1$ = "+num2str(theta1)+"$^{\circ}$",'interpreter','latex');
xlabel("Vector index","Interpreter","latex");

d6 = myLocalDescriptorUpgrade(I3,U2,5,20,1,4);
figure()
stem(d6)
title("My \emph{upgraded} local descriptor for the pixel p = ["+num2str(p1)+","+num2str(p2)+"] after rotating by $\theta_2$ = "+num2str(theta2)+"$^{\circ}$",'interpreter','latex');
xlabel("Vector index","Interpreter","latex");

d7 = myLocalDescriptorUpgrade(I1,q1,5,20,1,4);
figure();
stem(d7)
title("My \emph{upgraded} local descriptor for the pixel p = ["+num2str(q1(1))+","+num2str(q1(2))+"]",'interpreter','latex');
xlabel("Vector index","Interpreter","latex");


d8 = myLocalDescriptorUpgrade(I1,q2,5,20,1,4);
figure();
stem(d8)
title("My \emph{upgraded} local descriptor for the pixel p = ["+num2str(q2(1))+","+num2str(q2(2))+"]",'interpreter','latex');
xlabel("Vector index","Interpreter","latex");

%%
clearvars p* d* theta* u* U* q* P1;
clearvars I2 I3;
%part1.3
close all

mycorners1 = part_1_3(I1);

I2c = imread('TestIm2.png');
I2 = I2c(:,:,2);
mycorners2 = part_1_3(I2);


%%
%part2
close all

I1I2 = myStitch(I1c,I2c,mycorners1,mycorners2);
figure("windowstate","maximized");
imshow(I1I2);
title("Images im1, im2 stitched","interpreter","latex");

