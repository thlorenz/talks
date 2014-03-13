#!/usr/bin/env sh

rm -f bundle.*

browserify main.js -d | exorcist bundle.js.map > bundle.js 
