'use strict'
/* global print */

function add(v1, v2) {
  return {
    x: v1.x + v2.x
  , y: v1.y + v2.y
  , z: v1.z + v2.z
  }
}

function substract(v1, v2) {
  return {
    x: v1.x - v2.x
  , y: v1.y - v2.y
  , z: v1.z - v2.z
  }
}

function toString(v) {
  return `{ x: ${v.x}, y: ${v.y}, z: ${v.z} }`
}

// Warmup
const ITER = 1E3
let xsum = 0
for (let i = 0; i < ITER; i++) {
  for (let j = 0; j < ITER; j++) {
    xsum += add({ x: i, y: i, z: i }, { x: 1, y: 1, z: 1 }).x
    xsum += substract({ x: i, y: i, z: i }, { x: 1, y: 1, z: 1 }).x
  }
}

print(`Completed warmup ${xsum}`)

const v1 = { x: 1, y: 1, z: 1 }
const v2 = { x: 2, y: 1, z: 3 }
const v3 = { x: 4, y: 2, z: 3 }

const vv1 = { y: 1, x: 1, z: 1 }
const vv2 = { y: 2, x: 3, z: 1 }

const add1 = add(v1, v2)
const add2 = add(v1, vv1)
const add3 = add(vv1, vv2)

const sub1 = substract(v1, v2)
const sub2 = substract(v1, v3)
const sub3 = substract(v2, v3)

print({
    add1: toString(add1)
  , add2: toString(add2)
  , add3: toString(add3)
  , sub1: toString(sub1)
  , sub2: toString(sub2)
  , sub3: toString(sub3)
})

// Rewarm
for (let i = 0; i < ITER; i++) {
  for (let j = 0; j < ITER; j++) {
    xsum += add({ y: i, x: i, z: i }, { x: 1, y: 1, z: 1 }).x
    xsum += substract({ x: i, y: i, z: i }, { x: 1, y: 1, z: 1 }).x
  }
}

print(`Completed rewarm ${xsum}`)
