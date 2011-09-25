FUNCTION CALCULATE_AEROSOL_SCATTER, prev_ray_x, prev_ray_y, ray_x, ray_y, type

  CASE type OF
    !AERO.maritime: res = CALCULATE_MARITIME_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y)
    !AERO.urban: res = CALCULATE_URBAN_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y)
    !AERO.cumulus_cont_poll: res = CALCULATE_CUMULUS_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y)
  ENDCASE
  
  return, res
    
END