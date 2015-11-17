FUNCTION PARAM_AEROSOL_TYPE, x_len, y_len
  @constants
  array = bytarr(x_len, y_len)
  
  array[*] = aerosol_types.maritime
  
  return, array
END