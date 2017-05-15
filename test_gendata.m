clear; clc; clf; %close all;

%% mvnrnd
n = 15;
mu1 = [-2 3]; sigma1 = [1.5 0.6; 0.6 1.5]; n1 = n;
r1 = mvnrnd(mu1,sigma1,n1);
mu2 = [-0.2 -2]; sigma2 = [2 0.4; 0.4 1]; n2 = n;
r2 = mvnrnd(mu2,sigma2,n2);
mu3 = [3 0.4]; sigma3 = [1.5 -1; -1 1.5]; n3 = n;
r3 = mvnrnd(mu3,sigma3,n3);

%% save x, y
x = [r1; r2; r3];
y0 = ones(n,1);
y0 = [y0; y0*2; y0*3];
eyemtx= eye(3);
y = eyemtx(y0,:);
save('data.mat', 'n', 'x', 'y', 'y0', 'mu1', 'mu2', 'mu3');

%% show data
figure(1);hold on;
plot(mu1(1),mu1(2),'rx');
plot(mu2(1),mu2(2),'gx');
plot(mu3(1),mu3(2),'bx');
plot(r1(:,1),r1(:,2),'r.');
plot(r2(:,1),r2(:,2),'g.');
plot(r3(:,1),r3(:,2),'b.');

print(gcf, '-dpng', 'data.png');