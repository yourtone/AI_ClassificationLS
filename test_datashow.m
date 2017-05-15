clear; clc; clf; %close all;

%% load x, y
load('data.mat', 'n', 'x', 'y', 'y0', 'mu1', 'mu2', 'mu3');
r1 = x(1:n,:);
r2 = x(1+n:n*2,:);
r3 = x(1+n*2:n*3,:);

%% show data
figure(1);hold on;
plot(mu1(1),mu1(2),'rx');
plot(mu2(1),mu2(2),'gx');
plot(mu3(1),mu3(2),'bx');
plot(r1(:,1),r1(:,2),'r.');
plot(r2(:,1),r2(:,2),'g.');
plot(r3(:,1),r3(:,2),'b.');