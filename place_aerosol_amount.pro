PRO PLACE_AEROSOL_AMOUNT, value_x, value_y, value, grid_aerosol_amount
  ; Simple parameterisation assuming cloud values range from 1 to 4 - makes aerosol amounts 100, 200, 300 or 400
  grid_aerosol_amount[value_x, value_y] = value * 100
END