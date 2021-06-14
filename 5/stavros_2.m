clc; 
clear all;
close all;

lambda1 = 4;
lambda2 = 1;
mu1 = 6;
mu2 = 5;
mu3 = 8;
mu4 = 7;
mu5 = 6;

rhos = zeros(1,5);
[rhos(1) rhos(2) rhos(3) rhos(4) rhos(5)] = intensities(lambda1, lambda2, mu1, mu2, mu3, mu4, mu5);
clients = mean_clients(lambda1, lambda2, mu1, mu2, mu3, mu4, mu5);
total_waiting_time = sum(clients) / (lambda1 + lambda2);

disp("The intensity for each queue are(rho1, rho2, rho3, rho4, rho5)");
display(rhos);
disp(cstrcat("The average waiting time for a client in the system is ", num2str(total_waiting_time)));