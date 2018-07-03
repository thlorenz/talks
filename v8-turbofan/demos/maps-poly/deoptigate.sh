#!/bin/sh

rm -f v8.log      && \
$TURBO_ROOT/d8       \
  --trace-ic         \
  ./vector.js     && \
deoptigate
