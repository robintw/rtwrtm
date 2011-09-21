PRO RUN_CLOUD_SEQUENCE

  data = fltarr(30)

  ;cgWindow

  ;FOR i = 0, 30-1  DO BEGIN
  ;  index = i + 1
  ;  result = RUN_RTM(index, 10, 1)
  ;  ;cgWindow, 'plot', result.wavelengths, result.vertical, /addcmd
  ;  data[i] = result.vertical[58]
  ;ENDFOR

  ;cgWindow, 'plot', result.wavelengths, result.vertical
  
  result = RUN_RTM(0, 0, 0)
  ;nocloud = replicate(result.vertical[58], 30)
  
  cgWindow, 'plot', result.wavelengths, result.vertical
  
  ;!P.BACKGROUND = FSC_Color('white')
  ;!P.COLOR = FSC_Color('black')
  ;cgWindow, 'plot', data
  ;cgWindow, 'oplot', nocloud, linestyle=1, /AddCmd
END