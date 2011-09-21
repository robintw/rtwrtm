FUNCTION PARAM_AEROSOL_TYPE, x_len, y_len
  array = bytarr(x_len, y_len)
  
  ; Aerosol Types
  MARITIME = 0
  URBAN = 1
  CUMULUS_CONT_POLL = 2
  
  array[*] = MARITIME
END