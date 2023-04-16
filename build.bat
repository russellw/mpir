@echo off
if "%VCINSTALLDIR%"=="" call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

rem debug build

rd /s /q obj
md obj
cl /DDEBUG /DWANT_ASSERT=1 /Foobj\ /I. /MP4 /MTd /WX /c *.c
if errorlevel 1 goto :eof

md obj\fft
cl /DWANT_ASSERT=1 /Foobj\fft\ /I. /MP4 /MTd /WX /c fft\*.c
if errorlevel 1 goto :eof

md obj\mpf
cl /DWANT_ASSERT=1 /Foobj\mpf\ /I. /MP4 /MTd /WX /c mpf\*.c
if errorlevel 1 goto :eof

md obj\mpn
cl /DWANT_ASSERT=1 /Foobj\mpn\ /I. /MP4 /MTd /WX /c mpn\*.c
if errorlevel 1 goto :eof

md obj\mpq
cl /DWANT_ASSERT=1 /Foobj\mpq\ /I. /MP4 /MTd /WX /c mpq\*.c
if errorlevel 1 goto :eof

md obj\mpz
cl /DWANT_ASSERT=1 /Foobj\mpz\ /I. /MP4 /MTd /WX /c mpz\*.c
if errorlevel 1 goto :eof

md obj\printf
cl /DWANT_ASSERT=1 /Foobj\printf\ /I. /MP4 /MTd /WX /c printf\*.c
if errorlevel 1 goto :eof

md obj\scanf
cl /DWANT_ASSERT=1 /Foobj\scanf\ /I. /MP4 /MTd /WX /c scanf\*.c
if errorlevel 1 goto :eof

lib /out:debug.lib obj\*.obj obj\fft\*.obj obj\mpf\*.obj obj\mpn\*.obj obj\mpq\*.obj obj\mpz\*.obj obj\printf\*.obj obj\scanf\*.obj
if errorlevel 1 goto :eof

cl /I. /MP4 /MTd /WX smoke_test.cc debug.lib
if errorlevel 1 goto :eof

smoke_test
if errorlevel 1 goto :eof

rem release build

rd /s /q obj
md obj
cl /Foobj\ /I. /MP4 /O2 /WX /c *.c
if errorlevel 1 goto :eof

md obj\fft
cl /Foobj\fft\ /I. /MP4 /O2 /WX /c fft\*.c
if errorlevel 1 goto :eof

md obj\mpf
cl /Foobj\mpf\ /I. /MP4 /O2 /WX /c mpf\*.c
if errorlevel 1 goto :eof

md obj\mpn
cl /Foobj\mpn\ /I. /MP4 /O2 /WX /c mpn\*.c
if errorlevel 1 goto :eof

md obj\mpq
cl /Foobj\mpq\ /I. /MP4 /O2 /WX /c mpq\*.c
if errorlevel 1 goto :eof

md obj\mpz
cl /Foobj\mpz\ /I. /MP4 /O2 /WX /c mpz\*.c
if errorlevel 1 goto :eof

md obj\printf
cl /Foobj\printf\ /I. /MP4 /O2 /WX /c printf\*.c
if errorlevel 1 goto :eof

md obj\scanf
cl /Foobj\scanf\ /I. /MP4 /O2 /WX /c scanf\*.c
if errorlevel 1 goto :eof

lib /out:release.lib obj\*.obj obj\fft\*.obj obj\mpf\*.obj obj\mpn\*.obj obj\mpq\*.obj obj\mpz\*.obj obj\printf\*.obj obj\scanf\*.obj
if errorlevel 1 goto :eof

cl /I. /MP4 /O2 /WX smoke_test.cc release.lib
if errorlevel 1 goto :eof

smoke_test
if errorlevel 1 goto :eof

rem debug tests

for /r %%x in (t-*.c) do (
	rem disable warning about printf %l specifier for 64-bit integers
	rem the code is full of these, which were valid on UNIX
	rem while not valid on Windows, hopefully they will do no harm
	cl /DWANT_ASSERT=1 /Fea /I. /Itests /MTd /WX /wd4477 %%x tests/memory.c tests/misc.c tests/ref*.c tests/trace.c debug.lib
	if errorlevel 1 goto :eof
	a
	if errorlevel 1 goto :eof
)

rem release tests

for /r %%x in (t-*.c) do (
	cl /Fea /I. /Itests /O2 /WX /wd4477 %%x tests/memory.c tests/misc.c tests/ref*.c tests/trace.c release.lib
	if errorlevel 1 goto :eof
	a
	if errorlevel 1 goto :eof
)

rem done

rd /s /q obj
del *.obj
del *.exe

dir *.lib
