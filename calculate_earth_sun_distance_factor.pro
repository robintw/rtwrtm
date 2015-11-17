FUNCTION CALCULATE_EARTH_SUN_DISTANCE_FACTOR, day_of_year
  day_angle = 2 * !PI * ((day_of_year - 1)/365)
  
  result = 1.00011 + 0.034221 * cos(day_angle) + 0.00128 * sin(day_angle) + 0.000719 * cos(2 * day_angle) + 0.000077 * sin(2 * day_angle)
  
  return, result
END