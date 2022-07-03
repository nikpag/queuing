function B_result = erlangb_factorial(rho, c)
  summation = 0;
  for k = 0:c
    summation = summation + rho^k/factorial(k);
  endfor
  
  B_result = rho^c/factorial(c)/summation;
endfunction
