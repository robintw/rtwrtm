FUNCTION CALCULATE_RAYLEIGH_SCATTER, prev_ray_x, prev_ray_y, ray_x, ray_y
  ; Choose randomly from scattering directions
  rand = RANDOMU(seed, 1)
  
  ; Locations, starting from 0 degrees
  locations_x = [0, 1, 1, 1, 0, -1, -1, -1]
  locations_y = [-1, -1, 0, 1, 1, 1, 0, -1]
  
  locations_index_add = 0
  
  CASE 1 OF
    rand GE 0 AND rand LT 0.125: locations_index_add = 7
    rand GT 0.125 AND rand LT 0.2875: locations_index_add = 0
    rand GT 0.2875 AND rand LT 0.4125: locations_index_add = 1
    rand GT 0.4125 AND rand LT 0.49998: locations_index_add = 2
    rand GT 0.49998 AND rand LT 0.62498: locations_index_add = 3
    rand GT 0.62498 AND rand LT 0.78748: locations_index_add = 4
    rand GT 0.78748 AND rand LT 0.91248: locations_index_add = 5
    rand GT 0.91248 AND rand LE 1.0: locations_index_add = 6
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