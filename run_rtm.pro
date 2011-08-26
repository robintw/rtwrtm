PRO RUN_RTM
  start_time = SYSTIME(1)

  ; Set day of year
  day_of_year = 78
  
  ; Set solar zenith angle
  solar_zenith_angle = 5
  
  ; Set location
  lat = 50
  long = 0

  ; Set size of grid
  x_len = 10
  y_len = 5
  
  ; Set location of sun
  sun_x = 2
  sun_y = 0
  
  ; Set location of sensor
  sensor_x = 7
  sensor_y = y_len ; Sensor is off the bottom of the grid!
  
  ; Create arrays of constants
  wavelengths = [0.3, 0.305, 0.31, 0.315, 0.32, 0.325, 0.33, 0.335, 0.34, $
      0.345, 0.35, 0.36, 0.37, 0.38, 0.39, 0.4, 0.41, 0.42, 0.43, 0.44, 0.45, 0.46, 0.47, $
      0.48, 0.49, 0.5, 0.51, 0.52, 0.53, 0.54, 0.55, 0.57, 0.593, 0.61, 0.63, 0.656, $
      0.6676, 0.69, 0.71, 0.718, 0.7244, 0.74, 0.7525, 0.7575, 0.7625, 0.7675, 0.78, 0.8, $
      0.816, 0.8237, 0.8315, 0.84, 0.86, 0.88, 0.905, 0.915, 0.925, 0.93, 0.937, 0.948, $
      0.965, 0.98, 0.9935, 1.04, 1.07, 1.1, 1.12, 1.13, 1.145, 1.161, 1.17, 1.2, 1.24, $
      1.27, 1.29, 1.32, 1.35, 1.395, 1.4425, 1.4625, 1.477, 1.497, 1.52, 1.539, 1.558, $
      1.578, 1.592, 1.61, 1.63, 1.646, 1.678, 1.74, 1.8, 1.86, 1.92, 1.96, 1.985, 2.005, $
      2.035, 2.065, 2.1, 2.148, 2.198, 2.27, 2.36, 2.45, 2.5, 2.6, 2.7, 2.8, 2.9, 3.0, $
      3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9, 4.0]
       
  extra_terrestrial = [ 535.9, 558.3, 622.0, 692.7, 715.1, 832.9, 961.9, 931.9, 900.6, 911.3, 975.5, $
      975.9, 1119.9, 1103.8, 1033.8, 1479.1, 1701.3, 1740.4, 1587.2, 1837.0, 2005.0, $
      2043.0, 1987.0, 2027.0, 1896.0, 1909.0, 1927.0, 1831.0, 1891.0, 1898.0, 1892.0, $
      1840.0, 1768.0, 1728.0, 1658.0, 1524.0, 1531.0, 1420.0, 1399.0, 1374.0, 1373.0, $
      1298.0, 1269.0, 1245.0, 1223.0, 1205.0, 1183.0, 1148.0, 1091.0, 1062.0, 1038.0, $
      1022.0, 998.7, 947.2, 893.2, 868.2, 829.7, 830.3, 814.0, 786.9, 768.3, 767.0, 757.6, $
      688.1, 640.7, 606.2, 585.9, 570.2, 564.1, 544.2, 533.4, 501.6, 477.5, 442.7, 440.0, $
      416.8, 391.4, 358.9, 327.5, 317.5, 307.3, 300.4, 292.8, 275.5, 272.1, 259.3, 246.9, $
      244.0, 243.5, 234.8, 220.5, 190.8, 171.1, 144.5, 135.7, 123.0, 123.8, 113.0, 108.5, $
      97.5, 92.4, 82.4, 74.6, 68.3, 63.8, 49.5, 48.5, 38.6, 36.6, 32.0, 28.1, 24.8, 22.1, $
      19.6, 17.5, 15.7, 14.1, 12.7, 11.5, 10.4, 9.5, 8.6 ]

  wv_abs_coef = [ 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, $
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, $
      0.075, 0.0, 0.0, 0.0, 0.0, 0.016, 0.0125, 1.8, 2.5, 0.061, 0.0008, 0.0001, 0.00001, $
      0.00001, 0.0006, 0.036, 1.6, 2.5, 0.5, 0.155, 0.00001, 0.0026, 7.0, 5.0, 5.0, 27.0, $
      55.0, 45.0, 4.0, 1.48, 0.1, 0.00001, 0.001, 3.2, 115.0, 70.0, 75.0, 10.0, 5.0, 2.0, $
      0.002, 0.002, 0.1, 4.0, 200.0, 1000.0, 185.0, 80.0, 80.0, 12.0, 0.16, 0.002, 0.0005, $
      0.0001, 0.00001, 0.0001, 0.001, 0.01, 0.036, 1.1, 130.0, 1000.0, 500.0, 100.0, 4.0, $
      2.9, 1.0, 0.4, 0.22, 0.25, 0.33, 0.5, 4.0, 80.0, 310.0, 15000.0, 22000.0, 8000.0, $
      650.0, 240.0, 230.0, 100.0, 120.0, 19.5, 3.6, 3.1, 2.5, 1.4, 0.17, 0.0045 ]
      
  gas_abs_coef = [ 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, $
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, $
      0.0, 0.0, 0.0, 0.0, 0.15, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 0.35, 0.0, 0.0, 0.0, $
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, $
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.05, 0.3, 0.02, 0.0002, 0.00011, 0.00001, 0.05, $
      0.011, 0.005, 0.0006, 0.0, 0.005, 0.13, 0.04, 0.06, 0.13, 0.001, 0.0014, 0.0001, $
      0.00001, 0.00001, 0.0001, 0.001, 4.3, 0.2, 21.0, 0.13, 1.0, 0.08, 0.001, 0.00038, $
      0.001, 0.0005, 0.00015, 0.00014, 0.00066, 100.0, 150.0, 0.13, 0.0095, 0.001, 0.8, $
      1.9, 1.3, 0.075, 0.01, 0.00195, 0.004, 0.29, 0.025 ]
  
  ozone_abs_coef = [ 10.0, 4.8, 2.7, 1.35, 0.8, 0.38, 0.16, 0.075, 0.04, 0.019, 0.007, 0.0, 0.0, 0.0, $
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.003, 0.006, 0.009, 0.01400, 0.021, 0.03, 0.04, $
      0.048, 0.063, 0.075, 0.085, 0.12, 0.119, 0.12, 0.09, 0.065, 0.051, 0.028, 0.018, $
      0.015, 0.012, 0.01, 0.008, 0.007, 0.006, 0.005, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, $
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, $
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, $
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, $
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, $
      0.0 ]
 
  wavelengths_to_use = [0, 27, 59, 120]
 
  wavelengths = wavelengths[wavelengths_to_use]
  extra_terrestrial = extra_terrestrial[wavelengths_to_use]
  wv_abs_coef = wv_abs_coef[wavelengths_to_use]
  gas_abs_coef = gas_abs_coef[wavelengths_to_use]
  ozone_abs_coef = ozone_abs_coef[wavelengths_to_use]

  ; Create params structure
  params_struct = {params, precip_water_depth: 0.1}

  ; Create grid
  grid = intarr(x_len, y_len)
  
  n_wavelengths = N_ELEMENTS(wavelengths_to_use)
  
  ; Create variables for storing the final result
  received_irradiance_vertical = REPLICATE(0.0, n_wavelengths)
  received_irradiance_left = REPLICATE(0.0, n_wavelengths)
  received_irradiance_right = REPLICATE(0.0, n_wavelengths)
  
  number_of_sensor_hits = 0L
  
  ; Create database of params which is referenced by grid cell contents
  db = replicate(params_struct, 100)
  
  
  ; ----------------------
  ; START MONTE CARLO LOOP
  ; ----------------------
  FOR it = 0L, 1000 DO BEGIN
    ; Start ray at the sun
    ray_x = sun_x
    ray_y = sun_y
    
    ; Choose randomly which angle it is coming out of the sun (ie.
    ; what it's 'imaginary' previous point was)
    prev_ray_x = CHOOSE_RANDOMLY([sun_x - 1, sun_x, sun_x + 1])
    prev_ray_x = prev_ray_x[0]
    prev_ray_y = -1
    
    
    precip_water_depth = 0
    n_cells = 0
    
    ; Loop until ray location is at edge of grid
    WHILE 1 DO BEGIN
      ;print, ray_x, ray_y
      
      
      ; If ray location is at edge of grid, kill ray (and store if needed)
      if ray_x GE x_len OR ray_x LT 0 THEN BREAK
      IF ray_y GE y_len OR ray_y LT 0 THEN BREAK
      
      n_cells += 1
      
      ; Get the parameters for this cell from the database
      params = db[grid[ray_x, ray_y]]
    
      
    
      ; Sum the precipitable water depth - so at the end we have the total for the whole path
      precip_water_depth += params.precip_water_depth
      
      
      
      ; Decide whether to scatter or not
      IF RANDOMU(seed, 1) GT 0.5 THEN BEGIN
        ; Yes - calculate scatter
        
        ; Calculate Rayleigh scatter
        ;print, "Doing Rayleigh Scatter"
        new_coords = CALCULATE_RAYLEIGH_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y)   
      ENDIF ELSE BEGIN
       ;print, "Going straight"
        ; No - send ray straight on (depending on previous grid location)
        new_coords = CALCULATE_STRAIGHT_PATH(prev_ray_x, prev_ray_y, ray_x, ray_y)
      ENDELSE 
        
        ; Assign values to variables from new_coords
        new_x = new_coords[0]
        new_y = new_coords[1]
        
        
        ; Set location to new locations
        prev_ray_x = ray_x
        prev_ray_y = ray_y
        
        ray_x = new_x
        ray_y = new_y
    ENDWHILE
    

    
    ;print, "Ray: ", ray_x, ray_y
    ;print, "Sensor: ", sensor_x, sensor_y
    
    ; Check whether final location is somewhere we're interested in
    ; (basically: is it near the sensor?)
    IF ray_y NE sensor_y THEN CONTINUE ; Check it's at the bottom of the grid
    IF ray_x NE sensor_x THEN CONTINUE

    ; ------------------------------------------
    ; RAY HAS GOT TO SENSOR - so do calculations
    ; ------------------------------------------
    
    number_of_sensor_hits += 1
    
    ; Calculate the relative path length
    ; This is like M (the relative airmass), but is the ratio of the number of cells the ray passed through
    ; over the vertical height of the grid (ie. the shortest route the ray could have taken)
    path_length = FLOAT(n_cells) / y_len
    
    ; Transmittance due to water vapour (H2O) from SPCTRAL2 manual, eqn 2-8
    trans_water_vapour = EXP(  (-0.2385 * wv_abs_coef * precip_water_depth) / (1+20.07*wv_abs_coef * precip_water_depth)^0.45)
    
    ; Transmittance due to uniformly mixed gas absorption from SPCTRAL2 manual eqn 2-11
    trans_mixed_gases = EXP(  (-1.41 * gas_abs_coef * path_length) / (1 + 118.93 * gas_abs_coef * path_length)^0.45)
    
    ; Calculate ozone amount using van Heuklon's equation
    ozone_amount = CALCULATE_OZONE_AMOUNT(day_of_year, lat, long)
    
    ; Transmittance due to ozone from SPCTRAL2 manual eqn 2-9 with our path length instead of Mo (as Mo is approx anyway)
    trans_ozone = EXP( -1 * DOUBLE(ozone_abs_coef) * ozone_amount * 0.001 * path_length)
      
    ;print, "Final location ", ray_x, ray_y
    ;print, "Total water ", precip_water_depth
    ;print, "Trans WV ", trans_water_vapour
    ;print, "Path length", path_length
    ;print, "Trans Ozone", trans_ozone
    ;print, "Trans Gas", trans_mixed_gases
    
    earth_sun_distance_factor = CALCULATE_EARTH_SUN_DISTANCE_FACTOR(day_of_year)
    
    ; From SPCTRAL2 manual, eqn 2-1
    ; The first calculation is for a surface normal to the direction of the sun
    ; Second calculation converts this to a horizontal surface
    irradiance = extra_terrestrial * trans_water_vapour * trans_ozone * trans_mixed_gases
    irradiance = irradiance * COS(solar_zenith_angle * !DTOR)
    ;print, "Wavelength", wavelengths
    ;print, "IRRADIANCE", irradiance
    
    ; Store irradiance at sensor, by angle (basically vertical,
    ; from left or from right) - depending on where it's come from
    
    diff = sensor_x - prev_ray_x
    
    CASE diff OF
      1: received_irradiance_left += irradiance
      0: received_irradiance_vertical += irradiance
      -1: received_irradiance_right += irradiance
    ENDCASE
  ENDFOR
  
  print, "FINAL RESULTS"
  print, "-------------"
  print, "N hits ", NUMBER_OF_SENSOR_HITS
  print, "Received Irr Left", RECEIVED_IRRADIANCE_LEFT
  print, "LEFT:"
  print, received_irradiance_left / number_of_sensor_hits
  print, "VERTICAL:"
  print, received_irradiance_vertical
  print, "RIGHT:"
  print, received_irradiance_right
  
  end_time = SYSTIME(1)
  
  print, "Time taken = ", end_time - start_time
  
END