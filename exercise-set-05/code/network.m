clc;
clear all;
close all;

if !(exist("images","dir") == 7)
  mkdir "images";
endif

lambda1 = 4;
lambda2 = 1;
mu1 = 6;
mu2 = 5;
mu3 = 8;
mu4 = 7;
mu5 = 6;

[rho1, rho2, rho3, rho4, rho5, _] = ...
                        intensities(lambda1, lambda2, mu1, mu2, mu3, mu4, mu5);
                        
[E1, E2, E3, E4, E5] = mean_clients(lambda1, lambda2, mu1, mu2, mu3, mu4, mu5);

E_T_end_to_end = (E1 + E2 + E3 + E4 + E5) / (lambda1 + lambda2);

fd = fopen("images/network1.txt", "w");

fprintf(fd, "rho1 = %d\nrho2 = %d\nrho3 = %d\nrho4 = %d\nrho5 = %d\n\n",
        rho1, rho2, rho3, rho4, rho5);
        
fprintf(fd, "Average waiting time (end to end) = %d sec\n", E_T_end_to_end);

fclose(fd);

[_, argmax] = max([rho1, rho2, rho3, rho4, rho5]);

bottleneck = argmax;

fd = fopen("images/network2.txt", "w");
fprintf(fd, "The bottleneck is Q%d\n", bottleneck);
fclose(fd);

% ...
% We solve by hand in order to find the maximum value of lambda1,
% such that the system remains ergodic. It turns out that max_lambda1 = 6
% ...

max_lambda1 = 6;
number_of_points = 100;

lambda1 = linspace(0.1*max_lambda1, 0.99*max_lambda1, number_of_points);

[rho1, rho2, rho3, rho4, rho5, _] = ...
                        intensities(lambda1, lambda2, mu1, mu2, mu3, mu4, mu5);

[E1, E2, E3, E4, E5] = mean_clients(lambda1, lambda2, mu1, mu2, mu3, mu4, mu5);

E_T_end_to_end = (E1 + E2 + E3 + E4 + E5) ./ (lambda1 + lambda2);

plot(lambda1, E_T_end_to_end, "r", "linewidth", 2);
grid on;
title("Average waiting time (end to end) as a function of lambda1");
xlabel("lambda1 (customers/sec)");
ylabel("E(T) (sec)");

saveas(1, "images/network.png");