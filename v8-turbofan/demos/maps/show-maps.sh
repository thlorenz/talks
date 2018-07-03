#!/bin/sh

rm -f v8.log      && \
$TURBO_ROOT/d8       \
  --trace-maps       \
  ./points.js     && \
v8-map-processor
