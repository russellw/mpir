md obj
cl /Foobj\ /I. /c *.c
if errorlevel 1 goto :eof

md obj\mpn
cl /Foobj\mpn\ /I. /c mpn\*.c
if errorlevel 1 goto :eof

md obj\mpz
cl /Foobj\mpz\ /I. /c mpz\*.c
if errorlevel 1 goto :eof

lib /out:mpir.lib obj\*.obj obj\mpn\*.obj obj\mpz\*.obj
if errorlevel 1 goto :eof

cl /I. test.c mpir.lib
