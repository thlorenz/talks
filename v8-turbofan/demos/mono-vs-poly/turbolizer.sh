#!/bin/sh

rm -f *.json          && \
$TURBO_DEBUG_ROOT/d8     \
  --allow-natives-syntax \
  --trace-turbo          \
  ./add.js            && \
turbolizer
