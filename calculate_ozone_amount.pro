FUNCTION CALCULATE_OZONE_AMOUNT, day_of_year, lat, longitude
  ; All equations below are taken from van Heuklon, T., 1979, Solar Energy vol. 22, pp 64-68

  ; At the moment the values are only correct for the Northern hemisphere

  IF day_of_year EQ -1 THEN RETURN, 235
  
  IF longitude GT 0 THEN I = 20 ELSE I = 0
  
  result = 235
  
  result += (150 + 40 * SIN(0.9856 * (day_of_year - 30)) + 20 * SIN(3.0 * (longitude + I))) * (SIN(1.28 * lat)^2)
  
  return, result
END