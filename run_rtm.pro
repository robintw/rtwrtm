PRO RUN_RTM
  start_time = SYSTIME(1)

  ; Set number of iterations
  n_iterations = 1000

  ; Set day of year
  day_of_year = 78
  
  ; Set solar zenith angle
  solar_zenith_angle = 5
  
  ; Set location on the surface of the Earth
  lat = 50
  long = 0

  ; Set size of grid
  x_len = 10
  y_len = 5
  
  ; Set location of sun
  sun_x = 5
  sun_y = 0
  
  ; Set location of sensor
  sensor_x = 5
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
  
  ; Calculated by linearly interpolating the values from soot00 in the OPAC database to match the wavelengths used here
  aero_abs_coef = [8.3289997e-007,  8.2177998e-007,  8.1065999e-007,  7.9954001e-007,  7.8842002e-007,  7.7730003e-007,  7.6617997e-007,  7.5505998e-007,  7.4393999e-007,  7.3282000e-007,  7.2170001e-007,  7.0357997e-007,  6.8545999e-007,  6.6734001e-007,  6.4922003e-007,  6.3109999e-007,  6.1616001e-007,  6.0122002e-007,  5.8627999e-007,  5.7134000e-007,  5.5640002e-007,  5.4397999e-007,  5.3156000e-007,  5.1914001e-007,  5.0671999e-007,  4.9430000e-007,  4.8310001e-007,  4.7190002e-007,  4.6070003e-007,  4.4949998e-007,  4.3829999e-007,  4.2086001e-007,  4.0080400e-007,  3.8797999e-007,  3.7454000e-007,  3.5723599e-007,  3.4976562e-007,  3.3534000e-007,  3.2398001e-007,  3.2004400e-007,  3.1689521e-007,  3.0922000e-007,  3.0322500e-007,  3.0107500e-007,  2.9892501e-007,  2.9677501e-007,  2.9140001e-007,  2.8280000e-007,  2.7755201e-007,  2.7502640e-007,  2.7246800e-007,  2.6968001e-007,  2.6312000e-007,  2.5656000e-007,  2.4864501e-007,  2.4593499e-007,  2.4322500e-007,  2.4187000e-007,  2.3997301e-007,  2.3699200e-007,  2.3238501e-007,  2.2831999e-007,  2.2466150e-007,  2.1555601e-007,  2.1004799e-007,  2.0454000e-007,  2.0086800e-007,  1.9903200e-007,  1.9627800e-007,  1.9334040e-007,  1.9168801e-007,  1.8617999e-007,  1.7883600e-007,  1.7456000e-007,  1.7212000e-007,  1.6845999e-007,  1.6480000e-007,  1.5931000e-007,  1.5351500e-007,  1.5107500e-007,  1.4930600e-007,  1.4686600e-007,  1.4494000e-007,  1.4345800e-007,  1.4197600e-007,  1.4041600e-007,  1.3932400e-007,  1.3792000e-007,  1.3636000e-007,  1.3511200e-007,  1.3261600e-007,  1.2778000e-007,  1.2384000e-007,  1.2004800e-007,  1.1625600e-007,  1.1372800e-007,  1.1214800e-007,  1.1098380e-007,  1.0968660e-007,  1.0838940e-007,  1.0687600e-007,  1.0480048e-007,  1.0263848e-007,  9.9525201e-008,  9.5633605e-008,  9.1741998e-008,  8.9580000e-008,  8.7020002e-008,  8.4459999e-008,  8.1900001e-008,  7.9339998e-008,  7.6780000e-008,  7.3695003e-008,  7.0609999e-008,  6.8741580e-008,  6.6913635e-008,  6.5450000e-008,  6.3638002e-008,  6.1825999e-008,  6.0128001e-008,  5.8543998e-008,  5.6960000e-008]
  
  ; Calculated by linearly interpolating the maritime aerosol coefficients from OPAC to match wavelengths here
  aero_maritime_ext_coef = [0.031190000,     0.031062000,     0.030934000,     0.030806000,     0.030678000,     0.030550000,     0.030422000,     0.030294000,     0.030166000,     0.030038000,     0.029910000,     0.029706000,     0.029502000,     0.029298000,     0.029094000,     0.028890000,     0.028702000,     0.028514000,     0.028326000,     0.028138000,     0.027950000,     0.027806000,     0.027662000,     0.027518000,     0.027374000,     0.027230000,     0.027104000,     0.026978000,     0.026852000,     0.026726000,     0.026600000,     0.026320000,     0.025998000,     0.025794000,     0.025582000,     0.025299200,     0.025162320,     0.024898000,     0.024664000,     0.024571200,     0.024496960,     0.024316000,     0.024165000,     0.024095000,     0.024025000,     0.023955000,     0.023780000,     0.023500000,     0.023332000,     0.023251150,     0.023169250,     0.023080000,     0.022870000,     0.022660000,     0.022388500,     0.022265500,     0.022142500,     0.022081000,     0.021994900,     0.021859600,     0.021650500,     0.021466000,     0.021299950,     0.020796000,     0.020477999,     0.020160000,     0.019948000,     0.019842000,     0.019683000,     0.019513400,     0.019418000,     0.019099999,     0.018676000,     0.018360400,     0.018150800,     0.017836399,     0.017522000,     0.017050400,     0.016552600,     0.016343000,     0.016191040,     0.015981440,     0.015750800,     0.015561560,     0.015372320,     0.015173121,     0.015033680,     0.014854400,     0.014655200,     0.014495840,     0.014177120,     0.013559600,     0.013078000,     0.012619600,     0.012161200,     0.011855600,     0.011664600,     0.011517879,     0.011325159,     0.011132440,     0.010907601,     0.010599248,     0.010278048,    0.0098155201,    0.0092373607,    0.0086591997,    0.0083380000,    0.0086319997,    0.0089260001,    0.0092199999,    0.0095140003,    0.0098080000,    0.0083195014,    0.0068309998,    0.0064320528,    0.0060437270,    0.0057510000,    0.0054398003,    0.0051285999,    0.0048954001,    0.0047401999,    0.0045850000]
  
  ; Scale the above so we can use an aerosol index of 1-10 to go from few aerosols (little scattering) to loads of aerosols
  aero_maritime_ext_coef = (aero_maritime_ext_coef * 30)/10
  
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
  wv_abs_coef = wv_abs_coef[wavelengths_to_use]
  gas_abs_coef = gas_abs_coef[wavelengths_to_use]
  ozone_abs_coef = ozone_abs_coef[wavelengths_to_use]
  rayleigh_scat_prob = rayleigh_scat_prob[wavelengths_to_use]

  ; Create grid
  grid = intarr(x_len, y_len)  
  
  n_wavelengths = N_ELEMENTS(wavelengths_to_use)
  
  ; Create variables for storing the final result
  received_irradiance_vertical = REPLICATE(0.0, n_wavelengths)
  received_irradiance_left = REPLICATE(0.0, n_wavelengths)
  received_irradiance_right = REPLICATE(0.0, n_wavelengths)
  number_of_sensor_hits = 0L
  
  ; Set aerosols across the whole sky to be low
  
  
  ; Parameterise LWC according to rough LWC profile through atmosphere (from literature)
  grid_precip_water_content = PARAM_LWC(x_len, y_len, 2.6)
  grid_aerosol_type = PARAM_AEROSOL_TYPE(x_len, y_len)
  grid_aerosol_amount = PARAM_AEROSOL_AMOUNT(x_len, y_len)
  

  IF cloud EQ 1 THEN PLACE_CLOUDS, cloud_center_x, cloud_center_y, grid_aerosol_amount, grid_precip_water_content

  
  

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
      ray_x = start_ray_x
      ray_y = start_ray_y
      
      prev_ray_x = start_prev_ray_x
      prev_ray_y = start_prev_ray_y
    
      wavelength = wavelengths[wv]
      ;print, "Doing wavelength ", wavelength
      
      ; Initialise values that we will be summing into later on
      precip_water_depth = 0
      aerosol_amount = 0
      n_cells = 0
      
      ; Loop until ray location is at edge of grid
      WHILE 1 DO BEGIN
        ; If ray location is at edge of grid, destroy the ray and skip to the bottom of the loop
        if ray_x GE x_len OR ray_x LT 0 THEN BREAK
        IF ray_y GE y_len OR ray_y LT 0 THEN BREAK
        
        ;print, "After break"
        
        n_cells += 1
        
        ; Get the parameters for this cell from the database
        ;params = db[grid[ray_x, ray_y]]

        ; Sum the precipitable water depth - so at the end we have the total for the whole path
        precip_water_depth += grid_precip_water_content[ray_x, ray_y]
        aerosol_amount += grid_aerosol_amount[ray_x, ray_y]
        
        
        rand = RANDOMU(seed, 1)
        
        aero_prob = aero_maritime_ext_coef[wv] * GRID_AEROSOL_AMOUNT[ray_x, ray_y]

        ; TODO: Better way of deciding what kind (Rayleigh vs. Aerosol) of scattering to do
        IF aero_prob GT rayleigh_scat_prob[wv] THEN BEGIN
          test_probability = aero_prob
        ENDIF ELSE BEGIN
          test_probability = rayleigh_scat_prob[wv]
          scatter_type = 2
        ENDELSE
         
        ; Decide whether to scatter
        IF rand LT test_probability THEN BEGIN
          ; Scattering will take place
          IF scatter_type EQ 1 THEN BEGIN
            ; Calculate aerosol scatter
            ;print, "Aero Scattering taking place"
            new_coords = CALCULATE_AEROSOL_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y, grid_aerosol_type[ray_x, ray_y]) 
          ENDIF ELSE BEGIN
            ; Calculate Rayleigh scatter
            ;print, "Rayleigh Scattering taking place"
            new_coords = CALCULATE_RAYLEIGH_SCATTER(prev_ray_x, prev_ray_y, ray_x, ray_y)   
          ENDELSE          
        ENDIF ELSE BEGIN
          ; No scattering will occur - send the ray straight on
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

      
      ; Check whether final location is somewhere we're interested in
      ; (basically: is it near the sensor?)
      IF ray_y NE sensor_y THEN CONTINUE
      IF ray_x NE sensor_x THEN CONTINUE
  
      ; ------------------------------------------
      ; RAY HAS GOT TO SENSOR - so do calculations
      ; ------------------------------------------
      
      ; TODO: Split this by angle?
      number_of_sensor_hits += 1
      
      ; Calculate the relative path length
      ; This is like M (the relative airmass), but is the ratio of the number of cells the ray passed through
      ; over the vertical height of the grid (ie. the shortest route the ray could have taken)
      path_length = FLOAT(n_cells) / y_len
      
      ; Transmittance due to water vapour (H2O) from SPCTRAL2 manual, eqn 2-8
      trans_water_vapour = EXP(  (DOUBLE(-0.2385) * wv_abs_coef[wv] * precip_water_depth) / (1+20.07*wv_abs_coef[wv] * precip_water_depth)^0.45)
            
      ; Transmittance due to uniformly mixed gas absorption from SPCTRAL2 manual eqn 2-11
      trans_mixed_gases = EXP(  (DOUBLE(-1.41) * gas_abs_coef[wv] * path_length) / (1 + 118.93 * gas_abs_coef[wv] * path_length)^0.45)
      
      
      
      ; Transmittance due to ozone from SPCTRAL2 manual eqn 2-9 with our path length instead of Mo (as Mo is approx anyway)
      trans_ozone = EXP( -1 * DOUBLE(ozone_abs_coef[wv]) * ozone_amount * 0.001 * path_length)
      
      
      scaled_aerosol_amount = aerosol_amount / n_cells
      trans_aero_abs = EXP( DOUBLE(-1) * aero_abs_coef[wv] * scaled_aerosol_amount * path_length)
      
      ; From SPCTRAL2 manual, eqn 2-1
      ; The first calculation is for a surface normal to the direction of the sun
      ; Second calculation converts this to a horizontal surface
      irradiance = extra_terrestrial[wv] * earth_sun_distance_factor * trans_water_vapour * trans_ozone * trans_mixed_gases * trans_aero_abs

      irradiance = irradiance * COS(solar_zenith_angle * !DTOR)
      
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
  
  print, "LEFT:"
  print, received_irradiance_left / number_of_sensor_hits
  print, "VERTICAL:"
  print, received_irradiance_vertical / number_of_sensor_hits
  print, "RIGHT:"
  print, received_irradiance_right / number_of_sensor_hits
  
  end_time = SYSTIME(1)
  
  print, "Time taken = ", end_time - start_time
  
  cgWindow, 'plot', wavelengths, RECEIVED_IRRADIANCE_VERTICAL / NUMBER_OF_SENSOR_HITS
  cgWindow, 'plot', wavelengths, EXTRA_TERRESTRIAL, linestyle=5
  
  print, "Done"
  
END