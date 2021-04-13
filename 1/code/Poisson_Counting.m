pkg load statistics

clc;
clear all;
close all;

nfig = 0;
# Poisson Counting A
sample_sizes = [100,200,300,500,1000,10000,100000,1000000];

fd = fopen("../images/Poisson_Counting_B.txt","w");

for j = 1:length(sample_sizes) 
  lambda = 5;
  mean = 1/lambda;
  sample_size = sample_sizes(j);
  
  rnd_events = exprnd(mean,1,sample_size);
  t = zeros(1,sample_size+1);
  
  for i = 1:sample_size
    t(i+1) = t(i) + rnd_events(i);
  endfor
  
  N = 0:1:sample_size;
  
  
  if sample_size == 100
    nfig=nfig+1; figure(nfig);  
    stairs(t,N,"linewidth",1.2);
    title("Poisson Counting Process");
    xlabel("t (s)");
    ylabel("N (t)");
    grid on;
    
    saveas(nfig,"../images/Poisson_Counting_A.png");
  endif
  
  # Poisson Counting B
  
  average = sample_size/t(end);
  
  fprintf(fd,"Average for %d events: %d\n", sample_size, average);

endfor

fclose(fd);


