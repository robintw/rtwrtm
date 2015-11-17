FUNCTION CHOOSE_RANDOMLY, array
  len = N_ELEMENTS(array)
  index = RANDOMU(seed, 1) * len
  
  return, array[index]
END