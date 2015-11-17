PRO CREATE_FOR
  FOR i = 0, 200, 10 DO BEGIN
    print, " 'c" + STRTRIM(STRING(i), 2) + "', "
  ENDFOR
END