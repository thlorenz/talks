'use strict';

var http = require('http')
  , fs   = require('fs')
  , path = require('path')

var PORT      = process.env.PORT || 5000
  , indexFile = path.join(__dirname, 'index.html')
  , indexSrc  = fs.readFileSync(indexFile)

var indexInfo = { content : indexSrc };

function updateIndexInfo() {
  fs.readFile(indexFile, function onReadIndex(err, content) {
    if (err) return console.error(err);
    indexInfo = {
        content : content
      , length  : content.length
    };
  });
}

function serveIndex(opts) {
  opts.res.writeHead(200, {
      'Content-Type': 'text/html'
    , 'Content-Length': opts.length 
  })
  opts.res.end(opts.content);
}

function watchIndex(opts) {
  var watcher = fs.watch(indexFile, { persistent: true }, function onFileChanged(event) {
    watcher.close();
    if (event === opts.event) updateIndexInfo(); 
  })
}

var server = http.createServer();

server
  .on('request', function onRequest(req, res) {

    // Only available to troubleshoot memory leak
    if (req.url === '/gc') return collectGarbage(res);

    var html = indexInfo.content.toString();
    var opts = { res: res, content: html, length: html.length, event: 'change' };

    watchIndex(opts);

    if (req.url === '/') return serveIndex(opts);

    res.writeHead(404);
    res.end();
  })
  .on('listening', function onListening(address) {
    var a = server.address();
    console.log('listening: http://%s:%d', a.address, a.port);  
  })
  .listen(PORT);

updateIndexInfo();

// 
// Memory Leak Troubleshoot Support
//

require('heapdump');
console.log('pid', process.pid);

function collectGarbage(res) {
  if (typeof gc === 'function') { 
    gc();
    console.error('Collected garbage');
  }
  else console.error('Please run the server with --expose-gc to make gc function available.');

  res.writeHead(200);
  res.end();
}
