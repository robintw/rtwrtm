PRO PLACE_PWC, value_x, value_y, value, grid_pwc
  ; Assumes cloud is 5 cells high and additional water is approx 1cm
  grid_pwc[value_x, value_y] = 1.0 / 5.0
END