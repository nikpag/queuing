clc;
clear all;
close all;

pkg load queueing;

i = 0;
factorial_result = zeros(1);
iterative_result = zeros(1);
correct_result = zeros(1); 

min_rho = 0.1;
max_rho = 1;
step_rho = 0.1;

min_c = 1;
max_c = 10;

failed = false;
accuracy = 0.001;

for rho = min_rho:max_rho:step_rho
  for c = min_c:max_c
    i = i + 1;
    factorial_result(i) = erlangb_factorial(rho, c);
    iterative_result(i) = erlangb_iterative(rho, c);
    correct_result(i) = erlangb(rho, c);
    
##    printf("Factorial = %d\nIterative = %d\nCorrect result = %d\n\n", 
##    factorial_result(i), iterative_result(i), correct_result(i));

    if (abs(factorial_result(i) - correct_result(i)) > 0.001 ||
        abs(iterative_result(i) - correct_result(i)) > 0.001)
        failed = true;
        break;
    endif
  endfor
  
  if failed
    break;
  endif
endfor


if failed
  printf("Wrong.\n");
else 
  printf("Correct.\n");
endif