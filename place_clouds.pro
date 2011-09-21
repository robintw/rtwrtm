PRO PLACE_CLOUDS, cloud_center_x, cloud_center_y, grid_aerosol_amount, grid_precip_water_content
  ; Get surrounding pixels (cardinal directions only)
  xs = [cloud_center_x + 1, cloud_center_x - 1,   cloud_center_x, cloud_center_x + 1, cloud_center_x - 1,   cloud_center_x]
  ys = [cloud_center_y,   cloud_center_y,     cloud_center_y,   cloud_center_y - 1, cloud_center_y - 1, cloud_center_y - 1]
  
  ; Get image size
  dim = SIZE(grid_aerosol_amount, /DIMENSIONS)
  
  ; Sort out xs and ys for boundary problems
  FOR i = 0, N_ELEMENTS(xs) - 1 DO BEGIN
    xs[i] = 0 > xs[i] < (dim[0]-1)
    ys[i] = 0 > ys[i] < (dim[1]-1)
  ENDFOR
  
  ; Put cloud in atmosphere  
  cloud_precip_water = 0.5
  cloud_aerosol_amount = 7
  
  FOR i = 0, N_ELEMENTS(xs) - 1 DO BEGIN
    grid_aerosol_amount[xs[i], ys[i]] = cloud_aerosol_amount
    grid_precip_water_content[xs[i], ys[i]] = cloud_precip_water
  ENDFOR
END