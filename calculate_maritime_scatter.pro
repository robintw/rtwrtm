FUNCTION CALCULATE_MARITIME_SCATTER, prev_ray_x, prev_ray_y, ray_x, ray_y
  ; Choose randomly from scattering directions
  rand = RANDOMU(seed, 1)
  rand = rand[0]
  
  ; Locations, starting from 0 degrees
  locations_x = [0, 1, 1, 1, 0, -1, -1, -1]
  locations_y = [-1, -1, 0, 1, 1, 1, 0, -1]
  
  locations_index_add = 0
  
  ; Uses Maritime Polluted option from OPAC
CASE 1 OF
  rand GE 0 AND rand LT 0.725308842356: locations_index_add = 0
  rand GE 0.725308842356 AND rand LT 0.815284423413: locations_index_add = 1
  rand GE 0.815284423413 AND rand LT 0.829470108397: locations_index_add = 2
  rand GE 0.829470108397 AND rand LT 0.838623791922: locations_index_add = 3
  rand GE 0.838623791922 AND rand LT 0.859771057145: locations_index_add = 4
  rand GE 0.859771057145 AND rand LT 0.868924740669: locations_index_add = 5
  rand GE 0.868924740669 AND rand LT 0.883110425654: locations_index_add = 6
  rand GE 0.883110425654 AND rand LT 1.0: locations_index_add = 7
  ELSE: locations_index_add = 6
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