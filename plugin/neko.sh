#!/bin/sh
rm -rf bin
haxe PlasmaCannon -neko plasma_cannon.n -cp ../console

rm ../console/plugins/plasma_cannon.n
cp plasma_cannon.n ../console/plugins
