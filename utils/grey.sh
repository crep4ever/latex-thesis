#!/bin/sh

rm -f fig/src/grey/*.*
cp -R fig/src/*.svg fig/src/grey/
cp -R fig/src/*.jpg fig/grey/
cp -R fig/src/*.png fig/grey/
#cp -R fig/src/*.pdf fig/src/grey/