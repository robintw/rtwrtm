FUNCTION CALCULATE_STRAIGHT_PATH, prev_x, prev_y, curr_x, curr_y
  x_diff = prev_x - curr_x
  y_diff = prev_y - curr_y ; different to the line above because Y goes
                           ; down (opp to standard cartesian coords)
  
  new_x = curr_x + (-1 * x_diff)
  new_y = curr_y + (-1 * y_diff)
  
  return, [new_x, new_y]
END