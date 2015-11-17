FUNCTION RUN_RTM, cloud_center_x, cloud_center_y, cloud  
aerosol_types = {maritime: 0, urban: 1, cumulus_cont_poll: 2}

AEROSOL_SCATTER = 1
RAYLEIGH_SCATTER = 2
NO_SCATTER = 0

  start_time = SYSTIME(1)

  ; Set number of iterations
  n_iterations = 50000
  ;n_iterations = 100

  ; Set day of year
  day_of_year = 78
  
  ; Set solar zenith angle
  solar_zenith_angle = 5
  
  ; Set location on the surface of the Earth
  lat = 50
  long = 0

  ; Set size of grid
  x_len = 20
  y_len = 20
  
  ; Set location of sun
  sun_x = 8
  sun_y = 0
  
  ; Set location of sensor
  sensor_x = x_len / 2
  ;sensor_x = 20
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
  
  ; Get Single Scattering Albedo (SSA) values for aerosols
  ssa = SSA_VALUES()
  ; Get absorption coefficient values for aerosols
  absorb = ABS_VALUES()
  
  aero_amount_prob = AEROSOL_AMOUNT_PROBABILITIES()

  ; Calculate likelihood of Rayleigh scattering occurring
  rayleigh_scat_prob = (1/wavelengths^4)/150
  
  ; Calculate ozone amount using van Heuklon's equation (based on date, lat and long)
  ozone_amount = CALCULATE_OZONE_AMOUNT(day_of_year, lat, long)
  
  earth_sun_distance_factor = CALCULATE_EARTH_SUN_DISTANCE_FACTOR(day_of_year)
 
  ;wavelengths_to_use = [0, 1, 27, 59, 120]
  wavelengths_to_use = indgen(122)
 
  ; Reduce all of the parameters arrays to just contain the values for the wavelengths we're going to use
  wavelengths = wavelengths[wavelengths_to_use]
  extra_terrestrial = extra_terrestrial[wavelengths_to_use]
  absorb.water = absorb.water[wavelengths_to_use]
  absorb.gas = absorb.gas[wavelengths_to_use]
  absorb.ozone = absorb.ozone[wavelengths_to_use]
  rayleigh_scat_prob = rayleigh_scat_prob[wavelengths_to_use]
  
  ; Keep track of how many wavelengths we need to deal with
  n_wavelengths = N_ELEMENTS(wavelengths_to_use)
  
  ; Create variables for storing the final result
  received_irradiance_vertical = REPLICATE(0.0, n_wavelengths)
  received_irradiance_left = REPLICATE(0.0, n_wavelengths)
  received_irradiance_right = REPLICATE(0.0, n_wavelengths)
  number_of_sensor_hits = 0L ; Must be a long as we do LOTS of sensor hits
  
 
  ; Set up the basic beginning parameters for the whole grid (whole atmosphere)
  ; Liquid Water Content, Aerosol Type and Aerosol Amount
  grid_precip_water_content = PARAM_LWC(x_len, y_len, 0.5)
  grid_aerosol_type = PARAM_AEROSOL_TYPE(x_len, y_len)
  grid_aerosol_amount = PARAM_AEROSOL_AMOUNT(x_len, y_len)
  
  ; If we're working with clouds then place the cloud(s)
  IF cloud EQ 1 THEN PLACE_CLOUDS, cloud_center_x, cloud_center_y, grid_aerosol_type, grid_aerosol_amount, grid_precip_water_content
  
  ; ----------------------
  ; START MONTE CARLO LOOP
  ; ----------------------
  FOR it = 0L, n_iterations DO BEGIN
    IF it MOD 100 EQ 0 THEN print, "At iteration ", it
 
    ; Start ray at the sun
    start_ray_x = sun_x
    start_ray_y = sun_y
    
    ; Choose randomly which angle it is coming out of the sun (ie.
    ; what it's 'imaginary' previous point was)
    start_prev_ray_x = CHOOSE_RANDOMLY([sun_x - 1, sun_x, sun_x + 1])
    start_prev_ray_x = start_prev_ray_x[0]
    start_prev_ray_y = -1
    
    ; Start loop over selected wavelengths
    FOR wv = 0, N_ELEMENTS(wavelengths_to_use) - 1 DO BEGIN
      x_points = list()
      y_points = list()
      
      ray_x = start_ray_x
      ray_y = start_ray_y
      
      prev_ray_x = start_prev_ray_x
      prev_ray_y = start_prev_ray_y
    
      wavelength = wavelengths[wv]
      
      ; Initialise values that we will be summing into later on
      precip_water_depth = 0
      aerosol_amount = 0
      n_cells = 0
      
      ; Loop until ray location is at edge of grid
      WHILE 1 DO BEGIN
        ; If ray location is at edge of grid, destroy the ray and skip to the bottom of the loop
        if ray_x GE x_len OR ray_x LT 0 THEN BREAK
        IF ray_y GE y_len OR ray_y LT 0 THEN BREAK
        
        x_points->add, ray_x
        y_points->add, ray_y
        
        ; Increment the count of how many cells we've been through
        n_cells += 1

        ; Sum the precipitable water depth and aerosol amount - so at the end we have the total for the whole path
        precip_water_depth += grid_precip_water_content[ray_x, ray_y]
        aerosol_amount += grid_aerosol_amount[ray_x, ray_y]
                
        rand = RANDOMU(seed, 1)
        
        ; Calculate the probability of aerosol scattering occurring
        CASE grid_aerosol_type[ray_x, ray_y] OF
          aerosol_types.maritime: aero_prob = aero_amount_prob[grid_aerosol_amount[ray_x, ray_y]] * ssa.maritime[wv]
          aerosol_types.cumulus_cont_poll: aero_prob = aero_amount_prob[grid_aerosol_amount[ray_x, ray_y]] * ssa.cumulus_cont_poll[wv]
          aerosol_types.urban: aero_prob = aero_amount_prob[grid_aerosol_amount[ray_x, ray_y]] * ssa.urban[wv]
        ENDCASE
        
        ; Calculate whether to do Rayleigh Scattering, Aerosol Scattering or no scattering
        CASE 1 OF
          rand LT (aero_prob / 2): new_coords = CALCULATE_AEROSOL_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y, grid_aerosol_type[ray_x, ray_y]) 
          rand GT (aero_prob / 2) and rand LT (aero_prob / 2) + rayleigh_scat_prob[wv]: new_coords = CALCULATE_RAYLEIGH_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y)   
          ELSE: new_coords = CALCULATE_STRAIGHT_PATH(prev_ray_x, prev_ray_y, ray_x, ray_y)
        ENDCASE
        
        
        
        
