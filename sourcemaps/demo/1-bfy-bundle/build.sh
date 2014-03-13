#!/usr/bin/env sh

rm -f bundle.*

browserify main.js -d  > bundle.js 
