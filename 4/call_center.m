clc;
clear all;
close all;

rho_for_one = 23/60;
total_rho = 200 * rho_for_one;

Pblocking = zeros(1);

found_min_servers_needed = false;

for c = 1:200
  Pblocking(c) = erlangb_iterative(total_rho, c); 
  if Pblocking(c) < 0.01 && !found_min_servers_needed
    min_servers_needed = c;
    found_min_servers_needed = true;
  endif
endfor

line = linspace(0.01, 0.01, 200);

hold on;

plot(Pblocking,"r", "linewidth", 2);
grid on;
xlabel("Number of servers");
ylabel("Probability");
title("P[blocking] as a function of servers");
xticks(0:20:200);
yticks(0:0.1:1);

saveas(1,"call_center.png");

printf("Minimum number of servers needed = %d\n", min_servers_needed);
printf("%d servers give P[blocking] = %d\n", min_servers_needed, Pblocking(min_servers_needed));


