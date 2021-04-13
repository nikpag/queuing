pkg load statistics

clc;
clear all;
close all;

nfig=0;
# Exponential Distribution A

k = 0:0.00001:8;
means = [0.5,1,3];

for i = 1:3
  exp_pdf(i,:) = exppdf(k, means(i));
endfor

nfig=nfig+1; figure(nfig);
hold on;
for i = 1:3
  plot(k,exp_pdf(i,:),"linewidth",1.2);
endfor
hold off;

title("Probability Density Function of Exponential Distribution");
xlabel("k values");
ylabel("Probability");
legend("1/lambda = 0.5","1/lambda = 1","1/lambda = 3");
grid on;

name = "../images/Exponential_Distribution_A.png";
saveas(nfig,name);

# Exponential Distribution B

for i = 1:3
  exp_cdf(i,:) = expcdf(k, means(i));
endfor

nfig=nfig+1; figure(nfig);
hold on;
for i = 1:3
  plot(k,exp_cdf(i,:),"linewidth",1.2);
endfor
hold off;

title("Cumulative Distribution Function of Exponential Distribution");
xlabel("k values");
ylabel("Probability");
legend("1/lambda = 0.5","1/lambda = 1", "1/lambda = 3");
grid on;

name = "../images/Exponential_Distribution_B.png";
saveas(nfig,name);

# Exponential Distribution C

mean = 2.5; # mean=1/lambda

P_30000 = 1 - expcdf(k(30000), mean);
P_50000_20000 = (1 - expcdf(k(50000), mean))/(1 - expcdf(k(20000), mean));

fd = fopen("../images/Exponential_Distribution_C.txt","w");
fprintf(fd,"P(X > 50000 | X > 20000) with lambda 0.4 = %.5d\n", P_50000_20000);
fprintf(fd,"P(X > 30000) with lambda 0.4 = %.5d\n", P_30000);
fclose(fd);