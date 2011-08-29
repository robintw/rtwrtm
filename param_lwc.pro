PRO PARAM_LWC
  total_lwc = 1.6
  
  y_len = 20
  
  atmos_height = 20
  
  cells_per_km = DOUBLE(y_len) / 20
  
  lwc_top = 0.0625 * total_lwc
  lwc_middle = 0.1875 * total_lwc
  lwc_bottom = 0.75 * total_lwc
  
  lwc_top_per_cell = lwc_top / (cells_per_km * 3)
  lwc_middle_per_cell = lwc_middle / (cells_per_km * 3)
  lwc_bottom_per_cell = lwc_bottom / (cells_per_km * 3)
  
  array_lwc_bottom = replicate(lwc_bottom_per_cell, 3)
  array_lwc_middle = replicate(lwc_middle_per_cell, 3)
  array_lwc_top = replicate(lwc_top_per_cell, 3)
  array_above_lwc = replicate(0, 11)
  
  array = [array_lwc_bottom, array_lwc_middle, array_lwc_top, array_above_lwc]
  
  print, array
  print, TOTAL(array)
  
END