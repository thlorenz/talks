var PORT = 8000;

var http = require('http');
var server = http.createServer();
var fs = require('fs');

server
  .on('request', onrequest)
  .on('listening', onlistening)
  .listen(PORT);

function onrequest(req, res) {
  if (req.url === '/flush') {
    console.log('flushing');
    require('flush-all')();
    res.writeHead(200);
    res.end();
  }

  var src = fs.readFileSync(__filename, 'utf8');
  res.writeHead(200, { 'Content-Type': 'text/plain', 'Content-Length': src.length });
  res.end(src + '\r\n');
}

function onlistening() {
  console.log('HTTP server listening on port', PORT);
}

console.log('pid', process.pid);
console.log('cwd', process.cwd())
