'use strict'
/* global print */

const ITER = 1E8

function sum(a, b) {
  return a + b
}

const addOne = sum.bind(null, 1)
var res = 0

;(function loopFn() {
  for (var i = 0; i < ITER; i++) {
    res += addOne(i)
  }
})()

if (typeof console === 'object') console.log(res); else print(res)
