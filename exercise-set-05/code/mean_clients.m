function [E1, E2, E3, E4, E5] = ...
                         mean_clients(lambda1, lambda2, mu1, mu2, mu3, mu4, mu5)
  
  [rho1, rho2, rho3, rho4, rho5, _] = ...
                         intensities(lambda1, lambda2, mu1, mu2, mu3, mu4, mu5);
                         
  E1 = rho1 ./ (1 - rho1);
  E2 = rho2 ./ (1 - rho2);
  E3 = rho3 ./ (1 - rho3);
  E4 = rho4 ./ (1 - rho4);
  E5 = rho5 ./ (1 - rho5);
endfunction