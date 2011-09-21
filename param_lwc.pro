FUNCTION PARAM_LWC, x_len, y_len, total_lwc  
  beta = -0.6
  alpha = total_lwc / ( (1 - EXP(beta * y_len)) / (1 - EXP(beta)))
  
  array = indgen(y_len)
  
  array = alpha * EXP(beta * array)
  
  print, total(array)
  ;print, array
  
  return, repmat(transpose(reverse(array)), x_len, 1)
  
END