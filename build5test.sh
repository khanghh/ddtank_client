#!/bin/bash
unzip -p out/5_test/5_test.swc library.swf > png/5.swf
echo "out/5_test/5_test.swc/library.swf > png/5.swf"
./png/EnDecryptPNG png/5.swf
