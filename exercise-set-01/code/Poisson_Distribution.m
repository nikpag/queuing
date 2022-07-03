pkg load statistics

clc;
clear all;
close all;

nfig=0;
# Poisson Distribution A
# TASK: In a common diagram, design the Probability Mass Function of Poisson 
# processes with lambda parameters 3,10,50. In the horizontal axes, choose
# k parameters between 0 and 70.

k = 0:1:70;
lambda = [3,10,30,50];
index = find(lambda == 30);

for i=1:columns(lambda)
  poisson(i,:) = poisspdf(k,lambda(i));
endfor

colors = "rbkm";

nfig=nfig+1; figure(nfig); 
hold on;
for i=1:columns(lambda)
  if (i == index)
    continue
  endif
  stem(k,poisson(i,:),colors(i),"linewidth",1.2);
endfor
hold off;

title("Probability Mass Function of Poisson processes");
xlabel("k values");
ylabel("probability");
legend("lambda=3","lambda=10","lambda=50");
grid on;

#name = "../images/Poisson_Distribution_A.png";
#saveas(nfig,name);



# Poisson Distribution B
# TASK: regarding the poisson process with parameter lambda 30, compute its mean 
# value and variance

#fd = fopen("../images/Poisson_Distribution_B.txt","w");

chosen = poisson(index,:);  
mean_value = 0;
for i=0:(columns(poisson(index,:))-1)
  mean_value = mean_value + i.*poisson(index,i+1);
endfor

fprintf("mean value of Poisson with lambda 30 is %d\n", mean_value);


second_moment = 0;
for i=0:(columns(poisson(index,:))-1)
  second_moment = second_moment + i.*i.*poisson(index,i+1);
endfor

variance = second_moment - mean_value.^2;

fprintf("Variance of Poisson with lambda 30 is %d\n",variance);
# fclose(fd);
# Poisson Distribution C
# TASK: consider the convolution of the Poisson distribution with lambda 20 with 
# the Poisson distribution with lambda 30. 

first = find(lambda==10);
second = find(lambda==50);
poisson_first = poisson(first,:);
poisson_second = poisson(second,:);

composed = conv(poisson_first,poisson_second);
new_k = 0:1:(2*70);

nfig=nfig+1; figure(nfig);
hold on;
stem(k,poisson_first(:),colors(1),"linewidth",1.2);
stem(k,poisson_second(:),colors(2),"linewidth",1.2);
stem(new_k,composed,"mo","linewidth",2);
hold off;

title("Convolution of two Poisson processes");
xlabel("k values");
ylabel("Probability");
legend("lambda=10","lambda=50","new process");
grid on;

#name = "../images/Poisson_Distribution_C.png";
#saveas(nfig,name);

# Poisson Distribution D
# TASK: show that Poisson process is the limit of the binomial distribution.
k = 0:1:200;
# Define the desired Poisson Process
lambda = 30;
n = [30, 60, 90, 120, 150]; 
p = lambda./n;

nfig=nfig+1; figure(nfig);

hold on;
for i=1:3
  binomial = binopdf(k,n(i),p(i));
  stem(k,binomial,colors(i),'linewidth',1.2);
endfor
hold off;

title("Poisson process as the limit of the binomial process");
xlabel("k values");
ylabel("Probability");
grid on;

#name = "../images/Poisson_Distribution_D.png";
#saveas(nfig,name);