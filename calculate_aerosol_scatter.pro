FUNCTION CALCULATE_AEROSOL_SCATTER, prev_ray_x, prev_ray_y, ray_x, ray_y, type
  ; Aerosol Types
  MARITIME = 0
  URBAN = 1
  CUMULUS_CONT_POLL = 2
  
  CASE type OF
    MARITIME: res = CALCULATE_MARITIME_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y)
    URBAN: res = CALCULATE_URBAN_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y)
    CUMULUS_CONT_POLL: res = CALCULATE_CUMULUS_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y)
  ENDCASE
  
  return, res
    
END