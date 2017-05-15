clear; clc; clf; %close all;
% AI04-Linear model for regression and classification.pdf P37

%% load x, y
load('data.mat', 'n', 'x', 'y', 'y0', 'mu1', 'mu2', 'mu3');
r1 = x(1:n,:);
r2 = x(1+n:n*2,:);
r3 = x(1+n*2:n*3,:);
l1 = y0(1:n,:);
l2 = y0(1+n:n*2,:);
l3 = y0(1+n*2:n*3,:);

%% compute decision boundary
% Class 1-vs-Class 2
X12 = [ones(n*2,1) [r1; r2]]; % each row is a data point
t0 = ([l1;l2]~=1)+1;
eyemtx = eye(2);
T = eyemtx(t0,:); % each row is a 1-of-K label
W12 = pinv(X12' * X12) * X12' * T; % PRML(4.16) each column is a w vector
% Class 1-vs-Class 3
X13 = [ones(n*2,1) [r1; r3]]; % each row is a data point
t0 = ([l1;l3]~=1)+1;
eyemtx = eye(2);
T = eyemtx(t0,:); % each row is a 1-of-K label
W13 = pinv(X13' * X13) * X13' * T; % PRML(4.16) each column is a w vector
% Class 2-vs-Class 3
X23 = [ones(n*2,1) [r2; r3]]; % each row is a data point
t0 = ([l2;l3]~=2)+1;
eyemtx = eye(2);
T = eyemtx(t0,:); % each row is a 1-of-K label
W23 = pinv(X23' * X23) * X23' * T; % PRML(4.16) each column is a w vector

lineN = 100;
% W(1,2)-W(1,1)) + (W(2,2)-W(2,1)) * b_x + (W(3,1)-W(3,2)) * b_y = 0
b_x12 = linspace(min(X12(:,2)), max(X12(:,2)), lineN);
b_y12 = ((W12(1, 2)-W12(1, 1)) + (W12(2, 2)-W12(2, 1)) * b_x12) / (W12(3, 1)-W12(3, 2));
b_x13 = linspace(min(X13(:,2)), max(X13(:,2)), lineN);
b_y13 = ((W13(1, 2)-W13(1, 1)) + (W13(2, 2)-W13(2, 1)) * b_x13) / (W13(3, 1)-W13(3, 2));
b_x23 = linspace(min(X23(:,2)), max(X23(:,2)), lineN);
b_y23 = ((W23(1, 2)-W23(1, 1)) + (W23(2, 2)-W23(2, 1)) * b_x23) / (W23(3, 1)-W23(3, 2));

%% show data
figure(1);hold on;
plot(mu1(1),mu1(2),'rx');
plot(mu2(1),mu2(2),'gx');
plot(mu3(1),mu3(2),'bx');
plot(r1(:,1),r1(:,2),'r.');
plot(r2(:,1),r2(:,2),'g.');
plot(r3(:,1),r3(:,2),'b.');
plot(b_x12, b_y12+0.02, 'r', 'LineWidth', 2); % decision boundary 1-2
plot(b_x12, b_y12-0.02, 'g', 'LineWidth', 2); % decision boundary 1-2
plot(b_x13, b_y13+0.03, 'r', 'LineWidth', 2); % decision boundary 1-3
plot(b_x13, b_y13-0.03, 'b', 'LineWidth', 2); % decision boundary 1-3
plot(b_x23, b_y23-0.03, 'g', 'LineWidth', 2); % decision boundary 2-3
plot(b_x23, b_y23+0.03, 'b', 'LineWidth', 2); % decision boundary 2-3
% plot(b_x12(1:floor(lineN/2)), b_y12(1:floor(lineN/2)), 'r', 'LineWidth', 2); % decision boundary 1-2
% plot(b_x12(floor(lineN/2):end), b_y12(floor(lineN/2):end), 'g', 'LineWidth', 2); % decision boundary 1-2
% plot(b_x13(1:floor(lineN/2)), b_y13(1:floor(lineN/2)), 'r', 'LineWidth', 2); % decision boundary 1-3
% plot(b_x13(floor(lineN/2):end), b_y13(floor(lineN/2):end), 'b', 'LineWidth', 2); % decision boundary 1-3
% plot(b_x23(1:floor(lineN/2)), b_y23(1:floor(lineN/2)), 'g', 'LineWidth', 2); % decision boundary 2-3
% plot(b_x23(floor(lineN/2):end), b_y23(floor(lineN/2):end), 'b', 'LineWidth', 2); % decision boundary 2-3
axis([min(x(:,1)) max(x(:,1)) min(x(:,2)) max(x(:,2))]);