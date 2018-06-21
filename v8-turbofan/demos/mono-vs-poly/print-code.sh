#!/bin/sh

$TURBO_DEBUG_ROOT/d8     \
  --allow-natives-syntax \
  --print-code           \
  --redirect-code-traces \
  --code-comments        \
  --turbo-filter=addMono \
  ./add.js &&            \
mv code.asm results/code.addMono.asm

$TURBO_DEBUG_ROOT/d8     \
  --allow-natives-syntax \
  --print-code           \
  --redirect-code-traces \
  --code-comments        \
  --turbo-filter=addPoly \
  ./add.js &&            \
mv code.asm results/code.addPoly.asm
