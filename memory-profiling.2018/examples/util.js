'use strict'

const ITER = 1E6
const { promisify } = require('util')
const fs = require('fs')
const readFile = promisify(fs.readFile)
const path = require('path')
const slides = path.join(__dirname, '..', 'slides.md')

async function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms))
}

module.exports = { sleep, slides, readFile, ITER }
