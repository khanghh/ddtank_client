#!/bin/bash
ver='20180210'
cp swf/swf_$ver/4.swf out/4f/library.swf
zip -u out/4f/4f.swc out/4f/library.swf -j out/4f/
rm out/4f/library.swf
cp out/4f/4f.swc swc/4f.swc
cp swf/swf_$ver/2.swf out/2f/library.swf
zip -u out/2f/2f.swc out/2f/library.swf -j out/2f/
rm out/2f/library.swf
cp out/2f/2f.swc swc/2f.swc
