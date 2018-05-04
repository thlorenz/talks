'use strict'

const { sleep, slides, readFile, ITER } = require('./util')

function go(fn) {
  fn([])
}

go(async arr => {
  try {
    for (let i = 0; i < ITER; i++) {
      if (ITER % 10 === 0) await sleep(200)
      const src = await readFile(slides, 'utf8')
      arr.push(src)
    }
  } catch (err) {
    console.error(err)
  }
})
