FUNCTION CALCULATE_AEROSOL_SCATTER, prev_ray_x, prev_ray_y, ray_x, ray_y
; Choose randomly from scattering directions
  rand = RANDOMU(seed, 1)
  rand = rand[0]
  
  ; Locations, starting from 0 degrees
  locations_x = [0, 1, 1, 1, 0, -1, -1, -1]
  locations_y = [-1, -1, 0, 1, 1, 1, 0, -1]
  
  locations_index_add = 0
  
  CASE 1 OF
    rand GE 0 AND rand LT 0.914: locations_index_add = 0
    rand GT 0.914 AND rand LT 0.957: locations_index_add = 1
    rand GT 0.957 AND rand LE 1.0: locations_index_add = 7
  ENDCASE
    
  diff_x = prev_ray_x - ray_x
  diff_y = prev_ray_y - ray_y
  
  
  current_index = WHERE(locations_x EQ diff_x AND locations_y EQ diff_y, count)
  
  IF count EQ 0 THEN BEGIN
    print, "Count EQ 0!"
  ENDIF
  
  new_index = (current_index + locations_index_add) MOD 8
    
  new_diff_x = locations_x[new_index]
  new_diff_y = locations_y[new_index]
    
  new_x = ray_x + new_diff_x
  new_y = ray_y + new_diff_y
  
  return, [new_x, new_y]
END