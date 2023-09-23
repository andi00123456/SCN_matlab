% Demo Data regression of SCN
clear;
clc;
close all;
format long;
%%  Prepare the training (X, T) and test data (X2, T2) 
% X: each row vector represents one sample input.
% T: each row vector represents one sample target.
% same to the X2 and T2.
% Note: Data preprocessing (normalization) should be done before running the program.

load('Demo_Data.mat');

figure;
plot(X,T, 'r.-'); hold on;
plot(X2, T2, 'b.-');
legend('Training', ...
       'Test    ');     
   
%% Parameter Setting
L_max = 250;                    % maximum hidden node number
tol = 0.001;                    % training tolerance
T_max = 100;                    % maximun candidate nodes number
Lambdas = [0.5, 1, 5, 10, ...
    30, 50, 100, 150, 200, 250];% scope sequence
r =  [ 0.9, 0.99, 0.999, ...
    0.9999, 0.99999, 0.999999]; % 1-r contraction sequence
nB = 1;       % batch size

%% Model Initialization
M = SCN(L_max, T_max, tol, Lambdas, r , nB);
disp(M);

%% Model Training
% M is the trained model
% per contains the training error with respect to the increasing L
[M, per] = M.Regression(X, T);
disp(M);

%% Training error demo
figure;
plot(per.Error, 'r.-');
xlabel('L');
ylabel('RMSE');
legend('Training RMSE');

%% Model output vs target on training dataset
O1 = M.GetOutput(X);
figure;
plot(X,T, 'r.-'); hold on;
plot(X,O1, 'b.-');  
xlabel('X');
ylabel('Y');
legend('Training Target', 'Model Output');

%% Model output vs target on test dataset
O2 = M.GetOutput(X2);
figure;
plot(X2, T2, 'r.-'); hold on;
plot(X2, O2, 'b.-');  
xlabel('X');
ylabel('Y');
legend('Test Target', 'Model Output');

% The End 


