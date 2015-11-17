FUNCTION GET_DATA, path
  restore, path
  
  tot = result.left + result.vertical + result.right
  
  return, tot
END

PRO TO_SPECLIB
  c70 = GET_DATA("/Users/robin/Dropbox/IDL_Savs/Result_200x20_VLR_Cloud70_All.sav")
  c100 = GET_DATA("/Users/robin/Dropbox/IDL_Savs/Result_200x20_VLR_Cloud100_All.sav")
  c150 = GET_DATA("/Users/robin/Dropbox/IDL_Savs/Result_200x20_VLR_Cloud150_All.sav")
  c190 = GET_DATA("/Users/robin/Dropbox/IDL_Savs/Result_200x20_VLR_Cloud190_All.sav")
  nc = GET_DATA("/Users/robin/Dropbox/IDL_Savs/Result_200x20_VLR_NoCloud_All.sav")
  restore, "/Users/robin/Dropbox/IDL_Savs/Wavelengths.sav"
  restore, "/Users/robin/Dropbox/IDL_Savs/Result_200x20_50_30_10.sav"
  restore, "/Users/robin/Dropbox/IDL_Savs/Result_200x20_170_130_110_90.sav"
  restore, "/Users/robin/Dropbox/IDL_Savs/Result_200x20_AllEven.sav"
  
  data = [ [c10], [c20], [c30], [c40], [c50], [c60], [c70], [c80], [c90], [c100], [c110], [c120], [c130], [c140], [c150], [c160], [c170], [c180], [c190], [nc]   ]
  
  r_data = rebin(data[*, 19], 122, 20)
  
  diff = data - r_data
  
  help, diff
  
  avg_diff =  MEAN(diff, dimension=1)
  help, avg_diff
  print, avg_diff
  cgWindow, 'plot', avg_diff
  
  help, data
  ft = ENVI_FILE_TYPE("ENVI Spectral Library")
  sn = ['c10',  'c20',  'c30',  'c40',  'c50',  'c60',  'c70',  'c80',  'c90',  'c100',  'c110',  'c120',  'c130',  'c140',  'c150',  'c160',  'c170',  'c180',  'c190', 'nc']
  ENVI_ENTER_DATA, data, file_type=ft, spec_names=sn, wl=wavelengths, wavelength_unit=0
  
END