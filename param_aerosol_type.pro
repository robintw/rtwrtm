FUNCTION PARAM_AEROSOL_TYPE, x_len, y_len
  array = bytarr(x_len, y_len)

  
  array[*] = !AERO.maritime
  
  return, array
END