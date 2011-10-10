FUNCTION AEROSOL_AMOUNT_PROBABILITIES
  amounts = [600, 500, 400, 300, 250, 200, 10, 1]
  probs = [1.0, 0.98, 0.96, 0.95, 0.9, 0.85, 0.3, 0.1]
  
  all_amounts = indgen(600)
  
  all_probs = INTERPOL(probs, amounts, all_amounts)
  
  return, all_probs
END