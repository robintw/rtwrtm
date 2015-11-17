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
  
  result = RUN_RTM(70, 10, 0)
  ;nocloud = replicate(result.vertical[58], 30)
  
  cgWindow, 'plot', result.wavelengths, result.vertical
  
  save, result, filename="/Users/robin/Dropbox/IDL_Savs/Result_200x20_VLR_Cloud70_All.sav"
  
  ;cgWindow, 'plot', data
  ;cgWindow, 'oplot', nocloud, linestyle=1, /AddCmd
END