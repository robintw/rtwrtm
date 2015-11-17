PRO TO_NDVI, resamp
  ;resamp = resamp[*, 3:19]

  clrs = indgen(20) * 10
  clrs = clrs - 20
  clrs = clrs / 10.0
  
  clrs = clrs[3:19]


  nir = resamp[3, *]
  red = resamp[2, *]
  
  red = 0.05 * red
  nir = 0.40 * nir

  ndvi = (nir - red) / (nir + red)
  
  print, "Raw NDVI values"
  print, ndvi
  print
  
  n = N_ELEMENTS(ndvi)
  
  
  ndvi_diff = (ndvi - ndvi[n-1])
  print, "NDVI diff from NC"
  print, ndvi_diff
  print
  
  ndvi_diff_perc = ((ndvi - ndvi[n-1])/ndvi[n-1])*100
  
  print, "NDVI % diff from NC"
  print, ndvi_diff_perc
  print
  
  npp = -4.242 + (212.1 * abs(ndvi))
  
  print, "Raw NPP"
  print, npp
  print
  
  npp_diff = npp - npp[n-1]
  
  print, "NPP diff from NC"
  print, npp_diff
  print
  
  npp_diff_perc = ((npp - npp[n-1])/npp[n-1]) * 100
  
  print, "NPP % diff from NC"
  print, npp_diff_perc
  
  
  print, "Mean diff for each Landsat band"
  diff = resamp - rebin(resamp[*, n-1], 6, 17)
  diff = diff[*, 0:15]
  mean_diff = MEAN(diff[0:3], dimension=1)
  print
  
  
  save, clrs, ndvi, ndvi_diff, ndvi_diff_perc, npp_diff, npp_diff_perc, mean_diff, filename="/Users/robin/Dropbox/IDL_Savs/Outputs.sav"
  
  
  ;cgWindow, 'plot', clrs, ndvi_diff
  
  ; Do percentage change in each Landsat band here
  
  
  
END