% M/M/1/10 simulation. We will find the probabilities of the first states.
% Note: Due to ergodicity, every state has a probability >0.
pkg load queueing;
clc;
clear all;
close all;
nfig = 0;

if !(exist("images","dir") == 7)
  mkdir "images";
endif

lambdas = [1,5,10];

capacity = 10;
accuracy = 0.00001;
total_transitions = 1000000;


for iteration = 1:3
  rand("seed",1);
  fd = fopen(strcat("images/trace",num2str(iteration),".txt"),"w");
  arrivals = zeros(1,capacity+1);
  P = zeros(1,capacity+1);
  to_plot = 0;
  to_plot_mean_time = 0;
  total_arrivals = 0; % to measure the total number of arrivals
  current_state = 0;  % holds the current state of the system
  previous_mean_clients = 0; % will help in the convergence test
  index = 0;
  
  lambda = lambdas(iteration); 
  mu = 5;
  threshold = lambda/(lambda + mu); % the threshold used to calculate probabilities
  
  transitions = 0; % holds the transitions of the simulation in transitions steps
  
  while transitions >= 0
    transitions = transitions + 1; % one more transitions step
    
    if mod(transitions,1000) == 0 % check for convergence every 1000 transitions steps
      index = index + 1;
      for i=1:1:length(arrivals)
          P(i) = arrivals(i)/total_arrivals; % calculate the probability of every state in the system
      endfor
      
      mean_clients = 0; % calculate the mean number of clients in the system
      for i=1:1:length(arrivals)
         mean_clients = mean_clients + (i-1).*P(i);
      endfor
      
      to_plot(index) = mean_clients;
      to_plot_mean_time(index) = mean_clients/(lambda*(1-P(capacity+1)));
      
      if abs(mean_clients - previous_mean_clients) < accuracy || transitions > total_transitions % convergence test
        break;
      endif
      
      previous_mean_clients = mean_clients;
      
    endif
    
    random_number = rand(1); % generate a random number (Uniform distribution)
    if current_state == 0 || random_number < threshold % arrival
      if current_state <= capacity % not full system
        total_arrivals = total_arrivals + 1;
        if transitions <= 30
          fprintf(fd, "%02d. State %2d | Arrival   | %d Arrivals\n", transitions, current_state, arrivals(current_state+1));
        endif
        arrivals(current_state + 1) = arrivals(current_state + 1) + 1; 
        if current_state < capacity
          current_state = current_state + 1;
        endif
      endif
    else % departure
      if current_state != 0 % no departure from an empty system
        if transitions <= 30
          fprintf(fd, "%02d. State %2d | Departure | %d Arrivals\n", transitions, current_state, arrivals(current_state+1));
        endif 
        current_state = current_state - 1; 
      endif
    endif
  endwhile

  fclose(fd);
  
  fd = fopen(strcat("images/prob",num2str(iteration),".txt"),"w");
  for i=1:1:length(arrivals)
    fprintf(fd,"P(%d) = %f%%\n",i-1,100*P(i));
  endfor
  fclose(fd);
  
  fd = fopen(strcat("images/pblocking",num2str(iteration),".txt"),"w");
  fprintf(fd,"P[blocking] = P[%d] = %f%%",capacity,100*P(capacity));
  fclose(fd);
  
  nfig=nfig+1; figure(nfig);
  x = 0:10;
  bar(x,P,'r',0.4);
  grid on;
  title(strcat("Ergodic probabilities, lambda = ",{" "},num2str(lambda)));
  xlabel("State");
  ylabel("Probability");
  saveas(nfig,strcat("images/prob",num2str(iteration),".png"));
  
  [dummy,response_time,average_requests] = qsmmmk(lambda,mu,1,10);
  
  nfig=nfig+1; figure(nfig);
  hold on;
  line([0,transitions/1000],[average_requests,average_requests],"color","black","linewidth",2);
  plot(to_plot,"r","linewidth",1.3);
  hold off;
  grid on;
  title(strcat("Average number of clients in the M/M/1/10 queue, lambda = ",{" "},num2str(lambda)));
##  if iteration == 2
##    ylim([3.4,7]);
##  endif
  xlabel("transitions in thousands");
  ylabel("Average number of clients");
  saveas(nfig,strcat("images/clients",num2str(iteration),".png"));
  
  nfig=nfig+1; figure(nfig);
  hold on;
  line([0,transitions/1000],[response_time,response_time],"color","black","linewidth",2);
  plot(to_plot_mean_time,"r","linewidth",1.3);
  hold off;
  grid on;
  title(strcat("Average waiting time in the M/M/1/10 queue, lambda = ",{" "},num2str(lambda)));
##  if iteration == 2
##    ylim([0.5,1.7]);  
##  endif
  xlabel("transitions in thousands");
  ylabel("Average waiting time (min)");
  saveas(nfig,strcat("images/time",num2str(iteration),".png"));
endfor