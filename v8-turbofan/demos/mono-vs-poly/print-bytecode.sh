#!/bin/sh

$TURBO_DEBUG_ROOT/d8           \
  --allow-natives-syntax       \
  --print-bytecode             \
  --code-comments              \
  --print-bytecode-filter=add* \
  ./add.js
