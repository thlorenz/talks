'use strict'

const http = require('http')
const fs   = require('fs')
const path = require('path')

const PORT      = process.env.PORT || 5000
const indexFile = path.join(__dirname, 'index.html')
const indexSrc  = fs.readFileSync(indexFile)
const watchers = []

let indexInfo = { content : indexSrc }

function updateIndexInfo() {
  fs.readFile(indexFile, function onReadIndex(err, content) {
    if (err) return console.error(err)
    indexInfo = {
        content : content
      , length  : content.length
    }
  })
}

function serveIndex(opts) {
  opts.res.writeHead(200, {
      'Content-Type': 'text/html'
    , 'Content-Length': opts.length
  })
  opts.res.end(opts.content)
}

function watchIndex(opts) {
  const watcher = fs.watch(indexFile, { persistent: true }, function onFileChanged(event) {
    watcher.close()
    if (event === opts.event) updateIndexInfo()
  })
  watchers.push(watcher)
}

const server = http.createServer()

server
  .on('request', function onRequest(req, res) {
    // Only available to troubleshoot memory leak
    if (req.url === '/gc') return collectGarbage(res)

    const html = indexInfo.content.toString()
    const opts = { res: res, content: html, length: html.length, event: 'change' }

    watchIndex(opts)

    if (req.url === '/') return serveIndex(opts)

    res.writeHead(404)
    res.end()
  })
  .on('listening', function onListening(address) {
    const a = server.address()
    console.log('listening: http://%s:%d', a.address, a.port)
  })
  .listen(PORT)

updateIndexInfo()

//
// Memory Leak Troubleshoot Support
//

require('heapdump')
console.log('pid', process.pid)

function collectGarbage(res) {
  if (typeof gc === 'function') {
    /* global gc */
    gc()
    console.error('Collected garbage')
  } else {
    console.error('Please run the server with --expose-gc to make gc function available.')
  }

  res.writeHead(200)
  res.end()
}
