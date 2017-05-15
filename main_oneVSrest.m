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
X = [ones(n*3,1) x]; % each row is a data point
% Class 1-vs-rest
t0 = (y0~=1)+1;
eyemtx = eye(2);
T = eyemtx(t0,:); % each row is a 1-of-K label
W1 = pinv(X' * X) * X' * T; % PRML(4.16) each column is a w vector
% Class 2-vs-rest
t0 = (y0~=2)+1;
eyemtx = eye(2);
T = eyemtx(t0,:); % each row is a 1-of-K label
W2 = pinv(X' * X) * X' * T; % PRML(4.16) each column is a w vector
% Class 1-vs-rest
t0 = (y0~=3)+1;
eyemtx = eye(2);
T = eyemtx(t0,:); % each row is a 1-of-K label
W3 = pinv(X' * X) * X' * T; % PRML(4.16) each column is a w vector

b_x = min(x(:,1)):0.1:max(x(:,1));
% W(1,2)-W(1,1)) + (W(2,2)-W(2,1)) * b_x + (W(3,1)-W(3,2)) * b_y = 0
b_y1 = ((W1(1, 2)-W1(1, 1)) + (W1(2, 2)-W1(2, 1)) * b_x) / (W1(3, 1)-W1(3, 2));
b_y2 = ((W2(1, 2)-W2(1, 1)) + (W2(2, 2)-W2(2, 1)) * b_x) / (W2(3, 1)-W2(3, 2));
b_y3 = ((W3(1, 2)-W3(1, 1)) + (W3(2, 2)-W3(2, 1)) * b_x) / (W3(3, 1)-W3(3, 2));

%% show data
figure(1);hold on;
plot(mu1(1),mu1(2),'rx');
plot(mu2(1),mu2(2),'gx');
plot(mu3(1),mu3(2),'bx');
plot(r1(:,1),r1(:,2),'r.');
plot(r2(:,1),r2(:,2),'g.');
plot(r3(:,1),r3(:,2),'b.');
plot(b_x, b_y1, 'r', 'LineWidth', 2); % decision boundary 1
plot(b_x, b_y2, 'g', 'LineWidth', 2); % decision boundary 2
plot(b_x, b_y3, 'b', 'LineWidth', 2); % decision boundary 3
axis([min(x(:,1)) max(x(:,1)) min(x(:,2)) max(x(:,2))]);
% legend('Class 1 (red)', 'Class 2 (green)', 'Class 3 (blue)', ...
%     'Class center 1', 'Class center 2', 'Class center 3', ...
%     'Decision boundary 1-vs-rest', 'Decision boundary 2-vs-rest', 'Decision boundary 3-vs-rest', ...
%     'Location', 'NE');