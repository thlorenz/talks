const http = require('http')
const server = http.createServer()

const hook = require('./_hook-print.init.js')
hook.enable()

server.listen()
