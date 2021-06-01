function B_result = erlangb_iterative(rho, c)
  retval = 0;
  
  B = ones(1);
  
  for n = 1:c
    B(n+1) = ( rho .* B(n) ) / ( rho .* B(n) + n );
  endfor
  
  B_result = B(c+1);
  
  
endfunction
