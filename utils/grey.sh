#!/bin/sh

rm -f fig/src/grey/*.svg
cp -R fig/src/*.svg fig/src/grey/
cp -R fig/src/*.jpg fig/src/grey/
cp -R fig/src/*.png fig/src/grey/
#cp -R fig/src/*.pdf fig/src/grey/