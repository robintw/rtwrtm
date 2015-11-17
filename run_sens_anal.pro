PRO RUN_SENS_ANAL
  result_a = RUN_RTM(70, 10, 0)
  result_b = RUN_RTM(70, 10, 0)
  result_c = RUN_RTM(70, 10, 0)
  result_d = RUN_RTM(70, 10, 0)
  
  total_a = result_a.left + result_a.right + result_a.vertical
  total_b = result_b.left + result_b.right + result_b.vertical
  total_c = result_c.left + result_c.right + result_c.vertical
  total_d = result_d.left + result_d.right + result_d.vertical
  
  totals = [ [total_a], [total_b], [total_c], [total_d] ]
  
  
  cgWindow, 'plot', result.wavelengths, result.vertical
  
  save, totals, filename="/Users/robin/Dropbox/IDL_Savs/SensAnal_4.sav"
  
  ;cgWindow, 'plot', data
  ;cgWindow, 'oplot', nocloud, linestyle=1, /AddCmd
END