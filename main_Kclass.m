clear; clc; clf; %close all;
% AI04-Linear model for regression and classification.pdf P38

%% load x, y
load('data.mat', 'n', 'x', 'y', 'y0', 'mu1', 'mu2', 'mu3');
r1 = x(1:n,:);
r2 = x(1+n:n*2,:);
r3 = x(1+n*2:n*3,:);
l1 = y0(1:n,:);
l2 = y0(1+n:n*2,:);
l3 = y0(1+n*2:n*3,:);

%% compute decision boundary
X = [ones(n*3,1) x]; % each row is a data point
T = y; % each row is a 1-of-K label
W = pinv(X' * X) * X' * T; % PRML(4.16) each column is a w vector

lineN = 100;
% W(1,2)-W(1,1)) + (W(2,2)-W(2,1)) * b_x + (W(3,1)-W(3,2)) * b_y = 0
b_x = (W(1,1)*W(3,2)+W(3,1)*W(1,3)+W(1,2)*W(3,3)-W(1,1)*W(3,3)-W(3,1)*W(1,2)-W(3,2)*W(1,3)) ...
    / (W(2,1)*W(3,3)+W(3,1)*W(2,2)+W(3,2)*W(2,3)-W(2,1)*W(3,2)-W(3,1)*W(2,3)-W(2,2)*W(3,3));
b_y = ((W(1,2)-W(1,1)) + (W(2,2)-W(2,1)) * b_x) / (W(3,1)-W(3,2));
b_x12 = min(X(:,2)):0.1:b_x;
b_y12 = ((W(1, 2)-W(1, 1)) + (W(2, 2)-W(2, 1)) * b_x12) / (W(3, 1)-W(3, 2));
b_x13 = b_x:0.1:max(X(:,2));
b_y13 = ((W(1, 3)-W(1, 1)) + (W(2, 3)-W(2, 1)) * b_x13) / (W(3, 1)-W(3, 3));
b_x23 = b_x:0.1:max(X(:,2));
b_y23 = ((W(1, 3)-W(1, 2)) + (W(2, 3)-W(2, 2)) * b_x23) / (W(3, 2)-W(3, 3));

%% show data
figure(1);hold on;
plot(mu1(1),mu1(2),'rx');
plot(mu2(1),mu2(2),'gx');
plot(mu3(1),mu3(2),'bx');
plot(r1(:,1),r1(:,2),'r.');
plot(r2(:,1),r2(:,2),'g.');
plot(r3(:,1),r3(:,2),'b.');
plot(b_x12, b_y12, 'y', 'LineWidth', 2); % decision boundary 1-2
plot(b_x13, b_y13, 'm', 'LineWidth', 2); % decision boundary 1-3
plot(b_x23, b_y23, 'c', 'LineWidth', 2); % decision boundary 2-3
plot(b_x, b_y, 'k+', 'LineWidth', 3); % decision boundary center
axis([min(x(:,1)) max(x(:,1)) min(x(:,2)) max(x(:,2))]);