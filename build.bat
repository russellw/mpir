if "%VCINSTALLDIR%"=="" call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

del /s *.obj
del /s *.lib
del /s *.exe

md obj
cl /Foobj\ /I. /MP4 /MTd /WX /c *.c
if errorlevel 1 goto :eof

md obj\fft
cl /Foobj\fft\ /I. /MP4 /MTd /WX /c fft\*.c
if errorlevel 1 goto :eof

md obj\mpn
cl /Foobj\mpn\ /I. /MP4 /MTd /WX /c mpn\*.c
if errorlevel 1 goto :eof

md obj\mpz
cl /Foobj\mpz\ /I. /MP4 /MTd /WX /c mpz\*.c
if errorlevel 1 goto :eof

lib /out:mpir_debug.lib obj\*.obj obj\fft\*.obj obj\mpn\*.obj obj\mpz\*.obj
if errorlevel 1 goto :eof

cl /I. /MP4 /MTd /WX smoke_test.cc mpir_debug.lib
if errorlevel 1 goto :eof

smoke_test
