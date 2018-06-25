./FlashReplace ./2_origin/src/ ./2f/src/
./FlashReplace ./4_origin/src/ ./4f/src/
rm -rf ./2f/src/cmodule
cp -r ./swc/cmodule ./2f/src/cmodule
rm -rf ./4f/src/cmodule
cp -r ./swc/cmodule ./4f/src/cmodule
