% system M/M/1/4

clc;
clear all;
close all;
pkg load queueing;

if !(exist("files","dir") == 7)
  mkdir "files";
endif

fd = fopen("files/3bi.txt","w");
fclose(fd);

nfig = 0;
lambdas = [5,5,5,5];
mus = [10,1,5,20];

for iteration = 1:4
  lambda = lambdas(iteration);
  mu = mus(iteration);
  states = [0, 1, 2, 3, 4]; % system with capacity 4 states
  % the initial state of the system. The system is initially empty.
  initial_state = [1, 0, 0, 0, 0];
  
  % define the birth and death rates between the states of the system.
  births_B = [lambda/1, lambda/2, lambda/3, lambda/4];
  deaths_D = [mu, mu, mu, mu];
  
  % (i) get the transition matrix of the birth-death process
  transition_matrix = ctmcbd(births_B, deaths_D);
  if iteration == 1
    diary "files/3bi.txt"
    transition_matrix
    diary off
  endif
  
  % get the ergodic probabilities of the system
  P = ctmc(transition_matrix);
  
  if iteration == 1
    % (ii) plot the ergodic probabilities (bar for bar chart)
    fd = fopen("files/3bii.txt","w");
    for i = 1:5
      fprintf(fd,"P[%d] = %d%%\n",i,100*P(i));
    endfor
    fclose(fd);
    
    nfig = nfig + 1;
    figure(nfig);
    bar(states, P, "r", 0.5);
    grid on;
    title("Ergodic state probabilities");
    xlabel("State (clients)");
    ylabel("Probability");
    
    saveas(nfig,"files/3bii.png");
  
    % (iii) 
    average_clients = 0*P(1)+1*P(2)+2*P(3)+3*P(4)+4*P(5);
    
    fd = fopen("files/3biii.txt","w");
    fprintf(fd, "Average number of clients = %d", average_clients);
    fclose(fd);
    
    % (iv)
    fd = fopen("files/3biv.txt","w");
    fprintf(fd, "P[blocking] = %d%%\n", 100*P(5));
    fclose(fd);
  endif
  
  % (v) transient probability of all states until convergence to ergodic probability. Convergence takes place P0 and P differ by 0.01

  index = 0;
  maxT = 0;
  
  for T = 0 : 0.01 : 50
    index = index + 1;
    maxT = T;
    P0 = ctmc(transition_matrix, T, initial_state);
    for i = 1:5
      Prob0(index,i) = P0(i);
    endfor
    if P0 - P < 0.01
      break;
    endif
  endfor
 
  T = 0 : 0.01 : maxT;
  nfig = nfig + 1;
  figure(nfig);
  for i = 1:5
    subplot(3,2,i);
    plot(T, Prob0(1:index,i), "r", "linewidth", 2);
    
    grid on;
    title(strcat("Probability of state",{' '},num2str(i-1)," with respect to time")); 
    xlabel("Time");
    ylabel("Probability");
  endfor
  if iteration == 1
    saveas(nfig,strcat("files/3bv.png"));
  else 
    saveas(nfig,strcat("files/3bvi_",num2str(iteration-1),".png"));
  endif
endfor