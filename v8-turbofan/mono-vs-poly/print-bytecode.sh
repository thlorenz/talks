#!/bin/sh

/Volumes/d/dev/js/sandboxes/d8box/turbo-debug/d8 \
  --allow-natives-syntax                         \
  --print-bytecode                               \
  --code-comments                                \
  --print-bytecode-filter=add*                   \
  ./add.js
