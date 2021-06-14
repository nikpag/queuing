clc;
clear all;
close all;

lambda = 10*10^3;       % lambda = 10 Kpps
mps = 128*8;            % mean packet size = 128 bytes = 128 * 8 bits
C1 = 15*1024*1024;      % C1 = 15 Mbps
C2 = 12*1024*1024;      % C2 = 12 Mbps

% Conversion from bps to pps
C1 = C1 / mps;
C2 = C2 / mps;

mu1 = C1;
mu2 = C2;

a = 0.001:0.001:0.999;

lambda1 = a * lambda;
lambda2 = (1-a) * lambda;

rho1 = lambda1 / mu1; 
rho2 = lambda2 / mu2; 

% Calculate E(n)

E_n1 = rho1./(1-rho1);
E_n2 = rho2./(1-rho2);
E_n = E_n1 + E_n2; 

% E(T) = E(n) / gamma = E(n) / lambda

gamma = lambda;

E_T = E_n / gamma;

plot(a, E_T, "r", "linewidth", 2);

title("Average waiting time as a function of alpha");
xlabel("alpha");
ylabel("E(T) (sec)");
grid on;

saveas(1, "two_lines.png");

[minimum, argmin] = min(E_T);

a_min = a(argmin);

fd = fopen("two_lines.txt", "w");

fprintf(fd, "The minimum E(T) is equal to %d sec (%d usec), for alpha = %d\n", minimum, minimum*1e6, a_min);

fclose(fd);
