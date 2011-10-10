FUNCTION PARAM_AEROSOL_AMOUNT, x_len, y_len
  top = randomn(seed, x_len, y_len - 1)
  help, top
  ; Make it into a normal dist with mean = 3.1 and SD = 4.4 (from Gregory, Anderson, Barrick - JGR 1994)
  top = top * 4.4
  top = top + 3.1
  print, mean(top), stddev(top)
  
  bottom = randomn(seed, x_len, 1)
  bottom = bottom * 88
  bottom = bottom + 161

  result = fix([ [top],[bottom] ])

  indices = WHERE(result LT 0, count)
  IF count GT 0 THEN BEGIN
    result[indices] = result[indices] * (-1)
  ENDIF
  
  return, result
END