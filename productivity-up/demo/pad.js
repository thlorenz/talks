'use strict';

var fs = require('fs')
  , path = require('path')
  , cheerio = require('cheerio')

var html = fs.readFileSync(path.join(__dirname, 'index.html'), 'utf8');

var c = cheerio(html)
