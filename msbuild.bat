pushd msvc\vs19
call msbuild.bat gc DLL x64 Debug +tests
call msbuild.bat gc LIB x64 Release +tests
popd
copy dll\x64\Debug\mpir.dll
