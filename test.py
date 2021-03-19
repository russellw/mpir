import os
import subprocess

for root, dirs, files in os.walk("."):
    for fname in files:
        if not fname.startswith('t-'):
            continue
        filename = os.path.join(root, fname)
        if os.path.splitext(filename)[1] != ".c":
            continue
        subprocess.check_call(f'cl /Fea /I. /Itests /MTd /WX /wd4477 {filename} tests/memory.c tests/misc.c tests/refmpn.c tests/trace.c mpir_debug.lib' )
        subprocess.check_call('a' )
