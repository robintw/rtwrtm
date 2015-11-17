FUNCTION DO_CONVOL, x, y, z, array
  kernel = bytarr(3, 3, 3)
  kernel[x,y, z] = 1
  
  return, CONVOL(array, kernel, /CENTER, /EDGE_TRUNCATE)
END

PRO CLOUD_CA
  len = 100
  p_ext = 0
  
  p_wind = 0.3
  wind_east = 1
  wind_north = 1
  
  ; Create grid
  act = bytarr(len, len, len)
  hum = bytarr(len, len, len)
  cld = bytarr(len, len, len)
  
  

  
  ; Initialise act randomly to humid states
  rand = RANDOMU(seed, len, len, len)
  
  hum = rand GT 0.6
  print, max(hum), min(hum)
  ;tvscl, act
  
  rand = RANDOMU(seed, len, len, len)
  ;act = rand GT 0.999999
  ;nop = WHERE(act EQ 1, count)
  ;print, count
  act[50, 50, 50] = 1
  ;act[230, 190, 0] = 1
  ;act[160, 30, 0] = 1
  
  FOR loop = 0L, 80 DO BEGIN
    ; A  B  C
    ; D  E  F
    ; G  H  I
    A = DO_CONVOL(0, 1, 1, act)
    B = DO_CONVOL(1, 1, 0, act)
    C = DO_CONVOL(2, 1, 1, act)
    D = DO_CONVOL(1, 1, 2, act)
    E = DO_CONVOL(1, 2, 1, act)
    F = DO_CONVOL(1, 0, 1, act)
  
    ; Randomly remove some cloud pixels (based on p_ext)
    rand = RANDOMU(seed, len, len, len)
    ext = rand LT p_ext
    indices = WHERE(ext EQ 1, count)
    if count GT 0 then cld[indices] = 0
  
    ; Make active if humid and neighbour is active
    act = act EQ 0 AND hum EQ 1 AND (A EQ 1 OR B EQ 1 OR C EQ 1 OR D EQ 1 OR E EQ 1 OR  F EQ 1)
    
    ; If active then make it cloud    
    cld = act EQ 1 OR cld EQ 1
    
    ; If it's humid and no longer active, keep it humid, otherwise (if it's active)
    ; make it not humid
    hum = hum EQ 1 AND act EQ 0
    
    ;rand = RANDOMU(seed)
    ;IF rand LT p_wind THEN BEGIN
    ;  shift_dist = [wind_east, wind_north, 0]
    ;  act = SHIFT(act, shift_dist)
    ;  hum = SHIFT(hum, shift_dist)
    ;ENDIF
    
    print, loop
    cgImage, TOTAL(cld, 2)
  ENDFOR
  ;res = TOTAL(cld, 2)
  ;r = res
  r = cld
  help, r
  
  ;ENVI_ENTER_DATA, r
  ;MOVE_AND_MEASURE, res
END

PRO MOVE_AND_MEASURE, array
  measure_x = 50
  measure_y = 50
  
  print, MAX(array), MIN(array)
  
  wind_east = -1
  wind_north = 0

  FOR i = 0, 50 DO BEGIN
  ; Move by constant wind (including blanking shifted bits)
  array = SHIFT(array, [wind_east, wind_north])

  ; Get data out
  print, array[measure_x, measure_y]
  ENDFOR
END