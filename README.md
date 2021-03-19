MPIR is a version of GMP, the GNU multi-precision arithmetic library, that works on Windows. This distribution of MPIR is optimized for simplicity and reliability of the build process on Windows.

Tradeoffs:

This distribution of MPIR does not include the assembly-language code optimized for particular CPU architectures, only the generic C code. If you want the highest possible performance on your CPU, you may need to use a different distribution.

It also does not include the C++ API. The library can still be used from C++, of course; you just won't get e.g. the overloaded iostream operators.

Requirements:

- Windows
- Visual C++ or compatible compiler

I haven't tried building MPIR with Clang, though I don't know any reason why it shouldn't work.

Usage:

Download the code and run `build.bat`, preferably in a command window that already has the Visual C++ environment variables set (according to the version of the compiler you have, and whether you want to build for 32 or 64 bits), though if they are not, the batch file will attempt to set them (for the compiler version I last used, and 64-bit). It will build both debug and release versions of the library.

Building the library takes on the order of tens of seconds. The batch file will then run the tests, which takes much longer; if you don't want to wait, just stop the process with ctrl-C.

To compile a program that uses MPIR, include the header file just as you would on UNIX:

```
#include <gmp.h>
```

And specify the include directory and library on the compiler command line with e.g.

```
cl /I\mpir /MTd foo.c \mpir\debug.lib
```

or

```
cl /I\mpir foo.c \mpir\release.lib
```
