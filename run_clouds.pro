PRO RUN_CLOUDS  
  result = RUN_RTM(50, 10, 1)
  c50 = result.left + result.vertical + result.right
  
  result = RUN_RTM(30, 10, 1)
  c30 = result.left + result.vertical + result.right
  
  result = RUN_RTM(10, 10, 1)
  c10 = result.left + result.vertical + result.right
  
  save, c50, c30, c10, filename="/Users/robin/Dropbox/IDL_Savs/Result_200x20_50_30_10.sav"
  
  result = RUN_RTM(180, 10, 1)
  c180 = result.left + result.vertical + result.right
  result = RUN_RTM(160, 10, 1)
  c160 = result.left + result.vertical + result.right
  result = RUN_RTM(140, 10, 1)
  c140 = result.left + result.vertical + result.right
  result = RUN_RTM(120, 10, 1)
  c120 = result.left + result.vertical + result.right
  result = RUN_RTM(100, 10, 1)
  c100 = result.left + result.vertical + result.right
  result = RUN_RTM(80, 10, 1)
  c80 = result.left + result.vertical + result.right
  result = RUN_RTM(60, 10, 1)
  c60 = result.left + result.vertical + result.right
  result = RUN_RTM(40, 10, 1)
  c40 = result.left + result.vertical + result.right
  result = RUN_RTM(20, 10, 1)
  c20 = result.left + result.vertical + result.right
  
  ;nocloud = replicate(result.vertical[58], 30)
    
  save, c180, c160, c140, c120, c100, c80, c60, c40, c20, filename="/Users/robin/Dropbox/IDL_Savs/Result_200x20_AllEven.sav"
  
  cgWindow, 'plot', c10
  
  ;cgWindow, 'oplot', nocloud, linestyle=1, /AddCmd
END