pkg load queueing;
clc;
clear all;
close all;

if !(exist("files","dir") == 7)
  mkdir "files";
endif

samples = 100;
threshold = 5;
small = 0.001;
mu_start = threshold+small;
lambda = linspace(5,5,samples);
mu = linspace(mu_start,10,samples);

[utilization, response, requests, throughput] = qsmm1(lambda, mu);

y = [utilization; response; requests; throughput];
titles = ["Utilization as a function of mu"; 
          "Average delay as a function of mu"; 
          "Average number of clients as a function of mu";
          "Throughput as a function of mu"];
xlab = ["mu"; "mu"; "mu"; "mu"];
ylab = ["Utilization"; 
        "Delay (min)"; 
        "Number of clients"; 
        "Throughput"];

for i=1:4
  figure(i);
  plot(mu,y(i,:),"linewidth",2,"r");
  grid on;
  title(titles(i,:));
  xlabel(xlab(i,:));
  ylabel(ylab(i,:));
  if i == 2
    ylim([0,10]);
  endif 
  if i == 3 
    ylim([0,50]);
  endif
  saveas(i,strcat("files/2b",num2str(i),".png"));
endfor