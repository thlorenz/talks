'use strict';

var fs = require('fs');

fs.readFile(__filename, 'utf8', function (err, src) {
  if (err) return console.error(err);
  console.log(src.toUpperCase());
});