;        ; TODO: Better way of deciding what kind (Rayleigh vs. Aerosol) of scattering to do
;        IF aero_prob GT rayleigh_scat_prob[wv] THEN BEGIN
;          test_probability = aero_prob
;        ENDIF ELSE BEGIN
;          test_probability = rayleigh_scat_prob[wv]
;          scatter_type = 2
;        ENDELSE
;         
;        ; Decide whether to scatter
;        IF rand LT test_probability THEN BEGIN
;          ; Scattering will take place
;          IF scatter_type EQ 1 THEN BEGIN
;            ; Calculate aerosol scatter
;            ;print, "Aero Scattering taking place"
;            new_coords = CALCULATE_AEROSOL_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y, grid_aerosol_type[ray_x, ray_y]) 
;          ENDIF ELSE BEGIN
;            ; Calculate Rayleigh scatter
;            ;print, "Rayleigh Scattering taking place"
;            new_coords = CALCULATE_RAYLEIGH_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y)   
;          ENDELSE          
;        ENDIF ELSE BEGIN
;          ; No scattering will occur - send the ray straight on
;          new_coords = CALCULATE_STRAIGHT_PATH(prev_ray_x, prev_ray_y, ray_x, ray_y)
;        ENDELSE 
          
          ; Assign values to variables from new_coords
          new_x = new_coords[0]
          new_y = new_coords[1]
          
          
          ; Set location to new locations
          prev_ray_x = ray_x
          prev_ray_y = ray_y
          
          ray_x = new_x
          ray_y = new_y
      ENDWHILE

      
      
      ; Check whether final location is somewhere we're interested in
      ; (basically: is it near the sensor?)
      IF ray_y NE sensor_y THEN CONTINUE
      IF ray_x NE sensor_x THEN CONTINUE
  
      ; ------------------------------------------
      ; RAY HAS GOT TO SENSOR - so do calculations
      ; ------------------------------------------
      ;print, x_points
      ;print, y_points
      
      x_points->add, sensor_x
      y_points->add, sensor_y
      
      plot, x_points->toArray(), y_points->toArray(), xrange=[0, x_len], yrange=[y_len,0], xtitle="X", ytitle="Y", position=[0.1, 0.15, 0.9, 0.85]      
      x = x_points->toArray()
      y = y_points->toArray()
      save, x, y, filename="/Users/robin/Dropbox/IDL_Savs/ArrowsPlot8.sav"
      
      ; TODO: Split this by angle?
      number_of_sensor_hits += 1
      
      ; Calculate the relative path length
      ; This is like M (the relative airmass), but is the ratio of the number of cells the ray passed through
      ; over the vertical height of the grid (ie. the shortest route the ray could have taken)
      path_length = FLOAT(n_cells) / y_len
      
      ; Transmittance due to water vapour (H2O) from SPCTRAL2 manual, eqn 2-8
      trans_water_vapour = EXP(  (DOUBLE(-0.2385) * absorb.water[wv] * precip_water_depth) / (1+20.07*absorb.water[wv] * precip_water_depth)^0.45)
            
      ; Transmittance due to uniformly mixed gas absorption from SPCTRAL2 manual eqn 2-11
      trans_mixed_gases = EXP(  (DOUBLE(-1.41) * absorb.gas[wv] * path_length) / (1 + 118.93 * absorb.gas[wv] * path_length)^0.45)
      
      ; Transmittance due to ozone from SPCTRAL2 manual eqn 2-9 with our path length instead of Mo (as Mo is approx anyway)
      trans_ozone = EXP( -1 * DOUBLE(absorb.ozone[wv]) * ozone_amount * 0.001 * path_length)
      
      ; TODO: Sort out aerosol type to use for this (count separately for all types?)
      scaled_aerosol_amount = aerosol_amount / n_cells
      trans_aero_abs = EXP( DOUBLE(-1) * absorb.maritime[wv] * scaled_aerosol_amount * path_length)
      
      ; From SPCTRAL2 manual, eqn 2-1
      ; The first calculation is for a surface normal to the direction of the sun
      ; Second calculation converts this to a horizontal surface
      irradiance = extra_terrestrial[wv] * earth_sun_distance_factor * trans_water_vapour * trans_ozone * trans_mixed_gases * trans_aero_abs
      
      ; Store irradiance at sensor, by angle (basically vertical,
      ; from left or from right) - depending on where it's come from
      
      diff = sensor_x - prev_ray_x
      
      CASE diff OF
        1: received_irradiance_left[wv] += irradiance
        0: received_irradiance_vertical[wv] += irradiance
        -1: received_irradiance_right[wv] += irradiance
      ENDCASE
    ENDFOR
  ENDFOR
  
  print, "FINAL RESULTS"
  print, "-------------"
  print, "N hits ", NUMBER_OF_SENSOR_HITS
  
  ;print, "LEFT:"
  ;print, received_irradiance_left / number_of_sensor_hits
  ;print, "VERTICAL:"
  ;print, received_irradiance_vertical / number_of_sensor_hits
  ;print, "RIGHT:"
  ;print, received_irradiance_right / number_of_sensor_hits
  
  end_time = SYSTIME(1)
  
  print, "Time taken = ", end_time - start_time
  
  result = {wavelengths: wavelengths, vertical: received_irradiance_vertical / NUMBER_OF_SENSOR_HITS, left: received_irradiance_left / NUMBER_OF_SENSOR_HITS, right: received_irradiance_right / NUMBER_OF_SENSOR_HITS}

  return, result
  
END