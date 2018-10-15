'use strict'
/* global print */

function log() {
  if (typeof print === 'function') {
    print.apply(null, arguments)
  } else {
    console.log.apply(console, arguments)
  }
}

function add(v1, v2) {
  return {
    x: v1.x + v2.x
  , y: v1.y + v2.y
  , z: v1.z + v2.z
  }
}

function subtract(v1, v2) {
  return {
    x: v1.x - v2.x
  , y: v1.y - v2.y
  , z: v1.z - v2.z
  }
}

// Warmup
const ITER = 1E3
let xsum = 0
for (let i = 0; i < ITER; i++) {
  for (let j = 0; j < ITER; j++) {
    xsum += add({ x: i, y: i, z: i }, { x: 1, y: 1, z: 1 }).x
    xsum += subtract({ x: i, y: i, z: i }, { x: 1, y: 1, z: 1 }).x
  }
}

log(`Completed warmup ${xsum}`)

// Rewarm
for (let i = 0; i < ITER; i++) {
  for (let j = 0; j < ITER; j++) {
    xsum += add({ y: i, x: i, z: i }, { x: 1, y: 1, z: 1 }).x
    xsum += subtract({ x: i, y: i, z: i }, { x: 1, y: 1, z: 1 }).x
  }
}

log(`Completed rewarm ${xsum}`)
